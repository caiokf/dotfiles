---
description: Use when building HTML, dashboards, ops reports, mockups, or Vue components inside the skypaygroup monorepo (PLT / SlicePay / PayLater Travel) and the user wants branded or styled output. Pulls design tokens, fonts, and patterns from `packages/ui-vue/src/styles/tokens.css`. Defaults to dense data-dashboard aesthetic — KPI tiles, side-by-side environment cards, segmented bars, monospace numerals — and explicitly avoids editorial / newspaper / magazine layouts unless the user asks for that vibe. Triggers on "slice colors", "PLT styling", "ui-vue", "use the styleguide", "dashboard for slicepay", or any standalone HTML deliverable for the team.
---

# PLT / SlicePay Frontend Design

## Overview

The skypaygroup monorepo has a real design system in `packages/ui-vue`. Most asks for "an HTML file with these stats" or "a dashboard for X" want that system, not generic AI-design. The default aesthetic for this team is **data-forward dashboard**, not editorial publication.

**Core principle:** start from the tokens, default to dense / scannable, only switch to editorial / newspaper / magazine voice if the user explicitly asks.

## When to Use

- Building a standalone HTML deliverable for an ops report, rollout summary, or metrics snapshot
- Drafting a Vue mockup inside the monorepo
- The user mentions "slice colors", "slicepay blue", "the styleguide", "ui-vue", "PLT branding"
- Comparing two brands / environments side-by-side (SlicePay vs PLT) in one view

## When NOT to Use

- Marketing landing pages or external-facing customer-facing creative — those have their own design constraints
- The user explicitly asks for "newspaper", "editorial", "magazine", or "annual report" feel

## Tokens (Source of Truth)

Tokens live in `packages/ui-vue/src/styles/tokens.css`. Always reference them by CSS custom property, never hardcode hex values.

| Use case | Token | Value |
|---|---|---|
| SlicePay primary accent | `--color-primary-300` | `hsl(222 95 52)` — the brand blue |
| Primary hover / active | `--color-primary-400` | `hsl(222 87 36)` |
| Primary tint backgrounds | `--color-primary-100` | `hsl(219 79 94)` |
| PLT differentiator (when shown next to SlicePay) | `--color-info-300` | `hsl(241 98 73)` |
| Page background | `--color-neutral-100` | very light gray |
| Card surface | `--color-white` or `--color-light` | |
| Borders | `--color-neutral-200` / `--color-neutral-300` | |
| Body text | `--color-neutral-900` | |
| Secondary text | `--color-neutral-500` / `--color-neutral-600` | |
| Success state | `--color-success-300` / `--color-success-400` | green |
| Error / fail state | `--color-error-300` / `--color-error-400` | red |
| Spacing | `--gap-xs/sm/md/lg/xl` | `0.5/1/2/4/6rem` |
| Radius | `--border-radius-sm/md/lg/full` | |

The full palette includes `gray`, `blue`, `red`, `amber`, `green`, `teal`, `purple`, `pink`, plus themes `forest` / `desert` / `prairie` / `tundra`. Read the file when in doubt.

**Tokens that DO NOT exist** (per `packages/ui-vue/CLAUDE.md`): `--brand-blue`, `--text-primary`, `--text-secondary`, `--text-muted`, `--text-disabled`. Don't invent them.

## Typography

In-app fonts are **Mona Sans** (body, `--font-body`) and **PP Pangram Sans** (display, `--font-display`). Both are proprietary / paid.

For **standalone HTML deliverables** that can't bundle those fonts, use the Google Fonts fallback stack:

- Body: **Manrope** (closest free analog to Mona Sans — humanist sans, multiple weights)
- Numerals / code / IDs: **JetBrains Mono** (tabular figures via `font-variant-numeric: tabular-nums lining-nums`)

Never substitute Inter, Roboto, Arial, or plain `system-ui` as the primary face — they look generic and read as "AI default".

## Default Aesthetic: Dashboardy, Not Editorial

The team reads these as ops artifacts. Data must hit in the first viewport. Use:

- **Topbar** with brand dot, source / window / timestamp meta, status pill
- **KPI tile row** (3–4 across) with a 3px coloured accent stripe on the left edge of each card
- **Side-by-side environment cards** when comparing brands or envs (SlicePay accent = primary blue; PLT accent = info blue/purple)
- **Stacked segmented bars** for proportional outcomes (success / partial / fail) with a 3-up legend underneath
- **Dense data tables** with subtle row striping, small uppercase labels, monospace numerals, `badge` cells for categorical counts, inline mini progress bars for percentages
- **Aggregate / footer cards** grouped by currency or cohort
- Subtle borders (`--color-neutral-200`), not heavy drop shadows
- Tight type scale — most labels at `--font-xs` (0.75rem), values at `--font-md` to `--font-xl`
- Use a "live" pulse-dot pill in the topbar to signal "data is fresh / pipeline running"

**Avoid for ops deliverables:** drop caps, large serif display headlines, italic accent words on headlines, pull quotes, paper-grain textures, two-column flowing body text, ornamental section numbers (§ I, § II), masthead-style centred titles. Those belong in editorial pieces — different ask.

## Self-Contained HTML Deliverable Template

For a standalone `.html` file in `~/Downloads/`:

```html
<!doctype html>
<html lang="en"><head>
  <meta charset="utf-8" /><meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>…</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      /* Inline the tokens you actually use, copied verbatim from
         packages/ui-vue/src/styles/tokens.css */
      --color-primary-300: hsl(222 95 52);
      --color-neutral-100: hsl(220 14 96);
      --color-neutral-900: hsl(220 37 8);
      --color-success-300: hsl(147 93 34);
      --color-error-300:   hsl(2 86 59);
      --color-info-300:    hsl(241 98 73);
      --gap-sm: 1rem; --gap-md: 2rem;
      --font-body: 'Manrope', system-ui, sans-serif;
      --font-mono: 'JetBrains Mono', ui-monospace, monospace;
    }
    body { background: var(--color-neutral-100); color: var(--color-neutral-900); font-family: var(--font-body); }
    .kpi { background: white; border: 1px solid var(--color-neutral-200); border-radius: 0.5rem; padding: 1.25rem; position: relative; }
    .kpi::before { content:""; position:absolute; inset:0 auto 0 0; width:3px; background: var(--color-primary-300); }
    /* …etc, use nested CSS, no preprocessor */
  </style>
</head><body>…</body></html>
```

## CSS Rules (Codebase Convention)

From `.claude/rules/css.md`:

- **No Tailwind, no utility classes, no CSS-in-JS, no preprocessors.** Plain CSS only.
- All colours, spacing, type, radius via custom properties.
- Native CSS nesting (`&`) is fine. No SASS / LESS.
- Inside Vue: atoms in `ui-vue` use unscoped `<style>`; everything else uses `<style scoped>`.

For standalone HTML files those rules still apply — inline only the tokens you reference, use nested CSS, no utility classes.

## Common Mistakes

| Mistake | Fix |
|---|---|
| Hardcoded `#3B82F6`-style colours | Use `--color-primary-300` etc. |
| `--brand-blue` / `--text-primary` | Those don't exist — use `--color-primary-300` and `--color-neutral-900` |
| Inter / Roboto / system-ui as body face | Use Manrope (Google Fonts) for standalone HTML; `--font-body` inside the monorepo |
| Editorial drop caps + serif display for an ops report | Stay dashboardy — KPIs first, no decorative typography |
| Both env cards in the same accent colour | Differentiate: SlicePay = primary blue, PLT = info blue/purple |
| Numerals in proportional figures | Apply `font-variant-numeric: tabular-nums lining-nums` and use mono for any numeric column |
| Importing `@plt/ui-vue/styles/...` in monorepo Vue | That path isn't exported — use `@plt/ui-vue/src/styles/tokens.css` |
| Defaulting to a "purple gradient on white" template | Banned — that's the generic-AI tell |

## Quick Reference: Layout Patterns

- **KPI tile**: outline card + left accent stripe + uppercase tiny label + 2rem bold number + tiny supporting line
- **Env compare card**: header row (brand dot + name + total count) → 2×2 stat sub-grid → full-width stacked bar → 3-up legend
- **Detail table**: light gray header row, badges for categorical counts, monospace for IDs/numbers, inline 80px progress bar + percent for ratios
- **Star row in a table**: subtle blue-tint gradient background + ★ glyph in the first cell
- **Status pill**: small radius-full chip with a pulsing dot animation for "live"

## Related

- `packages/ui-vue/src/styles/tokens.css` — full token list
- `packages/ui-vue/CLAUDE.md` — what NOT to assume about the system
- `.claude/rules/css.md` — codebase CSS conventions
