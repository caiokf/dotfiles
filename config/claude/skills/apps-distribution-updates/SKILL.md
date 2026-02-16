---
name: apps-distribution-updates
description: Use when adding or maintaining outside-App-Store update distribution for a macOS app — Sparkle integration, key management, appcast strategy, and update publishing hygiene.
---

# Distribution Updates (Sparkle)

## Overview

Canonical skill for update distribution setup and maintenance for DMG-distributed macOS apps. Includes initial Sparkle integration and recurring update-publish considerations.

## When to Use

- First-time Sparkle setup
- Migrating old Sparkle setup to current best practices
- Troubleshooting appcast/signing/update-check behavior
- Defining release-note + appcast publication flow

## Initial Integration

1. Add Sparkle 2.x package dependency to app target
2. Generate EdDSA keys (`generate_keys`)
3. Configure feed/public key settings in plist/build settings
4. Ensure network client entitlement
5. Wire `SPUStandardUpdaterController` in app lifecycle host (typically AppDelegate)
6. Add user-visible "Check for Updates..." action
7. Decide appcast hosting strategy (repo, release assets, or custom hosting)

## Ongoing Release Hygiene

- Keep private EdDSA key secure (keychain/secrets manager)
- Sign update archives appropriately
- Publish/refresh appcast entries in sync with release artifacts
- Ensure update notes are accessible and version-matched

## Guardrails

- Do not wrap Sparkle in unnecessary abstraction layers
- Do not commit private signing keys
- Keep feed URL stable and reachable over HTTPS
- Validate update flow with an older installed version before shipping

## Common Mistakes

| Mistake | Fix |
|---|---|
| Using legacy DSA guidance | Use Sparkle 2.x EdDSA flow |
| Misconfigured generated Info.plist behavior | Use proper `INFOPLIST_KEY_` build settings or manual plist strategy |
| No network entitlement | Enable outbound network client entitlement |
| Appcast updates drift from release artifacts | Publish appcast atomically with release process |
