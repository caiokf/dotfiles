---
argument-hint:
description: Summarize git changes made by me, today
---

## Git Summary Instructions

When the user types `/git-eng-update`, perform the following steps:

1. **Retrieve Commits and Diffs**

   - Use:
     ```
     git log --author="$(git config user.name)" --since="yesterday" --until=now --all --patch
     ```
   - This command lists all commits and their full diffs (file changes) for the given timeframe.

2. **Analyze Commits and Diffs**

   - Read through commit messages to understand intent.
   - Examine the actual code or file changes in the diffs.
   - Identify patterns and related changes across commits.

3. **Create a High-Level Summary (Grouped by Category)**

   - Group related changes together (e.g., "Authentication system", "Repayments", "Slice Pay Agents").
   - Focus on **what** changed and **why**, not on individual commits.
   - Summarize the functional impact of the changes.
   - Combine multiple small commits that work toward one larger goal.

4. **Present as Executive-Style Summary**  
   Organize results by Feature areas/components modified.

**Guidelines:**

- **Do NOT** list individual commits or give daily breakdowns.
- **DO** focus on the overall story of what was accomplished.
- Format the output so it's useful for status updates, sprint reviews, or changelog generation.
- Present the header of the output as:

```
# Git Summary - ${formatted timeframe input} (${timeframe used on git commit})
- **first commit considered**: (${git sha of the commit}) - ${formatted date in ISO date format} - ${commit message, one line}
- **last  commit considered**: (${git sha of the commit}) - ${formatted date in ISO date format} - ${commit message, one line}
- **commits**: ${number of commits considered}
```
