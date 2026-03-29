---
name: generate-kdp-pdf
description: Use when generating print-ready PDFs for Amazon KDP paperback — handles trim sizes, margin calculations by page count, font embedding, and KDP manuscript compliance. Triggers on "KDP", "print on demand", "paperback PDF", "book formatting", "print-ready".
---

# Generate KDP-Compliant PDFs

## Overview

Generate print-ready paperback PDFs from markdown that conform to Amazon KDP manuscript formatting requirements. Uses pandoc + Typst for typesetting.

## Requirements

- `pandoc` (3.x+)
- `typst` (0.12+)
- Both available via Homebrew: `brew install pandoc typst`

## Quick Reference

### KDP Margin Requirements

| Page Count | Inside (Gutter) | Outside/Top/Bottom Min |
|------------|-----------------|----------------------|
| 24–150     | 0.375in         | 0.25in (no bleed)    |
| 151–300    | 0.500in         | 0.25in               |
| 301–500    | 0.625in         | 0.25in               |
| 501–700    | 0.750in         | 0.25in               |
| 701–828    | 0.875in         | 0.25in               |

With bleed: outside/top/bottom minimum increases to 0.375in.

### Common Trim Sizes

| Size | Use Case |
|------|----------|
| 5" x 8" | Fiction, compact non-fiction |
| 5.5" x 8.5" | General non-fiction |
| **6" x 9"** | **Most popular non-fiction** |
| 7" x 10" | Textbooks, illustrated |

### Other KDP Requirements

- Font: minimum 7pt, must be embedded
- Images: 300 DPI minimum
- No bleed needed for text-only interiors
- No crop marks, watermarks, or annotations
- Single-page layout (no spreads)
- Max 4 consecutive blank pages mid-book, 10 at end
- Min line weight: 0.75pt for rules/borders
- Spine text requires 79+ pages

## Usage

### One-command generation

```bash
python3 <skill>/reference/generate-kdp-pdf.py \
  --input manuscript.md \
  --output book-kdp.pdf \
  --title "Book Title" \
  --subtitle "Optional Subtitle" \
  --author "Author Name" \
  --trim 6x9
```

### Supported trim sizes

`5x8`, `5.5x8.5`, `6x9` (default), `7x10`

### What the script does

1. Estimates page count from word count to select correct gutter margin
2. Generates a Typst template with KDP-compliant margins
3. Runs pandoc with the template to produce the PDF
4. Reports final page count and confirms margin compliance

### Manual pandoc command

If you prefer to run pandoc directly:

```bash
pandoc input.md \
  -o output.pdf \
  --pdf-engine=typst \
  --template=<skill>/reference/kdp-pandoc.typ \
  --toc --toc-depth=1 \
  -V title="Title" \
  -V subtitle="Subtitle" \
  -V author="Author"
```

The bundled `kdp-pandoc.typ` template defaults to 6x9 with margins for 301–500 pages.

## Customization

### Changing fonts

Edit the `set text(font: ...)` line in the generated Typst template. Good choices for print:
- **Georgia** — warm serif, excellent readability
- **Palatino** / **Book Antiqua** — classic book font
- **Garamond** — elegant, slightly smaller x-height
- **Charter** — clean, modern serif

### Adjusting font size

10–11pt is standard for trade paperback. The template defaults to 10.5pt.

### Cover

KDP requires a separate cover PDF. Spine width = page count × 0.0025in + cover stock.
KDP provides a free Cover Creator tool, or upload your own cover PDF.

## Common Mistakes

- **Wrong gutter margin for page count** — the script handles this automatically
- **Using system fonts not available on KDP** — embed all fonts (Typst does this by default)
- **Forgetting TOC** — add `--toc` flag to pandoc
- **Bleed settings on text-only books** — don't enable bleed unless images touch page edges
