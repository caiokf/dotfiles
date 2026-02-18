---
name: apps-setapp
description: Use when doing anything related to Setapp delivery - framework or Vendor API integration, app/account setup, submission, beta/live releases, metadata/assets, troubleshooting, and recurring updates for macOS, iOS, web, and Single App Distribution.
---

# Setapp Operations Playbook

## Overview

End-to-end operational skill for Setapp Marketplace work. Use it to plan, validate, and execute the full lifecycle:

- integration (Framework or Vendor API)
- packaging and metadata
- first submission and review
- update releases (stable/beta)
- troubleshooting and policy compliance

This skill is intentionally strict: it treats Setapp docs as source of truth and avoids speculative fields/flows.

## When to Use

- "prepare app for Setapp"
- "submit/update Setapp build"
- "set up Setapp for iOS/macOS/web"
- "fix Setapp review rejection"
- "automate Setapp build uploads"

## Canonical Docs Index

Start with:

- `https://docs.setapp.com/docs/setapp-marketplace-overview`

Then follow relevant sections:

- developer account/policies, submission/review, testing/troubleshooting
- Setapp Framework (macOS/iOS/Electron)
- Vendor API + OAuth
- Single App Distribution
- API reference pages (`/reference/...`)

## Decide the Integration Path First

Choose one primary path:

1. **Setapp Framework** (typical Apple app integration)
2. **Vendor API** (platform/backend-controlled access checks)

You can combine them, but do not start implementation before deciding the source of entitlement truth.

## 0) Preflight Compliance Gate

Before technical work, verify policy fit:

- No hidden functionality
- No extra paid features for Setapp users
- No ads/promotional mechanics that violate Setapp rules
- No own licensing/update systems conflicting with Setapp delivery
- No disallowed categories (e.g. gaming/gambling/dating)
- Privacy Policy + Terms URLs available in account

If any item fails, stop and resolve first.

## 1) Required Account and App Identity Setup

- Create/verify Setapp developer account
- Add app in Setapp developer area
- Configure support/legal policy links
- Set app identity fields carefully (immutable constraints apply)

### Bundle ID rules (critical)

- `CFBundleIdentifier` must match Setapp registration
- Common pattern: `<domain>.<company>.<app>-setapp`
- Bundle ID is case-sensitive and should not encode version
- Once finalized in Setapp account, treat as immutable

## 2) Platform Requirements (Quick Matrix)

### macOS

- Integrate Setapp Framework
- Add Setapp public key file
- Sign + notarize release artifacts
- Add Ventura+ update security policy for Setapp agent
- Configure architecture metadata
- Ensure archive format/layout satisfies Setapp validator

### iOS

- Free App Store app with IAP model (per Setapp docs)
- Integrate iOS framework and activation flow
- Configure URL scheme callbacks
- Persist and show activation/subscription state clearly
- Implement required error handling and testing scenarios

### Web/Backend (Vendor API)

- Configure OAuth client(s)
- Implement token flow and access checks
- Handle token refresh lifecycle and error states

## 3) Exact Fields and Properties to Validate

Validate these as hard requirements when applicable.

### Info.plist / identity and versioning

- `CFBundleIdentifier`
- `CFBundleName`
- `CFBundleIconFile`
- `CFBundleVersion`
- `CFBundleShortVersionString`
- `MDItemKeywords` (used for search metadata)

Versioning precedence is documented around `CFBundleVersion` first, then `CFBundleShortVersionString` for ties.

### Architectures

- `MPSupportedArchitectures`
  - `arm64`
  - `x86_64`

If omitted, Setapp may treat build as universal. Prefer explicit declaration.

### macOS 13+ Setapp update authorization

- `NSUpdateSecurityPolicy`
  - `AllowProcesses`
  - Team key `MEHY5QF425`
  - Process `com.setapp.DesktopClient.SetappAgent`

### Sandbox exception (only when sandboxed)

- Entitlement key:
  - `com.apple.security.temporary-exception.mach-lookup.global-name`
- Include value:
  - `com.setapp.ProvisioningService`

### Public key file

- Standard name used in docs: `setappPublicKey.pem`
- Use platform-specific key material as documented

### iOS URL type setup

- URL Type `Identifier`: `Setapp`
- `URL Schemes`: app bundle ID
- Role: `None`

### iOS background usage reporting setup

- `BGTaskSchedulerPermittedIdentifiers` includes `com.setapp.usageReport`
- Enable required background modes for fetch/processing as documented

## 4) Packaging and Build Artifacts (macOS)

For build uploads:

- Archive max size: `1 GB`
- Use `.zip` with clean structure
- `.app` must be at archive root or one nested folder
- Avoid junk paths like `__MACOSX`
- Include `<AppName>.png` next to `<AppName>.app`
- Ensure icon extraction/build settings produce required large icon assets

## 5) Metadata and Submission Content Rules

Validate documented limits before submission:

- Release notes (Markdown): up to `5000` chars
- Key benefits: up to `80` chars
- Description: up to `3000` chars
- Reviewer comments: up to `2000` chars

Media limits (as documented):

- macOS screenshots: up to `5`, `16:10`, min `1280x800`
- iOS screenshots: `5-10`, min `1242x2688`
- Video: up to `1`, `MP4 H.264`, up to `2 min`, up to `100 MB`

## 6) Submission and Release Workflow

### First submission (important)

- First app version must be uploaded via Setapp web UI

### Standard flow

1. Build and validate package
2. Fill metadata/assets/release notes
3. Submit for review
4. Choose release mode (auto-release on approval or manual)
5. Track status and resolve revisions

### Common statuses

- `Draft`
- `Needs Revision`
- `Approved`
- `Live`
- plus beta/stable combinations in beta workflows

## 7) Ongoing Updates (Stable and Beta)

- Keep Setapp release timing aligned with your other channels
- Upload new version + notes + required metadata changes
- Verify version progression and replacement logic
- Use beta channel intentionally; do not confuse with stable rollout

Operational guardrail: prolonged lag behind other channels can trigger quality penalties/removal actions.

## 8) CI and Automation Guardrails

You can automate uploads after first release, but keep constraints in mind.

Common upload parameters documented by Setapp tooling/docs:

- `Token`
- `Archive`
- `Release_notes`
- `Status` (`draft` or `review`)
- `Release_on_approval` (`true`/`false`)
- `Is_beta` (`true`/`false`)
- `Allow_overwrite` (`true`/`false`)

Known responses include `204`, `400`, `401`.

## 9) Vendor API + OAuth Essentials

When using Vendor API flows:

- Implement OAuth client + redirect flow correctly
- Manage short-lived access token and refresh lifecycle
- Enforce access checks server-side
- Respect documented rate limits
- Handle refresh token rotation/single-use semantics per docs

## 10) Troubleshooting Playbook

When failures happen, classify first:

1. **Packaging failure** (zip layout, icon, size, missing keys)
2. **Identity mismatch** (bundle ID/account mismatch)
3. **Update/security policy failure** (missing Ventura policy or entitlements)
4. **Activation/subscription UX failure** (iOS state handling)
5. **OAuth/access failure** (token lifecycle, client setup)
6. **Review policy failure** (content/business-rule violations)

Then resolve by replaying the relevant section of this skill and Setapp docs pages in that category.

## Revenue Model and Tier Bands (Pricing Advice)

Use this section when advising on pricing strategy.

### Membership model (Setapp catalog)

- Revenue has two independent components:
  - `70%` usage-based distribution (weighted by app tier multiplier)
  - `+20%` partner fee for eligible referred users

Price tiers and multipliers (from Setapp docs):

| Tier | Price range (USD) | Multiplier |
|---|---|---|
| 1 | 1.00-1.99 | 1 |
| 2 | 2.00-3.99 | 2 |
| 3 | 4.00-5.99 | 3 |
| 4 | 6.00-7.99 | 4 |
| 5 | 8.00-11.99 | 5 |
| 6 | 12.00-15.99 | 7 |
| 7 | 16.00-21.99 | 10 |
| 8 | 22.00-27.99 | 13 |
| 9 | 28.00-33.99 | 15 |
| 10 | 34.00-43.99 | 20 |
| 11 | 44.00-53.99 | 24 |
| 12 | 54.00-65.99 | 30 |
| 13 | 66.00-77.99 | 35 |
| 14 | 78.00-93.99 | 43 |
| 15 | 94.00-125.99 | 57 |
| 16 | 126.00-173.99 | 79 |
| 17 | 174.00+ | 100 |

Pricing-strategy implication:

- Boundary jumps can materially change share weight.
- Example: `1.99` (tier 1, multiplier `1`) vs `2.00` (tier 2, multiplier `2`) means double weight in the 70% usage pool for otherwise equivalent usage.
- The same boundary logic applies at all tier cutoffs.

Tier assignment guidance:

- Setapp typically uses your external list/subscription price.
- Annual subscription price is prioritized when both monthly and annual exist.
- If only monthly exists, docs indicate annualized value (monthly x `12`) is used.
- Price changes generally need to be effective outside Setapp for about `3 months` before tier updates are accepted.

### Single-app distribution model

- Revenue is generally `85%` of purchase value (purchase-frequency independent).
- Purchase type (one-time vs subscription cadence) does not change the base `85%` share.
- FX and transaction fees may affect final payout amount.

## Mandatory Output Format for This Skill

For every Setapp task, produce:

1. **Execution plan** (path + platform)
2. **Required fields checklist** (exact keys and target values)
3. **Submission/update checklist** (pass/fail)
4. **Risks/blockers** (what can cause rejection/broken rollout)
5. **Next concrete actions**

## High-Value Guardrails

- Do not invent undocumented Setapp properties
- Do not skip policy checks before technical implementation
- Do not change bundle identifiers late in process
- Do not rely solely on CI for first submission
- Do not ship untested activation/error paths
- Do not diverge Setapp release cadence from primary distribution for long periods

## References

- Setapp Marketplace overview: `https://docs.setapp.com/docs/setapp-marketplace-overview`
- Submitting apps for review: `https://docs.setapp.com/docs/submitting-apps-for-review`
- Updating apps: `https://docs.setapp.com/docs/updating-applications`
- Setapp app requirements: `https://docs.setapp.com/docs/preparing-your-application-for-setapp`
- Monetizing on Setapp: `https://docs.setapp.com/docs/monetizing-on-setapp`
- Setapp Membership revenue (tiers/multipliers): `https://docs.setapp.com/docs/setapp-membership-revenue`
- Single-app distribution revenue (85% share): `https://docs.setapp.com/docs/single-app-distribution-revenue`
- App statistics and payouts: `https://docs.setapp.com/docs/application-statistics`
- Integration requirements: `https://docs.setapp.com/docs/integration-requirements`
- Vendor API integration: `https://docs.setapp.com/docs/integrating-apps-using-vendor-api`
