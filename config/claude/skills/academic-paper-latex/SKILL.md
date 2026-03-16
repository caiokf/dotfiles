---
name: caiokf:academic-paper-latex
description: Use when writing a short (4-6 page) academic/technical paper in LaTeX — guides structure, section balance, page budget, citation style, and Tectonic compilation. Covers introduction, background, methodology, implementation, and conclusions for research papers.
---

# Academic Paper in LaTeX (Short Format)

## Overview

Guide for writing concise (4-page + references) academic papers in LaTeX, compiled with Tectonic. Optimized for technical/methodology papers that need to pack dense content into limited space.

## Paper Structure & Page Budget (4 pages)

| Section | Pages | Purpose |
|---------|-------|---------|
| **Title + Abstract** | ~0.3 | Hook + 150-word summary of problem, method, key result |
| **1. Introduction** | ~0.6 | Problem statement, gap, contribution, paper outline |
| **2. Background** | ~0.5 | Why existing approaches fail, theoretical foundations |
| **3. Methodology** | ~1.0 | What you built — the design, phases, dimensions |
| **4. Implementation** | ~1.0 | How it works — algorithms, formulas, scoring |
| **5. Discussion** | ~0.3 | Limitations, implications, what this enables |
| **6. Conclusion** | ~0.3 | Summary of contributions, future work |
| **References** | separate | ~15-25 refs, not counted in page limit |

**Total: ~4.0 pages + references**

## Section Writing Guidelines

### Abstract (150 words max)
- Sentence 1: Problem and who it affects
- Sentence 2: Why existing approaches fail
- Sentence 3: What this paper presents
- Sentence 4-5: Key method/approach
- Sentence 6: Main result or contribution

### 1. Introduction (~0.6 page)
- **Open with the human problem** — not the technical solution
- State the gap in 1-2 sentences
- List 3-4 specific contributions (numbered)
- End with paper structure paragraph
- Do NOT over-explain background here (that's Section 2)

### 2. Background & Related Work (~0.5 page)
- Group related work by theme, not chronologically
- For each group: what they do, what they miss
- End with: "To our knowledge, no existing system combines X, Y, and Z"
- Be fair but clear about limitations of prior work

### 3. Methodology (~1.0 page)
- Describe the WHAT and the WHY of design decisions
- Use a figure or table to summarize phases/dimensions
- For each major component: what it is, why it's needed, how it differs
- Avoid implementation details here (save for Section 4)

### 4. Implementation (~1.0 page)
- The HOW — algorithms, formulas, scoring
- Use equations with proper LaTeX formatting
- Use a table for weights/parameters
- Show the key formula(s) prominently
- Keep explanations tight — let math speak

### 5. Discussion (~0.3 page)
- Acknowledge limitations honestly (no validation data yet, etc.)
- State what this enables that wasn't possible before
- Identify 2-3 directions for future work

### 6. Conclusion (~0.3 page)
- Restate contributions (not the problem)
- One forward-looking sentence

## LaTeX Template (Two-Column, IEEE-style)

```latex
\documentclass[10pt,twocolumn]{article}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath,amssymb}
\usepackage{graphicx}
\usepackage{booktabs}
\usepackage{hyperref}
\usepackage[margin=0.75in]{geometry}
\usepackage{natbib}
\usepackage{enumitem}
\setlist{nosep,leftmargin=*}

\title{Paper Title}
\author{Author Name}
\date{}

\begin{document}
\maketitle
\begin{abstract}
...
\end{abstract}

\section{Introduction}
\section{Background}
\section{Methodology}
\section{Implementation}
\section{Discussion}
\section{Conclusion}

\bibliographystyle{plainnat}
\bibliography{refs}
\end{document}
```

## Space-Saving Techniques

- **Two-column layout** with 0.75in margins
- **10pt font** (not 11 or 12)
- **`\setlist{nosep}`** removes list spacing
- **`\vspace{-Xpt}`** between sections if needed
- Tables with `\small` or `\footnotesize`
- Combine related items into single tables
- Use inline math (`$x$`) not display math when possible
- Avoid redundancy between sections

## Compilation with Tectonic

```bash
# Basic compilation (handles multiple passes automatically)
tectonic -X compile paper.tex

# With bibliography
tectonic -X compile paper.tex  # tectonic handles bibtex automatically
```

Tectonic auto-downloads packages, runs multiple passes, and handles bibtex/biber. One command, no configuration.

## Common Mistakes

- **Too much background**: 4-page papers need surgical precision — cut any "obvious" context
- **Implementation before methodology**: Reader needs the WHAT before the HOW
- **Listing features instead of contributions**: "We use RIASEC" is a feature; "We adapt RIASEC through behavioral observation rather than self-report" is a contribution
- **Passive voice overuse**: Active voice is shorter and clearer
- **Missing the "so what"**: Every section should connect back to why it matters

## Quality Checklist

- [ ] Abstract ≤ 150 words, self-contained
- [ ] Introduction states contributions explicitly
- [ ] Every design choice has a WHY
- [ ] Key formulas are present and explained
- [ ] Tables/figures have captions and are referenced in text
- [ ] References are complete and consistently formatted
- [ ] Paper compiles cleanly with tectonic
- [ ] Total ≤ 4 pages (excluding references)
