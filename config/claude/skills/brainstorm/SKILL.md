---
name: caiokf:brainstorm
description: Use when exploring a problem space and generating solution ideas — designs a custom team of 5+ agents with diverse perspectives (business, technical, user, contrarian, adjacent-field) who brainstorm in parallel, then clusters ideas, runs team critique with oracle evaluation, and outputs ranked recommendations. Triggers on "brainstorm", "ideate", "come up with ideas", "explore solutions", "what are our options".
---

# Brainstorm

## Overview

Orchestrates creative problem-space exploration by designing a team of perspective-driven agents tailored to the specific problem. Each agent brainstorms from a distinct angle, ideas are clustered by theme, then the full team + oracle evaluates feasibility, impact, and combinations before producing ranked recommendations.

**Core principle:** Diverse perspectives produce better ideas than a single mind iterating. Diverge first, converge later.

**Output template:** `@references/template.md`

## Process

### Phase 0: Frame the Problem

Before brainstorming, get clarity on:

1. **Problem statement** — What's the actual problem? (not the solution space — the problem)
2. **Context** — Current situation, constraints, what's been tried
3. **Success criteria** — What would a good solution look like?
4. **Boundaries** — What's off the table? Hard constraints?
5. **Output location** — Save to file or display inline?

Ask only what's genuinely unclear. If the user gave enough context, confirm your understanding and proceed. Don't over-interrogate — a brainstorm should feel energizing, not bureaucratic.

**If user declines to answer:** State your assumptions explicitly and proceed. A brainstorm with reasonable assumptions beats no brainstorm. You can always revisit framing after seeing the ideas.

### Phase 1: Analyze Problem Space & Design Agent Roster

**This is a creative design step.** Before generating solutions, deeply analyze the problem space to identify the right perspectives.

**How to design the roster:**

1. **Map the stakeholder map** — Who is affected by this problem? Who has power to solve it? Each meaningful stakeholder perspective could be an agent.
2. **Identify the key tensions** — What trade-offs exist? Cost vs. quality? Short-term vs. long-term? Scale vs. customization?
3. **Ensure a contrarian** — At least one agent must challenge assumptions and poke holes in conventional wisdom.
4. **Add adjacent-field thinking** — At least one agent should draw inspiration from how other industries/domains solve similar problems.
5. **Cover the value chain** — Business model, user experience, technical feasibility, go-to-market.

Design **5-8 agents** (up to 10 for highly cross-functional problems). For each agent, define:

- **Name** — a descriptive slug (e.g., `revenue-strategist`, `end-user-advocate`, `growth-hacker`)
- **Personality** — 2-3 sentences describing who they are, how they think, what they prioritize (**specific to this problem**, not generic)
- **Brainstorming angle** — What specifically they will explore and what kind of ideas they'll generate

**Example roster for "monetize a developer CLI tool":**

| Agent | Personality | Angle |
|---|---|---|
| revenue-strategist | Ex-SaaS founder who's monetized dev tools before. Thinks in terms of willingness-to-pay, conversion funnels, and unit economics. | Pricing models, packaging, revenue mechanics |
| developer-advocate | Power user who lives in the terminal. Deeply empathetic to developer workflows. Hates friction. | What developers would actually pay for vs. what kills adoption |
| platform-thinker | Sees every product as a potential platform. Thinks about network effects, ecosystems, and data moats. | Platform plays, marketplace models, data-as-product |
| bootstrapper-contrarian | Skeptical of VC playbooks. Asks "does this need to be a business at all?" Challenges growth assumptions. | Alternative models: open-core, consulting, sponsorship, non-business paths |
| adjacent-innovator | Studies how non-software industries solve monetization. Brings patterns from media, gaming, financial services. | Cross-industry inspiration, unconventional models |

The roster will be different for every problem. **Do not reuse a fixed set of agents.**

Create the team:

```
TeamCreate: team_name = "brainstorm-{topic-slug}"
```

Create one task per agent plus 1 compilation task using `TaskCreate`.

### Phase 2: Divergent Ideation (Parallel)

Spawn **all agents in parallel** using the `Agent` tool with:
- `subagent_type: "general-purpose"` (required — needs MCP tool access for optional research)
- `team_name: "brainstorm-{topic-slug}"`
- `run_in_background: true`

#### Agent Prompt Template

```
You are the {ROLE} on a brainstorming team exploring: "{PROBLEM_STATEMENT}"

**Your personality:** {PERSONALITY — 2-3 sentences adapted to the problem}
**Your brainstorming angle:** {FOCUS — what specifically to explore}
**Context:** {CONTEXT — current situation, constraints, what's been tried}
**Existing environment:** {ENVIRONMENT — if relevant: tech stack, tools in use, team structure, codebase details. Include only what grounds the brainstorm in reality.}
**Success criteria:** {CRITERIA}

## Instructions

Generate as many ideas as you can from your unique perspective. Aim for QUANTITY over quality in this phase — wild ideas are welcome. Think beyond the obvious.

**Rules for divergent thinking:**
1. No self-censoring — include ideas even if they seem impractical
2. Build on the problem context — don't ignore constraints, but push against them
3. Think at multiple scales — quick wins AND transformative changes
4. Consider combinations — "what if we combined X with Y?"
5. Draw from your specific expertise — what patterns have you seen work elsewhere?

You MAY optionally use search tools to validate assumptions or find inspiration:
- `mcp__plugin_perplexity_perplexity__perplexity_search` — for market data, competitor examples, case studies
- `mcp__plugin_perplexity_perplexity__perplexity_ask` — for quick fact-checking
- `mcp__exa__web_search_exa` — for finding real-world examples

But prioritize GENERATING IDEAS over researching. Make at most 2-3 search queries to ground ideas in real examples — the rest is pure ideation.

## Output Format

Return your ideas EXACTLY in this structure:

### Ideas (aim for 8-15)
For each idea:
- **Name:** Short memorable label
- **Description:** 2-3 sentences explaining the idea
- **Why it could work:** The core insight or mechanism
- **Biggest risk:** What could go wrong
- **Inspiration:** Where this idea comes from (your experience, another industry, etc.)

### Wild Cards
- 2-3 deliberately unconventional or provocative ideas that challenge the framing

### Patterns I Notice
- Themes or connections you see across your ideas

### Assumptions I'm Challenging
- Which constraints or assumptions in the problem statement deserve questioning
```

### Phase 3: Cluster & Compile

After all agents return:

1. Read all ideas from every agent
2. **Cluster by theme** — Group related ideas regardless of which agent proposed them. Name each cluster with a descriptive theme label. Aim for 5-8 clusters; split any cluster with >15 ideas into sub-themes.
3. **Identify overlaps** — Ideas that multiple agents converged on independently are stronger signals. Mark these with a convergence indicator (e.g., "3/5 agents proposed variants of this").
4. **Note tensions** — Where do agents' ideas directly contradict? These tensions are valuable.
5. **Merge similar ideas** — Combine near-duplicates into stronger versions
6. **Count totals** — Track how many unique ideas per theme
7. Draft the compiled output following `@references/template.md`
8. **Structure by theme, not by agent** — the reader should never see "the contrarian said X"

### Phase 4: Convergent Evaluation (Parallel)

Spawn **all original agents + 1 oracle agent** in parallel with:
- `subagent_type: "general-purpose"` for the original agents
- `subagent_type: "oracle"` for the oracle
- `run_in_background: true`

#### Evaluation Prompt Template

```
You are the {ROLE} evaluating brainstormed ideas for: "{PROBLEM_STATEMENT}"

{COMPILED_IDEAS_BY_THEME}

## Your Evaluation Task

From your perspective as {ROLE}:

1. **Top 3 picks** — Which ideas would you champion and why? Consider impact, feasibility, and adoption likelihood (will people actually do this?).
2. **Red flags** — Which 1-2 ideas have fatal flaws from your perspective? Be specific about why. (Only flag ideas you feel strongly about — this is NOT a blanket cull.)
3. **Combinations** — Which ideas work better together? Propose specific combos.
4. **Missing angles** — Now that you see everyone's ideas, what's still missing?
5. **Feasibility gut-check** — For the top ideas, what's the smallest experiment to validate them?
6. **Rank** — Order your top 5 ideas by (impact x feasibility / risk)
```

#### Oracle Agent

The oracle is a dispassionate meta-analyst with no allegiance to any perspective. It weighs trade-offs, spots groupthink, identifies second-order effects, and serves as the tiebreaker when agents disagree.

#### Oracle Evaluation Prompt

```
You are the Oracle — a second-opinion reasoning model evaluating brainstormed solutions for: "{PROBLEM_STATEMENT}"

{COMPILED_IDEAS_BY_THEME}

## Your Meta-Analysis Task

1. **Quality of ideation** — Did the team actually diverge, or are these just variations of the same idea?
2. **Blind spots** — What perspectives or solution categories are entirely missing?
3. **Assumption check** — Which ideas rely on unvalidated assumptions?
4. **Feasibility calibration** — Are effort/impact ratings realistic?
5. **Top recommendation** — If you had to pick ONE idea to pursue first, which and why?
6. **Overall assessment** — Grade the brainstorm quality (1-10) with honest reasoning.
```

### Phase 5: Synthesize & Deliver

1. **Aggregate votes** — Count how many agents picked each idea in their top 3. Ideas championed by 3+ agents are strong candidates. Ideas with 0-1 votes go to "Rejected."
2. **Apply red flags** — Only reject an idea if 2+ agents flagged it OR the oracle specifically endorsed the rejection. A single agent's objection is noted but doesn't kill an idea.
3. **Break ties with oracle** — If no clear consensus emerges, the oracle's top recommendation is the tiebreaker.
4. Build the **Top Recommendations** (3-5 ideas) with synthesized reasoning from all evaluators
5. Identify **Combinations & Synergies** that evaluators surfaced
6. Document **Rejected Ideas & Why** (valuable for the user to understand dead ends)
7. Fill in **Next Steps** with concrete, actionable first moves
8. Format final output using `@references/template.md` with all frontmatter populated
9. **If user specified a save path** → write with `Write` tool
10. **Otherwise** → display inline
11. Clean up: `TeamDelete`

## Quick Reference

| Phase | What | Agents | Parallel? |
|-------|------|--------|-----------|
| 0 | Frame problem | — | — |
| 1 | Design roster + create team | — | — |
| 2 | Divergent ideation | 5+ (custom roster) | Yes |
| 3 | Cluster & compile | Main agent | — |
| 4 | Convergent evaluation | All + oracle | Yes |
| 5 | Synthesize & deliver | Main agent | — |

## Common Mistakes

- **Jumping to solutions before framing** — Phase 0 exists because "monetize the product" and "make the product sustainable" are different problems
- **Generic agent personalities** — "You are a business expert" is useless; write 2-3 sentences describing who this person IS, specific to the problem
- **Converging too early** — Phase 2 is about QUANTITY; don't let agents self-censor or evaluate during ideation
- **Structuring output by agent** — Cluster by theme, not by who said what
- **Skipping the contrarian** — The most valuable agent is often the one who says "this is the wrong problem"
- **All ideas at the same scale** — Good brainstorms include quick wins AND moonshots; push agents to think at multiple scales
- **Ignoring combinations** — Individual ideas are often mediocre; combinations create breakthroughs
- **Reusing a fixed roster** — Every problem deserves a custom-designed team
- **Forgetting TeamDelete** — Always clean up after completion
- **Over-researching in Phase 2** — Agents should spend 80% on ideation, 20% on validation; this is a brainstorm, not a research project
