---
description: Resolve open review comments on recently merged PRs
---

Review and resolve all open review comments on PRs merged in the last $ARGUMENTS days (default: 5).

## Steps

### 1. Find recently merged PRs

```bash
gh pr list --state merged --search "merged:>=$(date -v-${DAYS}d +%Y-%m-%d)" --json number,title,headRefName
```

Save the list. If no PRs found, report "No merged PRs in the last N days" and stop.

### 2. For each PR, get unresolved review threads

Use the GraphQL API to fetch all review threads:

```bash
gh api graphql -f query='{
  repository(owner: "<owner>", name: "<repo>") {
    pullRequest(number: <N>) {
      reviewThreads(first: 50) {
        nodes {
          id
          isResolved
          comments(first: 5) {
            nodes {
              id
              path
              line
              body
              author { login }
            }
          }
        }
      }
    }
  }
}'
```

Filter to threads where `isResolved == false`. If all threads are resolved for a PR, skip it.

### 3. Get the PR's commits for cross-referencing

```bash
gh pr view <N> --json commits --jq '.commits[] | {sha: .oid[:7], message: .messageHeadline}'
```

### 4. Classify each unresolved comment

For each unresolved comment, read the file at the mentioned path on main (current code) and determine disposition:

- **FIXED**: The issue was addressed by a commit in the PR. Verify the current code no longer has the issue. Reply: `"Fixed in <sha> — <what changed>."`
- **BY_DESIGN**: The suggestion conflicts with established patterns. Check a reference service (e.g., `platform.api-keys`) to confirm the same pattern is used. Reply: `"By design — <explanation citing reference service>."`
- **OUT_OF_SCOPE**: The comment is about a file unrelated to the PR's primary purpose. Reply: `"Out of scope for this PR — this file is in \`<service>\`, not part of the \`<PR service>\` changes."`
- **WONT_FIX**: A nitpick that would break consistency with existing code. Verify a reference service follows the same pattern. Reply: `"Won't fix — \`<reference service>\` follows the same pattern. Changing only here would break consistency."`
- **VALID_BUT_DEFERRED**: A real issue that should be tracked separately. Reply: `"Valid concern — should be addressed in a follow-up PR, not in this already-merged change."`

**Classification rules:**
- ALWAYS verify against the actual current code on main — never assume
- For FIXED, cite the specific commit SHA
- For BY_DESIGN or WONT_FIX, cite a specific file in a reference service
- For OUT_OF_SCOPE, verify the file path is outside the PR's primary service directory
- Bot comments (CodeRabbit, coderabbitai, etc.) can be resolved freely
- Human reviewer comments: prefer VALID_BUT_DEFERRED over WONT_FIX unless pattern evidence is strong

### 5. Reply and resolve each thread

For each classified comment:

a. Post a reply:
```bash
gh api repos/<owner>/<repo>/pulls/<N>/comments \
  -f body="<reply>" \
  -F in_reply_to=<comment_id>
```

b. Resolve the thread:
```bash
gh api graphql -f query='mutation {
  resolveReviewThread(input: {threadId: "<thread_id>"}) {
    thread { isResolved }
  }
}'
```

### 6. Report summary

After all PRs are processed, output a summary table:

| PR | # | Comment | File | Disposition |
|---|---|---|---|---|
| Title | 42 | Brief description | path/to/file.ts | FIXED in abc1234 |

And totals: N comments resolved across M PRs.
