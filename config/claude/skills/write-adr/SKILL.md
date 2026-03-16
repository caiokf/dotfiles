---
name: caiokf:write-adr
description: Use when creating or updating Architecture Decision Records (ADRs) - handles both research mode (evaluating options to reach a decision) and documentation mode (recording an already-made decision). Enforces MADR Minimal format with YAML frontmatter and AI-first evaluation criteria.
---

# Writing ADRs

## Overview

Write Architecture Decision Records using MADR Minimal format. Every decision is evaluated primarily through the lens of AI-first development — how well does each option support AI agents reading, maintaining, and verifying the codebase?

ADRs live in `docs/adrs/` and follow the naming convention `NNN-slug.md`. Unless specified otherwise, the next sequential number is assigned automatically.

## Two Modes

Detect which mode the user needs:

### Document Mode

The decision is already made. The user says things like "we chose X", "we're using Y", "document that we picked Z".

- Skip comparative research
- Write the ADR with the decision in frontmatter
- Focus the "Considered Options" section on justifying the choice
- Still list alternatives briefly for context

### Research Mode

The decision is open. The user says things like "should we use X or Y?", "evaluate options for Z", "help me decide".

- Research the options
- Present findings using AskUser so the user can pick
- Once decided, write the ADR

## Template

```markdown
---
id: <next sequential number>
title: <Short Decision Title>
status: <proposed | accepted | deprecated | superseded>
date: <YYYY-MM-DD>
decision: <chosen option, concise>
---

# ADR-<NNN>: <Title>

## Context

Why this decision is needed. 2-4 sentences. State the problem, not the solution.

## Considered Options

### <Option A> (selected)

- **<Criteria>** — assessment
- **<Criteria>** — assessment
- **<Why chosen>** — justification specific to this project

### <Option B>

- **<Criteria>** — assessment
- **<Criteria>** — assessment

## Consequences

- What changes as a result of this decision
- What new constraints or trade-offs we accept
- What we gain
```

## Formatting Rules

- **Frontmatter** — id, title, status, date, decision are YAML frontmatter, not markdown sections
- **Considered Options** — each option is an H3 heading with nested bullet list; never use markdown tables (they read poorly in IDEs and diffs)
- **Selected option** — mark with `(selected)` after the H3 heading
- **Bullet format** — `**Label** — description` using em dash, not hyphen

## AI-First Evaluation Criteria

When comparing options, these criteria take priority over all others. Every ADR should address the relevant ones:

### Primary (must evaluate)

- **AI readability** — can an agent understand the tool/pattern/API by reading code alone, without tribal knowledge or implicit conventions?
- **Explicit configuration** — does the option favour explicit, declarative config over convention-based magic? Agents can't infer conventions they haven't seen.
- **Type safety** — does it produce or consume strong types? Types are how agents understand contracts between modules.
- **Code generation support** — does it offer scaffolding/generators that produce consistent, predictable output an agent can build on?

### Secondary (evaluate when relevant)

- **Verifiability** — can an agent run a single command to confirm the tool is working correctly? Automated checks over manual verification.
- **Error message quality** — are errors clear enough for an agent to self-diagnose and fix without human help?
- **Documentation quality** — is the official documentation structured, complete, and machine-parseable?
- **Ecosystem maturity** — is it stable enough that patterns learned today won't break next month?
- **Context window efficiency** — does working with this option require loading many files to understand what's happening, or can an agent work in isolation?

### Always mention

- **Continuity** — if a previous codebase or the team already uses one option, that's a significant advantage (less context an agent needs to learn).

## Numbering

Check existing ADRs in `docs/adrs/` and use the next sequential number. Pad to 3 digits (001, 002, ...).

## After Creating an ADR

Save the decision to the knowledge base using the `knowledge-base` skill:

1. Append a one-liner to `.claude/memories.md` under `## ADR Decisions`:
   ```
   **[YYYY-MM-DD] ADR-NNN**: <title> — <decision>
   ```
2. If ByteRover is available, call `brv-curate` to store the ADR context.

## Tone

Concise, factual, no marketing language. Write for an agent that will read this in 6 months to understand why a decision was made.
