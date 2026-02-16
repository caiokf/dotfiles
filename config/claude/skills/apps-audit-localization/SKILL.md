---
name: apps-audit-localization
description: Use when validating translations and localized layouts in a macOS/iOS app — checks string catalogs for missing translations, identifies truncation risks in compact UI, verifies RTL layout correctness, validates date/number formatting uses locale-aware APIs, and guides pseudo-localization testing.
---

# Localization QA for Apple Apps

## Overview

Validate that an app's localization is complete and visually correct across all supported languages. Focus on missing strings, layout breakage, and locale-sensitive formatting — the issues that are invisible in the development language but break in production.

## When to Use

- After adding or updating translations
- Before release of an app with multiple languages
- After App Store rejection for localization issues
- User says "check translations", "validate localization", "test RTL"

## Audit Steps

### 1. String catalog completeness

Check `.xcstrings` files for missing translations:

```bash
# Parse the JSON structure and find entries missing translations
# Each entry should have a "localizations" dict with keys for each supported language
```

Look for:
- [ ] Entries with no translations (only the source language)
- [ ] Entries marked "needs review" or "stale"
- [ ] Pluralization rules missing for languages that need them (Arabic, Russian, Polish have complex plural forms)
- [ ] String interpolation mismatches (`%@`, `%d` count differs between languages)

### 2. Truncation risk

Identify strings likely to truncate in compact UI:

**High-risk areas:**
- Menu bar items and status bar text
- Button labels in fixed-width containers
- Tab titles, segmented controls
- Table/list row metadata (subtitle text)

**Size expansion by language (approximate):**
| Source length | German | French | Russian | Arabic |
|---|---|---|---|---|
| < 10 chars | +200% | +150% | +100% | +80% |
| 10-20 chars | +100% | +80% | +60% | +50% |
| 20+ chars | +40% | +30% | +30% | +25% |

Check that layouts use flexible widths or `lineLimit` with truncation where appropriate.

### 3. RTL layout

For RTL languages (Arabic, Hebrew, Farsi):

- [ ] `.environment(\.layoutDirection, .rightToLeft)` is set or inherited
- [ ] Leading/trailing used instead of left/right (SwiftUI default, but check any explicit `.frame(alignment:)`)
- [ ] Icons that imply direction are flipped (arrows, progress indicators)
- [ ] Text alignment follows reading direction
- [ ] Padding uses `.leading`/`.trailing`, not `.left`/`.right`

### 4. Locale-aware formatting

- [ ] Dates use `DateFormatter` with explicit `.locale` or the environment locale
- [ ] Numbers use `NumberFormatter` for user-facing display
- [ ] No hardcoded AM/PM, date separators, or decimal points
- [ ] Currency formatting uses locale (if applicable)
- [ ] Time format respects 12h/24h system preference or app setting

### 5. Visual inspection

For each supported language, check:
- [ ] No overlapping text
- [ ] No clipped text (especially in compact UI like menu bars)
- [ ] No layout breaks in scroll views
- [ ] Images with embedded text are localized (or avoid embedded text)

## Quick Test Method

Preview layouts with long strings by temporarily setting development locale to German (tends to be longest) and Arabic (RTL). In SwiftUI previews:

```swift
MyView()
    .environment(\.locale, Locale(identifier: "de"))

MyView()
    .environment(\.locale, Locale(identifier: "ar"))
    .environment(\.layoutDirection, .rightToLeft)
```

## Common Mistakes

| Mistake | Fix |
|---|---|
| Only testing in English | Test at minimum: German (length), Arabic (RTL), Japanese (character width) |
| Hardcoded string widths | Use flexible layout, not fixed `.frame(width:)` for text |
| Concatenating translated strings | Use string interpolation in the catalog, not runtime concatenation |
| Ignoring plural forms | Russian/Arabic/Polish need more than "one" and "other" |
| Assuming all locales use left-to-right | Always use leading/trailing, never left/right |
