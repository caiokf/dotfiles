---
name: apps-audit-compliance
description: Use when running pre-submission compliance checks for macOS/iOS apps — merges App Store review readiness and privacy manifest validation, with optional accessibility/localization gates.
---

# App Compliance Audit

## Overview

Single audit workflow for App Store readiness. This skill combines policy checks, entitlements, Info.plist completeness, and privacy manifest accuracy so review blockers are found in one pass.

## Related Skills

- Optional deep dive: `apps-audit-accessibility`
- Optional deep dive: `apps-audit-localization`

## When to Use

- Before App Store submission
- After adding new capabilities/SDKs/entitlements
- After rejection for privacy, metadata, or policy reasons
- User asks for App Store readiness or compliance review

## Audit Phases

### Phase 1: Project and Runtime Readiness

- [ ] App launches and core flow works on clean install
- [ ] No placeholder/test content in release UI
- [ ] No staging URLs, localhost hooks, or debug-only behavior
- [ ] Hardened runtime/signing are correctly configured

### Phase 2: Info.plist and Entitlements

- [ ] App name/category/version keys are present and valid
- [ ] Usage description keys exist for every sensitive capability used
- [ ] Entitlements are least-privilege (only what app actually uses)
- [ ] Sandbox/network/client entitlements align with runtime behavior

### Phase 3: Privacy Manifest (Required)

Validate `PrivacyInfo.xcprivacy`:

- [ ] File exists and is included in app bundle resources
- [ ] Required reason API categories match real code usage
- [ ] Reason codes are valid and specific
- [ ] `NSPrivacyTracking` and data collection declarations match actual behavior

Required-reason API categories to check:
- File timestamp
- System boot time
- Disk space
- User defaults / `@AppStorage`
- Active keyboards (if applicable)

### Phase 4: Store Metadata Consistency

- [ ] Description and screenshots match shipped functionality
- [ ] Age rating and category are accurate
- [ ] Privacy policy URL exists and is accessible
- [ ] No prohibited claims, competitor trademark use, or misleading copy

### Phase 5: Optional Quality Gates

If app has broad audience or global rollout:
- Run `apps-audit-accessibility`
- Run `apps-audit-localization`

## Output Format

Provide:
1. **Blockers (must fix)**
2. **Warnings (should fix)**
3. **Advisory improvements**

Each issue should include:
- Affected file/area
- Why it matters for review
- Specific fix recommendation

## Common Mistakes

| Mistake | Fix |
|---|---|
| Privacy manifest exists but doesn't match actual API usage | Scan code and align categories/reason codes exactly |
| Usage descriptions are generic | Explain clear user benefit and context |
| Extra entitlements left for future features | Remove until feature ships |
| Assuming metadata is "marketing only" | Inconsistent metadata can trigger review friction |
