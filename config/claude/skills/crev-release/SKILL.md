---
name: crev-release
description: Use when releasing a new version of crev - bumps version, builds, tests, tags, pushes, monitors CI pipeline, and verifies all distribution channels (npm, homebrew, GitHub release, standalone binary) are serving the correct version
---

# crev Release

Publishes a new crev version across all distribution channels. The pipeline is automated via GitHub Actions (`.github/workflows/release.yml`) triggered by `v*` tags, but you MUST verify every channel after the pipeline completes.

## Process

### 1. Pre-flight

```bash
git status                    # Must be clean
git pull --rebase origin main # Must include latest formula commit from CI
npx vitest run                # All tests must pass
npx tsup                      # Build must succeed
```

### 2. Bump version

Edit `package.json` — update `"version"` field. This is the single source of truth. `tsup` bakes it into the binary via `CREV_VERSION` define at build time.

### 3. Commit, push, tag

```bash
git add package.json
git commit -m "chore: bump version to X.Y.Z"
git push origin main
git tag vX.Y.Z
git push origin vX.Y.Z
```

**The tag push triggers the release pipeline.** Do NOT push the tag before the commit is on `main`.

### 4. Monitor pipeline

```bash
# Poll until completed (check every 30s, max 10 min)
gh run list --branch vX.Y.Z --limit 1 --json databaseId,status,conclusion
```

The pipeline has 4 sequential jobs:
1. **npm-publish** — publishes `@caiokf/crev` to npm
2. **build-binaries** — Bun standalone builds for 5 targets (darwin-arm64, darwin-x64, linux-x64, linux-arm64, windows-x64)
3. **github-release** — creates GitHub release with binaries + checksums
4. **update-homebrew** — downloads release binaries, computes sha256, updates `Formula/crev.rb`, commits and pushes to `main`

If any job fails, diagnose with:
```bash
gh run view <run-id> --log-failed
```

### 5. Verify ALL channels

**Every single one. No exceptions.**

```bash
# npm
npm view @caiokf/crev version        # Must show X.Y.Z

# GitHub release
gh release view vX.Y.Z --json tagName,assets --jq '{tag: .tagName, assets: [.assets[].name]}'
# Must show all 5 binaries + checksums.txt

# Homebrew formula (pull CI's commit first)
git pull origin main
grep 'version' Formula/crev.rb       # Must show X.Y.Z

# Homebrew install (the real test)
brew update && brew upgrade crev
crev --version                        # Must show X.Y.Z

# Standalone binary (curl)
curl -sSL "https://github.com/caiokf/crev/releases/download/vX.Y.Z/crev-darwin-arm64" -o /tmp/crev-test
chmod +x /tmp/crev-test
/tmp/crev-test --version              # Must show X.Y.Z
rm /tmp/crev-test
```

### 6. If a channel is stale

| Channel | Fix |
|---|---|
| **npm** shows old version | Check `npm-publish` job logs. Re-run: `pnpm publish --no-git-checks --access public` |
| **GitHub release** missing | Check `github-release` job. Manual: `gh release create vX.Y.Z --generate-notes` then upload binaries |
| **Formula** shows old version | CI's `update-homebrew` job failed or pushed to wrong ref. Pull main, check Formula/crev.rb. If wrong, re-run the workflow or manually update the formula and push |
| **brew upgrade** shows old | Run `brew update` first (forces formula index refresh). If still old, check that `brew tap caiokf/crev` points to the correct repo |
| **Binary** crashes or wrong version | Bun version pinned to 1.2.15 in CI. Check build-binaries job logs |

## Common Mistakes

- **Pushing tag before commit is on main** — pipeline checks out the tag ref, which must contain the version bump
- **Forgetting `git pull` after release** — CI pushes a formula commit to main; next local commit will conflict
- **Not running `brew update` before `brew upgrade`** — homebrew caches the formula index; `update` forces refresh
- **Skipping verification** — "the pipeline succeeded" is not the same as "users can install it". Always verify.
