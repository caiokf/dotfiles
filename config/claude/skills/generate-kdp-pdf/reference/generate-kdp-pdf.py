#!/usr/bin/env python3
"""
Generate KDP-compliant paperback PDFs from markdown.

Usage:
  python3 generate-kdp-pdf.py --input manuscript.md --output book.pdf
  python3 generate-kdp-pdf.py --input manuscript.md --output book.pdf --trim 6x9 --title "My Book"
  python3 generate-kdp-pdf.py --input manuscript.md --output book.pdf --author "Name" --toc

Requires: pandoc (3.x+), typst (0.12+)
"""

import argparse
import os
import re
import subprocess
import sys
import tempfile

# KDP trim sizes (width x height in inches)
TRIM_SIZES = {
    '5x8':     (5.0, 8.0),
    '5.5x8.5': (5.5, 8.5),
    '6x9':     (6.0, 9.0),
    '7x10':    (7.0, 10.0),
}

# KDP inside (gutter) margin requirements by page count
GUTTER_MARGINS = [
    (150,  0.375),
    (300,  0.500),
    (500,  0.625),
    (700,  0.750),
    (828,  0.875),
]

# Comfortable outside/top/bottom margins (well above 0.25in KDP minimum)
DEFAULT_OUTSIDE = 0.55
DEFAULT_TOP = 0.70
DEFAULT_BOTTOM = 0.70

# Words per page estimate for different trim sizes
WORDS_PER_PAGE = {
    '5x8':     225,
    '5.5x8.5': 250,
    '6x9':     275,
    '7x10':    350,
}


def estimate_pages(word_count, trim):
    """Estimate page count from word count for margin selection."""
    wpp = WORDS_PER_PAGE.get(trim, 275)
    # Add ~15% for headings, whitespace, TOC, title page
    return int(word_count / wpp * 1.15) + 10


def get_gutter_margin(estimated_pages):
    """Get KDP-compliant gutter margin for page count, with comfortable padding."""
    for max_pages, margin in GUTTER_MARGINS:
        if estimated_pages <= max_pages:
            # Add 0.125in comfort padding above KDP minimum
            return margin + 0.125
    return 1.0  # Safety fallback for very long books


def count_words(filepath):
    """Count words in a markdown file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        text = f.read()
    # Strip frontmatter
    text = re.sub(r'^---\s*\n.*?\n---\s*\n', '', text, flags=re.DOTALL)
    return len(text.split())


def get_template_path():
    """Get path to the bundled Typst template."""
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), 'kdp-pandoc.typ')


def generate_pdf(args):
    """Generate a KDP-compliant PDF."""
    # Count words and estimate pages
    word_count = count_words(args.input)
    estimated_pages = estimate_pages(word_count, args.trim)
    gutter = get_gutter_margin(estimated_pages)
    trim_w, trim_h = TRIM_SIZES[args.trim]

    print(f"Manuscript: {word_count:,} words")
    print(f"Trim size:  {trim_w}\" x {trim_h}\"")
    print(f"Est. pages: ~{estimated_pages}")
    print(f"Gutter:     {gutter}in (KDP min: {gutter - 0.125}in for this page range)")
    print(f"Outside:    {DEFAULT_OUTSIDE}in  Top/Bottom: {DEFAULT_TOP}in")
    print()

    # Build pandoc command
    template = get_template_path()
    if not os.path.exists(template):
        print(f"ERROR: Template not found at {template}")
        sys.exit(1)

    # Two-step build: pandoc → .typ, then typst → .pdf
    # (pandoc's --pdf-engine=typst has rendering bugs with place elements)
    typ_path = args.output.rsplit('.', 1)[0] + '.typ'

    cmd = [
        'pandoc', args.input,
        '-o', typ_path,
        f'--template={template}',
    ]

    # KDP layout variables
    cmd.extend([
        '-V', f'kdp-trim-w={trim_w}in',
        '-V', f'kdp-trim-h={trim_h}in',
        '-V', f'kdp-margin-inside={gutter}in',
        '-V', f'kdp-margin-outside={DEFAULT_OUTSIDE}in',
        '-V', f'kdp-margin-top={DEFAULT_TOP}in',
        '-V', f'kdp-margin-bottom={DEFAULT_BOTTOM}in',
    ])

    # Optional metadata
    if args.title:
        cmd.extend(['-V', f'title={args.title}'])
    if args.subtitle:
        cmd.extend(['-V', f'subtitle={args.subtitle}'])
    if args.author:
        cmd.extend(['-V', f'author={args.author}'])
    if args.font:
        cmd.extend(['-V', f'kdp-font={args.font}'])
    if args.fontsize:
        cmd.extend(['-V', f'kdp-fontsize={args.fontsize}'])

    # TOC
    if args.toc:
        cmd.extend(['--toc', '--toc-depth=1'])

    print(f"Generating PDF...")
    result = subprocess.run(cmd, capture_output=True, text=True, timeout=600)

    if result.returncode != 0:
        print(f"ERROR: pandoc failed")
        print(result.stderr[:500])
        sys.exit(1)

    # Step 2: compile .typ to .pdf with typst
    result = subprocess.run(
        ['typst', 'compile', typ_path, args.output],
        capture_output=True, text=True, timeout=600,
    )
    os.unlink(typ_path)

    if result.returncode != 0:
        print(f"ERROR: typst compile failed")
        print(result.stderr[:500])
        sys.exit(1)

    # Report results
    size_mb = os.path.getsize(args.output) / (1024 * 1024)

    # Get actual page count
    pages_result = subprocess.run(
        ['strings', args.output],
        capture_output=True, text=True
    )
    page_counts = re.findall(r'/Count (\d+)', pages_result.stdout)
    actual_pages = max(int(p) for p in page_counts) if page_counts else estimated_pages

    print(f"\nGenerated: {args.output}")
    print(f"Size:      {size_mb:.1f} MB")
    print(f"Pages:     {actual_pages}")

    # Validate margins against actual page count
    for max_pages, min_margin in GUTTER_MARGINS:
        if actual_pages <= max_pages:
            if gutter >= min_margin:
                print(f"Margins:   KDP compliant (gutter {gutter}in >= {min_margin}in min for {actual_pages} pages)")
            else:
                print(f"WARNING:   Gutter {gutter}in is below {min_margin}in minimum for {actual_pages} pages!")
                print(f"           Re-run to recalculate with actual page count.")
            break

    # Spine width
    spine = actual_pages * 0.0025
    print(f"Spine:     ~{spine:.2f}in (for cover design)")

    if actual_pages >= 79:
        print(f"Spine text: YES (>= 79 pages)")
    else:
        print(f"Spine text: NO (< 79 pages, spine too narrow)")


def main():
    parser = argparse.ArgumentParser(
        description='Generate KDP-compliant paperback PDFs from markdown'
    )
    parser.add_argument('--input', '-i', required=True,
                        help='Input markdown file')
    parser.add_argument('--output', '-o', required=True,
                        help='Output PDF file')
    parser.add_argument('--trim', default='6x9',
                        choices=TRIM_SIZES.keys(),
                        help='Trim size (default: 6x9)')
    parser.add_argument('--title', help='Book title')
    parser.add_argument('--subtitle', help='Book subtitle')
    parser.add_argument('--author', help='Author name')
    parser.add_argument('--font', default=None,
                        help='Font family (default: Georgia)')
    parser.add_argument('--fontsize', default=None,
                        help='Font size, e.g. 10.5pt (default: 10.5pt)')
    parser.add_argument('--toc', action='store_true',
                        help='Include table of contents')

    args = parser.parse_args()

    if not os.path.exists(args.input):
        print(f"ERROR: Input file not found: {args.input}")
        sys.exit(1)

    # Check dependencies
    for tool in ('pandoc', 'typst'):
        result = subprocess.run(['which', tool], capture_output=True)
        if result.returncode != 0:
            print(f"ERROR: {tool} not found. Install with: brew install {tool}")
            sys.exit(1)

    generate_pdf(args)


if __name__ == '__main__':
    main()
