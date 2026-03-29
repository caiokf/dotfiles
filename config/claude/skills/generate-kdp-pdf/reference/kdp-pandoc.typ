// KDP Paperback — pandoc Typst template
// Default: 6"x9" trim, margins for 301-500 pages
// Conforms to Amazon KDP manuscript formatting requirements
//
// Usage with pandoc:
//   pandoc input.md -o output.pdf --pdf-engine=typst \
//     --template=kdp-pandoc.typ --toc --toc-depth=1 \
//     -V title="Title" -V subtitle="Subtitle" -V author="Author"
//
// Pandoc variables supported:
//   title, subtitle, author, toc, toc-depth,
//   kdp-trim-w, kdp-trim-h, kdp-margin-inside, kdp-margin-outside,
//   kdp-margin-top, kdp-margin-bottom, kdp-font, kdp-fontsize

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

#set table(inset: 6pt, stroke: none)

// Page setup — KDP compliant
#set page(
  width: $if(kdp-trim-w)$$kdp-trim-w$$else$6in$endif$,
  height: $if(kdp-trim-h)$$kdp-trim-h$$else$9in$endif$,
  margin: (
    inside: $if(kdp-margin-inside)$$kdp-margin-inside$$else$0.75in$endif$,
    outside: $if(kdp-margin-outside)$$kdp-margin-outside$$else$0.55in$endif$,
    top: $if(kdp-margin-top)$$kdp-margin-top$$else$0.7in$endif$,
    bottom: $if(kdp-margin-bottom)$$kdp-margin-bottom$$else$0.7in$endif$,
  ),
)

// Page numbers — centered bottom, skip first pages
#set page(footer: context {
  let page-num = counter(page).get().first()
  if page-num > 2 {
    align(center, text(size: 9pt, str(page-num)))
  }
})

// Typography
#set text(
  font: $if(kdp-font)$"$kdp-font$"$else$"Georgia"$endif$,
  size: $if(kdp-fontsize)$$kdp-fontsize$$else$10.5pt$endif$,
  lang: "en",
)

#set par(
  leading: 0.65em,
  first-line-indent: 1.5em,
  justify: true,
)

// Headings
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1.5em)
  text(size: 15pt, weight: "bold", it.body)
  v(0.8em)
  par(first-line-indent: 0pt, [])
}

#show heading.where(level: 2): it => {
  v(1.2em)
  text(size: 12.5pt, weight: "bold", it.body)
  v(0.6em)
  par(first-line-indent: 0pt, [])
}

#show heading.where(level: 3): it => {
  v(1em)
  text(size: 11pt, weight: "bold", it.body)
  v(0.5em)
  par(first-line-indent: 0pt, [])
}

#show heading.where(level: 4): it => {
  v(0.8em)
  text(size: 10.5pt, weight: "bold", style: "italic", it.body)
  v(0.4em)
  par(first-line-indent: 0pt, [])
}

// Emphasis
#show emph: set text(style: "italic")
#show strong: set text(weight: "bold")

// Title page
#page(margin: (x: 1in, y: 1.5in), footer: [])[
  #align(center)[
    #v(2.5in)
    $if(title)$
    #text(size: 24pt, weight: "bold")[$title$]
    $endif$
    $if(subtitle)$
    #v(0.6em)
    #text(size: 14pt, style: "italic")[$subtitle$]
    $endif$
    $if(author)$
    #v(2em)
    $for(author)$
    #text(size: 12pt)[$author$]
    #linebreak()
    $endfor$
    $endif$
    #v(1.5em)
    #text(size: 11pt)[2026]
  ]
]

// Table of contents
$if(toc)$
#page(footer: [])[
  #outline(
    title: "Contents",
    depth: $toc-depth$,
    indent: 1.5em,
  )
]
$endif$

$body$
