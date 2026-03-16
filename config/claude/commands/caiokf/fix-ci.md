---
description: Diagnose and fix failing CI/CD pipeline
argument-hint: <PR number or "main" — defaults to current branch>
---

Diagnose and fix CI/CD failures for the specified target.

## Input

- `$ARGUMENTS` can be: a PR number, `main`, or empty (defaults to current branch's latest CI run)

## Process

### 1. Identify the failing run

```bash
# If PR number given:
gh run list --branch <pr-branch> --limit 5 --json databaseId,status,conclusion,name

# If "main" or empty:
gh run list --branch main --limit 5 --json databaseId,status,conclusion,name
```

Pick the most recent failing run.

### 2. Fetch failure logs

```bash
gh run view <run-id> --log-failed
```

If logs are too large, narrow down:

```bash
gh run view <run-id> --json jobs --jq '.jobs[] | select(.conclusion == "failure") | {name, steps: [.steps[] | select(.conclusion == "failure")]}'
```

### 3. Classify failures

Categorize each failure into one of:

| Type | Examples | Fix approach |
|---|---|---|
| **Lint** | oxlint errors, formatting | Run `pnpm nx lint -- --fix` and `oxfmt .` on affected projects |
| **Compile** | TypeScript errors | Read the error, fix the type issue |
| **Test** | Vitest failures | Read the test + source, diagnose root cause |
| **Build** | Nx build failures | Check dependency graph, missing exports |
| **Infra** | Runner OOM, npm registry, timeout | Report to user — not fixable in code |
| **Flaky** | Passes locally, fails in CI | Identify timing/environment issue |

### 4. Fix (parallel where possible)

For each fixable failure:

1. Spawn a sub-agent per failure type (e.g., one for lint fixes, one for test fixes) using the Agent tool with the appropriate `subagent_type` (`engineer` for test/compile, `frontend-engineer` for Vue issues)
2. Each agent reads the relevant source files and applies the fix
3. After fixes, run the equivalent check locally:
   - Lint: `pnpm nx lint <project>`
   - Compile: `pnpm nx compile <project>`
   - Test: `pnpm nx test <project>`
   - Format: `oxfmt --check .`

### 5. Validate locally

Run the full quality gate on affected projects:

```bash
pnpm nx affected -t compile lint test --base=origin/main
```

If anything still fails, loop back to step 4 (max 3 iterations).

### 6. Commit and push

Use the `git-commits` skill to commit fixes in small, logical commits. Push to the branch.

### 7. Monitor

```bash
gh run list --branch <branch> --limit 1 --json databaseId,status,conclusion
```

Poll until the run completes (check every 30 seconds, max 10 minutes). Report the result.

## Constraints

- Never auto-fix **Infra** type failures — report them to the user
- Never force-push
- If a test failure looks like a legitimate bug (not a CI issue), stop and explain it to the user rather than "fixing" the test
- Max 3 fix-validate iterations before asking the user for help
- If the failure is in a project you haven't read, read it first before attempting fixes
