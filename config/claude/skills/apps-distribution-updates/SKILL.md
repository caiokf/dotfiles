---
name: apps-distribution-updates
description: Use when setting up or operating Sparkle for macOS app distribution outside the App Store - full integration, key setup, appcast generation, release publishing, sandbox config, and troubleshooting.
---

# Sparkle Distribution Operations

## Overview

This is the canonical Sparkle skill for macOS apps distributed outside the Mac App Store.

It supports two common intents directly:
- "Configure the whole app and prepare for Sparkle distribution"
- "Prepare the appcast for a new version"

Use Sparkle 2.x conventions (`SPUStandardUpdaterController`, EdDSA keys, `generate_appcast`).

## Important Name Disambiguation

Do not confuse two unrelated projects named "Sparkle":

- **Sparkle framework** (this skill): macOS auto-update framework at `sparkle-project.org`.
- **sparkle-mcp-server**: an MCP file/clipboard server for Claude.

`sparkle-mcp-server` does **not** provide app update distribution, appcast signing, or Sparkle framework integration for app updates.

## Intent Routing

When invoked, identify the user intent and run the matching mode:

1. **Full setup mode**
   - End-to-end Sparkle integration for an app not yet configured
2. **Appcast publish mode**
   - Prepare/sign a new update + regenerate appcast for a release
3. **Hardening mode**
   - Tighten security and sandbox settings
4. **Debug mode**
   - Diagnose why update checks, signatures, or installs fail

If user request is vague, default to **Full setup mode**.

## Mode 1: Full Setup (One-Time Integration)

### Step 1: Add Sparkle

- Add SPM package: `https://github.com/sparkle-project/Sparkle`
- Link `Sparkle` product to app target

### Step 2: Locate Sparkle CLI tools

Sparkle tools are in the package artifact `Sparkle/bin` (for SPM installs).

Typical tools:
- `generate_keys`
- `sign_update`
- `generate_appcast`

### Step 3: Create and protect keys

Run once:

```bash
./bin/generate_keys
```

Results:
- Private EdDSA key stored in login keychain
- Public EdDSA key printed to terminal

Key handling:
- Put public key in app config (`SUPublicEDKey`)
- Never commit/export private key insecurely
- If key transfer is needed, use Sparkle key export/import options and secure secret storage

### Step 4: Configure Info.plist defaults

Required baseline:
- `SUFeedURL` = hosted appcast URL
- `SUPublicEDKey` = public key from `generate_keys`
- `CFBundleVersion` must be properly formatted and incrementing for update comparisons

Recommended defaults:
- `SUEnableAutomaticChecks` (`YES` or `NO` explicitly)
- `SUAutomaticallyUpdate` (usually `NO` unless silent installs are desired)

Optional security hardening:
- `SUVerifyUpdateBeforeExtraction = YES`
- `SURequireSignedFeed = YES` (Sparkle 2.9+; requires `SUVerifyUpdateBeforeExtraction`)

### Step 5: Wire updater in app lifecycle

Use `SPUStandardUpdaterController` directly.

```swift
import Sparkle

final class AppDelegate: NSObject, NSApplicationDelegate {
    private let updaterController = SPUStandardUpdaterController(
        startingUpdater: true,
        updaterDelegate: nil,
        userDriverDelegate: nil
    )

    @objc func checkForUpdates(_ sender: Any?) {
        updaterController.checkForUpdates(sender)
    }
}
```

Add user-accessible "Check for Updates..." action in app/menu bar UI.

### Step 6: Sandbox-specific requirements (only if sandboxed)

If app uses App Sandbox:
- Enable `SUEnableInstallerLauncherService = YES` (required)
- Add required mach lookup exceptions for Sparkle installer communication
- Only enable `SUEnableDownloaderService` if app does **not** already have `com.apple.security.network.client`

If app is not sandboxed, do not enable sandbox-only Sparkle services.

### Step 7: Release artifact strategy

- Prefer notarized Developer ID signed DMG
- Keep app bundle name stable across versions
- Preserve symlinks in archives
- For ZIP archives, prefer `ditto -c -k --sequesterRsrc --keepParent`

Supported update archive types include DMG/ZIP/TAR/Apple Archive/package updates.

### Step 8: Initial verification

- Test from an older installed app version
- On second launch, Sparkle permission/check flow should behave as expected
- Use manual check via "Check for Updates..."
- Review Console logs for Sparkle diagnostics

Note: by default Sparkle asks for automatic-check permission on second launch (unless configured otherwise).

## Mode 2: Appcast Publish (Per Release)

Use this when user says: "prepare appcast for version X.Y.Z".

### Preconditions

- `CFBundleVersion` incremented (machine version Sparkle compares)
- Update archive built and signed/notarized as needed
- Sparkle keys available in keychain

### Step 1: Prepare updates directory

Place release artifacts in a dedicated updates folder (keep historical artifacts there).

Example:
- `MyApp-1.4.0.dmg`

Optional release notes pairing:
- Add `MyApp-1.4.0.html` (or `.md` on supported Sparkle/macOS combinations)
- `generate_appcast` can map same-basename notes to `releaseNotesLink`

### Step 2: Generate appcast and deltas

Run:

```bash
./bin/generate_appcast /path/to/updates/
```

This generates/updates:
- appcast XML
- EdDSA signatures for update entries
- delta update files where applicable

If release notes file shares the same basename as the archive (eg, `MyApp-1.4.0.html`), `generate_appcast` can attach it automatically.

If you enable signed feeds (`SURequireSignedFeed`), re-run `generate_appcast` after *any* feed or release-notes edits so signatures remain valid.

### Step 3: Publish all required files

Upload together:
- update archives (dmg/zip/tar/etc)
- generated `*.delta` files
- appcast XML
- release note files referenced by feed

Do not publish only appcast without matching assets.

### Step 4: Validate appcast content

For newest item, verify:
- `sparkle:version` matches `CFBundleVersion`
- `sparkle:shortVersionString` if used
- `pubDate` present and correct
- enclosure URL reachable over HTTPS
- signature/length attributes present

### Step 5: Smoke test update discovery

- Install older app build
- Trigger manual check
- Confirm offered update/version/release notes/install path

## Mode 3: Hardening

Apply as needed:

- Enforce HTTPS feed and download URLs
- Enable `SUVerifyUpdateBeforeExtraction`
- Optionally require signed feed (`SURequireSignedFeed`) with operational key discipline
- Ensure release notes links are trusted and stable
- Keep signing keys off web hosts and CI logs

## Mode 4: Debug / Recovery

Common issues and fixes:

| Symptom | Likely cause | Fix |
|---|---|---|
| No update offered | `CFBundleVersion` not incremented or appcast mismatch | Verify bundle + `sparkle:version` alignment |
| Signature failure | Wrong key or tampered archive | Re-sign/regenerate appcast with correct keychain key |
| Feed loads but install fails | Archive/signing/notarization issue | Validate package integrity and code signing chain |
| Sandboxed app cannot update | Missing installer launcher service / entitlements | Apply sandbox Sparkle settings and mach exceptions |
| Update checks seem stuck | Cached check schedule | Reset `SULastCheckTime` for testing |

Testing helper:

```bash
defaults delete <bundle-id> SULastCheckTime
```

## Advanced Appcast Features (Use Intentionally)

- `sparkle:minimumSystemVersion` / `sparkle:maximumSystemVersion`
- `sparkle:criticalUpdate`
- `sparkle:phasedRolloutInterval`
- `sparkle:channel` (beta/staged channels)
- `sparkle:minimumAutoupdateVersion` (major upgrade behavior)
- `sparkle:informationalUpdate`

Also supported and useful:
- `sparkle:minimumUpdateVersion` (newer Sparkle versions)
- `sparkle:fullReleaseNotesLink`

Only enable advanced tags when release policy explicitly calls for them.

## Non-Negotiable Guardrails

- Do not invent Sparkle keys/settings not in official docs
- Do not keep private signing keys in source control
- Do not mix Sparkle 1 (`SUUpdater`) guidance with new setup unless intentionally migrating legacy apps
- Do not enable sandbox-only services for non-sandboxed apps
- Always test updates from an older build, not only from current dev build
- Prefer `SPUUpdaterDelegate feedURLStringForUpdater:` for dynamic feed selection; avoid deprecated `setFeedURL:` patterns
