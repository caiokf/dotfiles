---
name: caiokf:research-deep
description: Use when doing in-depth research on any topic — designs a custom team of 5+ specialized agents with distinct personalities tailored to the research topic, uses exa search and perplexity tools, compiles findings, runs team review with oracle second-opinion, and outputs formatted markdown report with frontmatter. Triggers on "research", "deep dive", "investigate", "comprehensive analysis".
---

# Deep Research

## Overview

Orchestrates comprehensive research by designing a custom team of personality-driven agents tailored to the specific research topic, plus an oracle reviewer. Each agent researches from a distinct angle using exa search and perplexity tools, results are compiled, then the full team + oracle reviews and brainstorms before producing a final formatted report.

**Output template:** `@references/template.md`

## Process

### Phase 0: Clarify

Before dispatching agents, clarify with the user:

1. **Scope** — How broad or narrow? Any boundaries?
2. **Audience** — Who reads this? (technical, executive, academic, general)
3. **Specific angles** — Any dimensions to prioritize or skip?
4. **Output location** — Save to a file path, or display inline?

Ask only what's genuinely unclear. If the topic and context are specific enough, confirm your understanding and proceed.

### Phase 1: Design Agent Roster & Assemble Team

**This is a creative design step, not a lookup table.** Analyze the research topic deeply and design a team of **at least 5 agents** (more if the topic warrants it) with distinct personalities, perspectives, and research angles that will produce the most comprehensive coverage.

**How to design the roster:**

1. **Identify the key tensions** in the topic — what are the debates, trade-offs, and fault lines?
2. **Map the stakeholder perspectives** — who cares about this topic and why? Each perspective could be an agent.
3. **Ensure adversarial coverage** — at least one agent should be a skeptic/contrarian who stress-tests findings.
4. **Add cross-disciplinary reach** — at least one agent should draw from adjacent fields.
5. **Consider temporal spread** — historical context, current state, and future trajectory.

For each agent, define:
- **Name** — a descriptive slug (e.g., `regulatory-analyst`, `end-user-advocate`, `systems-thinker`)
- **Personality** — 2-3 sentences describing who they are, how they think, what they prioritize (adapted to the specific topic, not generic)
- **Research angle** — what specifically they will investigate

**Example roster for "future of remote work":**
| Agent | Personality | Angle |
|---|---|---|
| organizational-psychologist | Studies team dynamics and motivation... | Psychological impact, productivity research, isolation |
| labor-economist | Analyzes labor markets and compensation... | Wage arbitrage, talent distribution, economic effects |
| tech-infrastructure | Enterprise architect who builds remote tooling... | Tooling gaps, async-first architectures, security |
| corporate-strategist | Advises Fortune 500 on workforce planning... | Real estate, hybrid models, retention data |
| contrarian-urbanist | Skeptic who questions remote-work orthodoxy... | Urban decay, inequality, what's lost in-person |

The roster will be different for every topic. **Do not reuse a fixed set of agents.**

Create the team:

```
TeamCreate: team_name = "deep-research-{topic-slug}"
```

Create one task per agent plus 1 compilation task using `TaskCreate`.

### Phase 2: Research (Parallel)

Spawn **all agents in parallel** using the `Agent` tool with:
- `subagent_type: "general-purpose"` (required — needs MCP tool access for perplexity/exa)
- `team_name: "deep-research-{topic-slug}"`
- `run_in_background: true`

#### Agent Prompt Template

```
You are the {ROLE} on a deep research team investigating: "{TOPIC}"

**Your personality:** {PERSONALITY — 2-3 sentences adapted to the topic}
**Your research angle:** {FOCUS — what specifically to investigate}
**Scope:** {SCOPE}
**Audience:** {AUDIENCE}

## Instructions

Research this topic thoroughly from your unique angle. You MUST use these tools:

1. `mcp__plugin_perplexity_perplexity__perplexity_research` — for deep multi-source investigation (use this first, it's the most thorough)
2. `mcp__plugin_perplexity_perplexity__perplexity_search` — for finding specific URLs, facts, recent news
3. `mcp__plugin_perplexity_perplexity__perplexity_ask` — for targeted questions with citations
4. `mcp__exa__web_search_exa` — for additional web search and code/technical context

Run at least 4-6 searches from different angles related to your role. Cross-reference findings between tools. Dig deeper on surprising or contradictory results. For each search, formulate specific queries — not generic ones.

## Output Format

Return your findings EXACTLY in this structure:

### Key Discoveries
- [Finding] (Confidence: high/medium/low)
  - Supporting evidence or source

### Sources
- [Source title](URL) — what it contributed

### Open Questions
- Questions that remain unanswered from your angle

### Surprising Insights
- Anything unexpected or counterintuitive

### Raw Notes
- Additional context, quotes, data points worth preserving
```

### Phase 3: Compile

After all agents return results:

1. Read all findings carefully
2. Identify **overlapping themes** (consensus) and **contradictions** (disagreement)
3. Merge into a unified draft following `@references/template.md`
4. **Structure thematically, not by agent** — the reader should never see "the contrarian said X"; weave findings together with disagreements called out explicitly
5. Fill in all template sections — leave none empty
6. Note the cross-cutting themes with attribution to which agents surfaced them

### Phase 4: Review & Brainstorm (Parallel)

Spawn **all original agents + 1 oracle agent** in parallel with:
- `subagent_type: "general-purpose"` for the original agents
- `subagent_type: "oracle"` for the oracle
- `run_in_background: true`

Review agents may also use `mcp__plugin_perplexity_perplexity__perplexity_reason` for complex analytical reasoning about the compiled findings.

Each reviewer receives the compiled draft and these instructions:

#### Review Prompt Template

```
You are the {ROLE} reviewing a compiled research report on: "{TOPIC}"

{COMPILED_REPORT}

## Your Review Task

1. **Critique** — What's missing, wrong, weak, or misleading? Be specific.
2. **Brainstorm** — What new angles or connections emerge from seeing all the research together?
3. **Grade** — Rate overall quality and completeness (1-10) with justification.
4. **Suggestions** — List specific, actionable improvements.
```

#### Oracle-Specific Prompt

```
You are the Oracle — a second-opinion reasoning model reviewing a compiled research report on: "{TOPIC}"

{COMPILED_REPORT}

## Your Meta-Analysis Task

1. **Logical consistency** — Are the arguments sound? Any logical gaps or circular reasoning?
2. **Blind spots** — What perspectives or evidence are entirely missing?
3. **Bias check** — Is the report balanced or does it lean in a direction without justification?
4. **Confidence calibration** — Are confidence levels appropriate? Anything marked high-confidence that shouldn't be?
5. **Overall assessment** — Grade (1-10) with a direct, no-hedging verdict.
```

### Phase 5: Finalize & Deliver

1. Integrate all review feedback — prioritize oracle's meta-analysis and contrarian's critiques
2. Update confidence levels based on review consensus
3. Fill the quality score in frontmatter (average of all reviewers' grades)
4. Format the final report using `@references/template.md` with all frontmatter fields populated
5. **If user specified a save path** → write the file with the `Write` tool
6. **Otherwise** → display the full report inline
7. Clean up: `TeamDelete`

## Quick Reference

| Phase | What | Agents | Parallel? |
|-------|------|--------|-----------|
| 0 | Clarify scope | — | — |
| 1 | Design roster + create team | — | — |
| 2 | Research | 5+ (custom roster) | Yes |
| 3 | Compile | Main agent | — |
| 4 | Review | All + oracle | Yes |
| 5 | Finalize & deliver | Main agent | — |

## Common Mistakes

- **Skipping clarification** — 30 seconds of questions saves minutes of off-target research
- **Running agents sequentially** — All research agents are independent; always run in parallel with `run_in_background: true`
- **Using wrong subagent_type** — Must use `general-purpose` for MCP tool access (perplexity, exa); `researcher` type lacks MCP tools
- **Forgetting the oracle in review** — The oracle's meta-analysis catches blind spots the research team misses
- **Reusing a fixed roster** — Every topic deserves a custom-designed team; think deeply about which perspectives will produce the best coverage
- **Generic personalities** — "You are a domain expert" is lazy; write 2-3 sentences describing who this person is, how they think, and what they prioritize, specific to the topic
- **Too few agents** — Minimum 5; if the topic has more than 5 meaningful perspectives, add more agents
- **Not using both search tools** — Perplexity and exa have different strengths; perplexity_research for depth, exa for breadth/code
- **Skipping TeamDelete** — Always clean up the team after completion
- **Empty template sections** — Every section in the template must be filled; if nothing fits, explain why
