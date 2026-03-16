---
description: Generate a business-value engineering summary for Slack
argument-hint: [time window — defaults to "this week", e.g. "last 2 weeks", "march"]
---

Generate a weekly engineering update summarized in business language, formatted for Slack.

## Input

- `$ARGUMENTS`: time window (e.g., "this week", "last 2 weeks", "march 1-15")
- Defaults to current week (Monday to today) if empty

## Process

### 1. Determine date range

Parse the time window into `--since` and `--until` dates for git log.

### 2. Gather data (parallel)

Spawn 3 sub-agents in parallel:

**Agent 1 — Git Activity (`Explore` agent)**
```bash
git log --since="<start>" --until="<end>" --oneline --no-merges
git log --since="<start>" --until="<end>" --format="%s" --no-merges
```
- Group commits by Conventional Commit type (feat, fix, chore, refactor, etc.)
- Group by service/package (extract from commit scope or changed files)
- Count PRs merged: `gh pr list --state merged --search "merged:>=$START" --json title,mergedAt,labels`

**Agent 2 — Deployments & Incidents (`Explore` agent)**
- Check GitHub Actions deploy workflows: `gh run list --workflow deploy --limit 50 --json startedAt,conclusion`
- Count successful vs failed deploys in the time window
- Check for any incidents (GitHub issues with incident labels, if any)
- Check Grafana for uptime/error rate summary (if accessible)

**Agent 3 — OpenSpec Progress (`Explore` agent)**
- Check `openspec/changes/` for changes created, progressed, or archived in the window
- Map changes to product areas (from proposal descriptions)
- Identify features shipped vs in-progress

### 3. Classify by product area

Map all activity into business-relevant categories rather than service/package names:

Adjust mappings based on what actually exists in the repo.

### 4. Compose the update

Write the update in this Slack-friendly format (use Slack mrkdwn, not GitHub markdown):

```
*Engineering Update — <date range>*

*Shipped*
• <Product area>: <what was delivered in business terms>
• <Product area>: <what was delivered>

*In Progress*
• <Product area>: <what's being worked on, expected completion>

*Platform Health*
• Uptime: <X>% | Deploys: <N successful> | Incidents: <N>

*Key Metrics*
• <N> features shipped | <N> bugs fixed | <N> PRs merged

---
_<N> commits across <N> services by <N> contributors_
```

### 5. Output

Display the formatted update to the user. Also save to `.personal/engineering-updates/<date>.md`.

## Writing Guidelines

- **Business language, not technical.** "Merchant onboarding flow now supports bulk uploads" not "Added POST /v1/merchants/bulk endpoint"
- **Outcomes, not activities.** "Reduced payment processing time by 40%" not "Refactored payment service"
- **Short and scannable.** Each bullet is one line. No paragraphs.
- **Honest.** If it was a quiet week, say so. Don't inflate.
- **Group related commits into a single bullet.** 5 commits fixing the same feature = 1 bullet

## Constraints

- Never include commit hashes, file paths, or technical implementation details
- Never fabricate metrics — only include data you actually found
- If Grafana/monitoring data isn't accessible, omit the Platform Health section rather than guessing
- The update should be copy-pasteable into Slack as-is
