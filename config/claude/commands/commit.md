---
description: Commit unstaged and untracked changes in small logical commits
---

Goal: Commit all current unstaged and untracked local changes as small, focused Conventional Commits, one per logical change set.

Process:

1. Run `git status`, `git diff`, and `git log --oneline -10`.
2. Group changed files/hunks by logical change set.
3. For each change set:
   - Stage only related files/hunks (avoid broad staging).
   - Commit with a Conventional Commit message.
   - Include this trailer in every commit message:
4. Repeat until working tree is clean.
5. End by running `git status` and report the commit list.

Constraints:

- Do not push unless explicitly asked by the user.
- Do not amend unrelated existing commits.
- If no changes exist, report that there is nothing to commit.

# Conventional Git Commits

## Overview

Commit immediately after each logical unit of work using Conventional Commits format. Every commit must be small, focused, and independently understandable.

## When to Use

- Any task that creates or modifies files
- Multi-step implementations (features, refactors, bug fixes)
- Before switching to a different part of a task

## Commit Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Quick Reference

| Type       | When                                            |
| ---------- | ----------------------------------------------- |
| `feat`     | New feature or capability                       |
| `fix`      | Bug fix                                         |
| `docs`     | Documentation only                              |
| `style`    | Formatting, whitespace (no logic change)        |
| `refactor` | Code restructuring (no new feature, no bug fix) |
| `test`     | Adding or updating tests                        |
| `chore`    | Build process, tooling, dependencies            |

## Commit Timing

Commit **immediately** after:

- Creating a new file or module
- Implementing a distinct function or method
- Fixing a specific bug
- Completing a logical unit of work
- Making configuration changes
- **Before switching to a different part of the task**

The last point is critical. If a user asks you to pivot mid-task, **commit current work first**.

## How to Commit

Use plain git commands from the project root:

```bash
git add <files>
git commit -m "type(scope): description"
```

Lefthook pre-commit hooks run automatically on `git commit` (installed via `.git/hooks/pre-commit`). No wrapper script needed.

## Rules

1. **One concern per commit.** A commit touches one logical change. Never mix a bug fix with a refactor, or a feature with a style change.
2. **Commit as you go.** Do not accumulate changes and commit at the end. Each completed unit gets its own commit immediately.
3. **Descriptions describe WHAT changed.** Use the body for WHY if context is needed.
4. **Commit specific files.** Use `git add <files>` to stage, then `git commit`. Lefthook pre-commit hooks run automatically.

## Red Flags - STOP and Commit Now

- You've created a file but haven't committed yet and moved to the next file
- You've changed more than 3 files without committing
- You're about to switch from one type of work to another (e.g., feature to bugfix)
- You're feeling time pressure and thinking "I'll commit later"
- You've discovered and fixed a bug mid-task — that's a separate `fix:` commit

**All of these mean: stop, commit what you have, then continue.**

## Common Rationalizations

| Excuse                              | Reality                                                                          |
| ----------------------------------- | -------------------------------------------------------------------------------- |
| "I'll commit everything at the end" | You'll create one unreadable monster commit mixing unrelated changes             |
| "This is too small to commit"       | Small commits are the point. `git log` should read like a changelog              |
| "Committing now would slow me down" | 10 seconds to commit now saves hours of archaeology later                        |
| "The demo/deadline is urgent"       | Pressure is exactly when clean history matters most for rollback                 |
| "These changes are related"         | If they have different types (feat vs fix vs refactor), they're separate commits |

## Examples

```
chore: initialize package.json with express dependency
feat: add express server setup with middleware
feat(users): add GET /users endpoint with pagination
feat(users): add POST /users endpoint with validation
fix: resolve null pointer in user lookup
test(users): add unit tests for user endpoints
refactor: extract validation logic into shared utility
```

**Not:**

```
feat: add user API with all endpoints, fix bugs, and refactor validation
```
