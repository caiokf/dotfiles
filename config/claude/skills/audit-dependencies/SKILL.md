---
description: Run pnpm audit to find dependency vulnerabilities, fix them one at a time with individual commits in an isolated worktree, then create a PR. Triggers on "audit dependencies", "dependency audit", "check vulnerabilities", "fix vulnerabilities".
---

# Audit Dependencies

Run `pnpm audit` in an isolated worktree, fix each vulnerability individually, commit per fix, and open a PR.

**Announce at start:** "I'm using the audit-dependencies skill to find and fix vulnerabilities."

## Steps

### 1. Create a worktree

Use the **worktree-create** skill to set up an isolated workspace. Use branch name `fix/audit-dependencies`.

All subsequent work happens inside the worktree.

### 2. Run the audit

```bash
pnpm audit --json 2>/dev/null || true
```

Parse the JSON output. If there are **no vulnerabilities**, announce that the project is clean, use the **worktree-finish** skill (option 4: discard), and stop.

Group vulnerabilities by the **fix action** required (e.g., `pnpm update <pkg>`, major version bump, replace package). Present a summary table:

```
## Dependency Audit Results

| # | Severity | Package        | Via            | Fix                          |
|---|----------|----------------|----------------|------------------------------|
| 1 | high     | lodash@4.17.20 | prototype-poll | pnpm update lodash           |
| 2 | moderate | axios@0.21.1   | SSRF           | pnpm update axios            |
| 3 | critical | tar@4.4.13     | path traversal | pnpm update tar              |

**Total:** 3 vulnerabilities (1 critical, 1 high, 1 moderate)
```

### 3. Ask user which fixes to apply

Use the **AskUserQuestion** tool:

> Which vulnerabilities should I fix? You can say "all", list numbers (e.g., "1, 3"), or "critical and high only".

### 4. Apply fixes one at a time

For each selected vulnerability, in order of severity (critical first):

1. **Apply the fix** — run the appropriate command (`pnpm update <pkg>`, edit `package.json`, etc.)
2. **Verify** — run `pnpm install` (if needed) and `pnpm audit --json 2>/dev/null || true` to confirm the specific vulnerability is resolved
3. **Run checks** — run `pnpm codecheck` to ensure nothing broke. If it fails:
   - Investigate the failure
   - If the fix introduced a breaking change, inform the user and ask how to proceed
   - If a test needs updating, update it and include in the same commit
4. **Commit** — follow the `git-commits` skill conventions:
   ```bash
   git add pnpm-lock.yaml package.json <any other changed files>
   git commit -m "fix(deps): upgrade <package> to <version> to resolve <severity> vulnerability"
   ```

Each vulnerability gets **exactly one commit**. Never batch multiple dependency fixes into a single commit.

### 5. Final verification

After all fixes are applied:

```bash
pnpm audit --json 2>/dev/null || true
```

Show the remaining audit status (if any unresolved vulnerabilities remain, note them).

### 6. Finish with the worktree-finish skill

Use the **worktree-finish** skill. It will:

- Verify tests pass
- Present integration options (merge, PR, keep, discard)
- For this skill, **option 2 (Push and create PR)** is the expected default

When creating the PR, use this body structure:

```
## Summary
- Ran `pnpm audit` and resolved dependency vulnerabilities
- Each vulnerability fixed in a separate commit for easy review/revert

## Vulnerabilities Fixed
<list each fix: package, old version -> new version, severity, advisory>

## Remaining
<any unresolved vulnerabilities and why they couldn't be auto-fixed>

## Test plan
- [ ] CI passes
- [ ] `pnpm audit` shows no new vulnerabilities
- [ ] Application builds and runs correctly
```

## Guardrails

- **Always work in a worktree** — never apply fixes on the current branch
- **One commit per fix** — never batch vulnerability fixes together
- **Severity order** — fix critical first, then high, moderate, low
- **Verify after each fix** — run `pnpm audit` again to confirm the vulnerability is resolved
- **Run codecheck** — ensure the fix doesn't break the build or tests
- **Ask before applying** — never auto-fix without user confirmation on which vulnerabilities to address
- **Don't force-update** — if a fix requires a major version bump that breaks APIs, flag it to the user instead of blindly upgrading
- **Preserve lockfile integrity** — always use `pnpm update` or `pnpm install`, never manually edit `pnpm-lock.yaml`

## Edge Cases

- **No vulnerabilities found**: Announce clean status, discard the worktree, done
- **Fix breaks tests**: Stop, show the failure, ask the user how to proceed (update tests, skip this fix, or revert)
- **Major version bump required**: Flag to user — "this fix requires upgrading X from v2 to v3, which may have breaking changes. Proceed?"
- **Vulnerability has no fix available**: Note it in the PR body under "Remaining" and move on
- **Monorepo packages affected**: If the vulnerable package is used in multiple workspace packages, ensure the fix propagates to all of them via `pnpm update --recursive <pkg>`

## Integration

**Uses:**
- **worktree-create** — creates the isolated workspace
- **worktree-finish** — handles PR creation and cleanup
- **git-commits** — commit format conventions
