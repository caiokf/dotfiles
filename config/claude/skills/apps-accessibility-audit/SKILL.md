---
name: apps-accessibility-audit
description: Use when auditing a macOS/iOS SwiftUI app for accessibility compliance — checks VoiceOver labels and hints on interactive elements, keyboard navigation, Dynamic Type support, color contrast ratios, focus order, and accessibility traits on custom controls. Identifies missing modifiers and suggests fixes.
---

# Accessibility Audit for SwiftUI Apps

## Overview

Scan SwiftUI views for missing accessibility support. Focus on interactive elements (buttons, sliders, toggles) and custom controls that SwiftUI can't automatically describe. The goal is VoiceOver usability, keyboard navigation, and visual accessibility.

## When to Use

- Before App Store submission (Apple reviews accessibility)
- User says "check accessibility", "audit VoiceOver support", "a11y review"
- After adding custom controls or icon-only buttons
- When using non-standard interaction patterns (hover, drag-and-drop)

## Audit Checklist

### 1. VoiceOver Labels

Scan all view files for interactive elements missing `.accessibilityLabel`:

**Must have labels:**
- [ ] Icon-only buttons (SF Symbols without text) — VoiceOver reads the SF Symbol name, which is often wrong
- [ ] Image-only elements used as buttons or indicators
- [ ] Custom controls (sliders, steppers, pickers built from scratch)
- [ ] Delete/close buttons (xmark, trash icons)
- [ ] Status indicators (DST sun icon, colored dots)

**Do NOT add labels to:**
- Text views that already display readable content
- Buttons with text labels (SwiftUI reads the label automatically)
- Decorative images/shapes (mark with `.accessibilityHidden(true)`)

### 2. Accessibility Values and Hints

- [ ] Sliders have `.accessibilityValue` describing the current state in human terms (e.g., "+2 hours" not "0.083")
- [ ] Toggles have `.accessibilityHint` if the consequence isn't obvious
- [ ] Text fields have `.accessibilityLabel` describing their purpose

### 3. Grouping and Containers

- [ ] Related content grouped with `.accessibilityElement(children: .combine)` where appropriate (e.g., a clock row: city + time should be one VoiceOver stop)
- [ ] Decorative wrappers marked `.accessibilityHidden(true)`
- [ ] List rows are single accessibility elements, not a series of unrelated labels

### 4. Keyboard Navigation

- [ ] All interactive elements reachable via Tab key
- [ ] Custom focusable elements use `.focusable()` modifier
- [ ] Focus order is logical (top-to-bottom, left-to-right)
- [ ] No keyboard traps (focus can always escape)

### 5. Visual Accessibility

- [ ] Text meets WCAG AA contrast ratio (4.5:1 for normal text, 3:1 for large text)
- [ ] Information not conveyed by color alone (e.g., DST uses icon + text, not just color)
- [ ] Dynamic Type supported (`Font.system` or `Font.body` etc., not fixed font sizes)
- [ ] Touch targets at least 44x44pt on iOS / reasonable on macOS

### 6. Hover and Gesture Interactions

- [ ] Hover-triggered actions have keyboard/VoiceOver alternatives
- [ ] Drag-and-drop has an accessibility action alternative (`.accessibilityAction`)
- [ ] Long-press menus accessible via VoiceOver custom actions

## Common Mistakes

| Mistake | Fix |
|---|---|
| Adding `.accessibilityLabel` to every Text view | Only label elements VoiceOver can't describe automatically |
| Forgetting `.accessibilityValue` on custom sliders | VoiceOver needs human-readable current value |
| Hover-only interactions with no fallback | Add button/tap alternative or VoiceOver custom action |
| Using fixed font sizes (`fontSize: 14`) | Use Dynamic Type styles or let the system scale |
| Color as sole indicator | Pair color with icon, text, or pattern |
