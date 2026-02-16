---
name: apps-appstore-assets
description: Use when preparing App Store Connect marketing assets for macOS/iOS apps — combines metadata strategy (name, subtitle, keywords, description) with screenshot planning, dimensions, framing, and localization.
---

# App Store Assets (Metadata + Screenshots)

## Overview

Unified workflow for App Store listing quality. This skill covers both discoverability (name/subtitle/keywords) and conversion (screenshots and visual story), since these are tightly linked and should be planned together.

## When to Use

- Preparing first App Store submission
- Refreshing listing assets for a major update
- Localizing store assets for new regions
- User asks for store listing, keywords, App Store screenshots, or ASO prep

## Scope

1. **Metadata**: app name, subtitle, promo text, description, keywords, category, age rating, privacy policy link
2. **Screenshots**: device classes, required dimensions, sequence strategy, captions, localization variants

## Step 1: Positioning and Competitor Pass

Before writing fields, capture:
- Top 5-10 direct competitors (name, subtitle style, positioning)
- Core use case this app wins on
- Primary audience and language markets

Output:
- One-sentence value proposition
- 3-5 candidate search intents

## Step 2: Metadata Draft (App Store Connect)

| Field | Limit | Notes |
|---|---|---|
| App Name | 30 chars | Searchable. Distinctive, not generic. |
| Subtitle | 30 chars | Searchable. Complements name, no repetition. |
| Promo Text | 170 chars | Updateable without new binary. |
| Description | 4000 chars | Conversion copy, not App Store search ranking. |
| Keywords | 100 chars | Comma-separated, no spaces after commas. |

### Keyword rules

- Do not repeat words already in app name/subtitle
- Avoid competitor trademarks
- Prefer concise stems over verbose phrases
- Prioritize relevance over volume-only guesses

## Step 3: Screenshot Plan

### Minimum practical target set

| Platform | Recommended set |
|---|---|
| iPhone | 6.9" or 6.7" + 5.5" coverage when required |
| iPad (if universal) | 13"/12.9" set |
| macOS | 2560 x 1600 recommended (1280 x 800 minimum) |

### Story sequence (first 2 matter most)

1. Hero value (what the app does instantly)
2. Key differentiator (why this app over others)
3. Secondary feature
4. Customization or workflow depth
5. Trust/proof or polish feature

For each screenshot, define:
- Feature shown
- One-line caption (if using framed style)
- Required in-app state/data
- Locale variants needed

## Step 4: Localization Pass

For each target locale:
- Localize metadata fields (not just screenshots)
- Re-capture screenshots in localized UI where text is visible
- Validate RTL image/layout behavior for Arabic/Hebrew where applicable

Minimum recommendation: English + largest non-English market.

## Step 5: Final QA Checklist

- [ ] Metadata fields stay within limits
- [ ] Keywords are deduplicated and compact
- [ ] First 2 screenshots communicate value without extra explanation
- [ ] Screenshots use realistic, production-like data
- [ ] Assets match current shipped UI
- [ ] Localized text is natural and not machine-literal

## Common Mistakes

| Mistake | Fix |
|---|---|
| Treating screenshots and listing copy separately | Build one cohesive story across both |
| Repeating keywords across name/subtitle/keywords field | Use unique terms in keyword field |
| Overloading screenshots with tiny text | Keep one clear message per image |
| Localizing captions but not in-app screenshot content | Capture localized UI, not only translated overlays |
