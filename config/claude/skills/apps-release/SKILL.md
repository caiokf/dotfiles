---
description: Use when shipping a manual macOS release outside App Store — end-to-end flow for versioning, changelog, build, sign, notarize, tag, and publish. Triggers on "release", "ship", "notarize", "new version", "cut a release".
---

# Manual macOS Release Pipeline

## Overview

Canonical manual release workflow for DMG-distributed macOS apps. This skill absorbs version bump and changelog generation so release work runs from one orchestrator.

## Related Skills

- CI alternative: `apps-release-ci`
- Auto-updates: `apps-distribution-updates`

## Pipeline

### 1) Preflight (hard stop on failure)

Verify tooling and credentials:

```bash
xcodebuild -version
security find-identity -v -p codesigning
xcrun notarytool history --keychain-profile "notarytool-profile"
which create-dmg
gh auth status
```

Optional:

- `sentry-cli` for dSYM upload
- Sparkle tooling for appcast/sign_update

### 2) Version bump (integrated)

Update `MARKETING_VERSION` and `CURRENT_PROJECT_VERSION` in `project.pbxproj`.

Rules:

- `MARKETING_VERSION`: semver user-visible release
- `CURRENT_PROJECT_VERSION`: integer build counter
- Update all configurations/targets consistently

### 3) Changelog + release notes (integrated)

- Generate user-facing changelog section from commits + handwritten notes
- Write markdown for `CHANGELOG.md`
- If using Sparkle, generate standalone HTML release notes for the target version

### 4) Build and verify

Run tests, then build Release universal binary:

```bash
xcodebuild test -project App.xcodeproj -scheme App -destination "platform=macOS"
xcodebuild -project App.xcodeproj -scheme App -configuration Release \
  -destination "generic/platform=macOS" ONLY_ACTIVE_ARCH=NO clean build
```

Verify built app reports expected version/build.

### 5) Sign, package, notarize

- Codesign app bundle with hardened runtime/entitlements
- Package DMG
- Sign DMG
- Notarize DMG (single notarization target)
- Staple ticket to DMG

### 6) Optional publish extras

- Upload dSYMs to Sentry (if configured)
- Update Sparkle appcast/release notes if Sparkle is enabled

### 7) Commit, tag, and release

- Commit version/changelog artifacts
- Create annotated tag: `vX.Y.Z`
- Push branch and tag
- Publish GitHub Release with DMG attached

## Guardrails

- Do not push/tag without explicit user confirmation
- Do not skip tests unless user explicitly requests
- Do not mix release content with unrelated working-tree changes
- Keep release notes user-facing (no raw internal commit noise)

## Common Mistakes

| Mistake                                  | Fix                                      |
| ---------------------------------------- | ---------------------------------------- |
| Bumping only one build configuration     | Update all relevant target/config blocks |
| Notarizing both .app and .dmg            | Notarize final DMG only                  |
| Tagging before version/changelog commit  | Tag the final release commit             |
| Publishing without artifact verification | Validate version and launch sanity first |
