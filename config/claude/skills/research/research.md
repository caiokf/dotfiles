---
name: caiokf:research:simple
description: Research and compare libraries, tools, or patterns for a technical decision
argument-hint: <topic or comparison, e.g. "pino vs winston vs bunyan for logging">
---

Research the topic provided in `$ARGUMENTS` and present a structured comparison.

## Process

### 1. Parse the topic

Extract what is being compared from the arguments. Examples:

- "pino vs winston" → compare two logging libraries
- "logging libraries" → find and compare top options
- "orm for postgres" → find and compare relevant ORMs

### 2. Search

Use exa search (if available), perplexity (if available) and web search to gather information. Run **3 parallel searches** using the Task tool:

1. `"<topic> comparison <current year>"` — to find recent comparison articles
2. `"<option A> vs <option B> <current year>"` — head-to-head (if specific options given)
3. `"best <category> for TypeScript Node.js <current year>"` — to catch options you might have missed

If the topic is broad (no specific options named), run an initial discovery search first, then compare the top 3-4 options found.

### 3. Enrich with docs

For each option found, search for:

- How actively maintained it is
- TypeScript support quality
- API surface and configuration approach

### 4. Present findings

Use this exact format for the output:

```
## Research: <Topic>

### Summary

<2-3 sentence overview of the landscape and which option stands out>

### Options

#### <Option A>

- **What it is** — one-liner description
- **GitHub stars / weekly downloads** — if found
- **TypeScript support** — native types, @types package, or none
- **AI readability** — how explicit/declarative is the API? Can an agent understand usage from code alone?
- **Configuration** — programmatic, file-based, or convention-based?
- **Ecosystem** — plugins, integrations, middleware support
- **Strengths** — bullet list
- **Weaknesses** — bullet list

#### <Option B>

<same structure>

### Recommendation

Based on this project's AI-first development approach, **<recommended option>** because:
- <reason 1>
- <reason 2>
- <reason 3>
```

### 5. Ask for decision

After presenting findings, use AskUserQuestion to let the user pick.

### 6. After decision

Once the user picks an option, ask if they want to create an ADR to record this decision. If yes, use the `write-adr` command in Document Mode to create the ADR.

## Evaluation Lens

This is an AI-first development monorepo. When evaluating options, always prioritise:

1. **AI readability** — explicit APIs over magic/conventions
2. **Type safety** — strong TypeScript types out of the box
3. **Explicit configuration** — declarative config agents can read and modify
4. **Verifiability** — easy to test and confirm it works via automated checks
5. **Context window efficiency** — minimal boilerplate, self-contained usage patterns

These criteria should be visibly addressed in the comparison, not just implied.

## Constraints

- Always use the current year in search queries for freshness
- Present at least 2 options, ideally 3-4
- Never recommend an option without explaining why through the AI-first lens
- Keep the output scannable — bullets over paragraphs
