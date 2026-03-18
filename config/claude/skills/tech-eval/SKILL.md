---
description: Use when evaluating tools, technologies, or approaches for a project decision — guides parallel documentation crawling, synthesis, and critical evaluation based on what actually works in production vs marketing claims. Triggers on "evaluate", "compare tools", "which should I use", "tech decision", "pick a library".
---

# Tech Eval

## Overview

**Research what tools claim, then research what teams actually use in production. The gap between the two is where bad decisions live.**

An ideas/planning document captures tool evaluations and architectural recommendations. The process: crawl docs in parallel, synthesize, critically evaluate against production reality, then rewrite honestly.

## When to Use

- Evaluating multiple tools/technologies for a project decision
- Creating a planning document in `docs/ideas/`
- User asks "research these tools and recommend an approach"
- Comparing infrastructure options (databases, frameworks, services)

**Not for**: Single-tool docs, API references, tutorials, or pure implementation guides.

## The Process

```
1. Parallel Doc Crawling     (spawn subagents, create docs/tools/*.md)
       |
2. Synthesis                 (combine into docs/ideas/<topic>.md)
       |
3. Critical Evaluation       (challenge every recommendation honestly)
       |
4. External Validation       (research production usage, not marketing)
       |
5. Honest Rewrite            (update based on what actually works)
```

### Phase 1: Parallel Doc Crawling

Spawn one subagent per tool to crawl documentation. Each creates a comprehensive file in `docs/tools/`.

**Per-tool doc structure:**
- What it does (architecture, core concepts)
- How to use it (API, SDK, MCP integration)
- What it costs (infrastructure, operational overhead)
- Maturity signals (GitHub activity, production deployments, breaking changes)

**Key rule:** Crawl docs for ALL candidate tools before forming opinions. Premature filtering kills good options.

### Phase 2: Synthesis

Combine all tool docs into a single planning document in `docs/ideas/`. Include:

- Problem statement and requirements
- Evaluation matrix (capabilities side-by-side)
- Recommended approach with rationale
- Implementation phases

This first draft will be wrong. That's expected.

### Phase 3: Critical Evaluation

Walk through the draft with the user section by section. For each recommendation, ask:

- **Could 80% of the value come from a much simpler approach?**
- What infrastructure does this actually require to run?
- What happens when it breaks at 2am?
- Is the agent already good at this without the tool? (e.g., code search)
- What's the maintenance burden in 6 months?

**The 80/20 question is the most important one.** If a curated markdown file solves most of the problem, say so -- even if it's less impressive than a knowledge graph.

### Phase 4: External Validation

Research what teams actually use in production. Spawn subagents to find:

- Real deployment stories (not vendor case studies)
- GitHub issues revealing actual pain points
- Forum posts from practitioners (not marketers)
- Benchmark claims vs independent verification

**Generate a Perplexity/web search prompt** for the user to run independently. Compare findings. Marketing claims != production reality.

**Red flags in tool evaluation:**
- No public production deployments documented
- Examples frequently broken across versions
- Vendor's own blog calls features "experimental" or "toy"
- Heavy infrastructure requirements for simple use cases

### Phase 5: Honest Rewrite

Rewrite the planning document incorporating all findings. The rewrite should:

- Lead with what actually works (not what's theoretically best)
- Use **progressive complexity** -- each phase has a specific trigger before advancing
- Include an industry research section with real sources and numbers
- Separate "what tools can do" from "what teams actually use"
- Have an honest assessment section that acknowledges limitations

## Progressive Complexity Pattern

Every ideas document should recommend a phased approach where each phase has a **concrete trigger** to advance:

```
Phase 1: Simplest thing that works        <-- START HERE
  |
  | Trigger: [specific pain point]
  v
Phase 2: Add automation
  |
  | Trigger: [specific scale limit]
  v
Phase 3: Lightweight infrastructure
  |
  | Trigger: [specific coordination problem]
  v
Phase N: Full infrastructure               <-- MAYBE NEVER
```

**"Maybe never" is a valid and common outcome for later phases.** Say so explicitly.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Recommending complex infrastructure as Phase 1 | Start with files/scripts, prove the need first |
| Trusting vendor benchmarks without independent verification | Research real-world production usage separately |
| Filtering tools before crawling all docs | Crawl everything first, form opinions second |
| Agreeing with the user instead of challenging honestly | Defend ideas you believe in, retract ones you don't |
| Skipping the "could this be simpler?" question | Always ask if 80% of value comes from 20% of complexity |
| Writing the recommendation before the research | Synthesis comes after all docs are crawled |
| Not including sources for industry claims | Every factual claim needs a link or citation |

## Quick Reference

| Step | Action | Output |
|------|--------|--------|
| Crawl | Parallel subagents per tool | `docs/tools/<tool>.md` |
| Synthesize | Combine into planning doc | `docs/ideas/<topic>.md` |
| Challenge | Walk through with user, question everything | Updated draft |
| Validate | Research production usage externally | Perplexity findings, subagent research |
| Rewrite | Incorporate all findings honestly | Final planning document |
