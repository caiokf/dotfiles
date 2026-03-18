---
description: Use when performing web searches, comparing libraries, or conducting multi-source research — orchestrates parallel searches across exa, perplexity, and web sources with synthesis and citation tracking. Triggers on "research", "look up", "find out", "compare options", "what libraries exist for".
---

# Search & Research Skills

Enhance search and research workflows with specialized tools and patterns.

## Tool Selection Guide

Match tool to need (see `search:patterns` for detailed hierarchy):

| Need | Tool | Strength |
|------|------|----------|
| Quick facts | WebSearch | Fast, always available |
| Library docs | Context7 | Current APIs, version-specific |
| Code examples | Context7 | Framework patterns, official usage |
| Deep research | Perplexity | Synthesis with citations |
| Parallel investigation | Explore agents | Multi-threaded research |

## MCP Availability Check

Before using MCP-dependent features, verify availability:

```
# Context7 tools
mcp__context7__resolve-library-id
mcp__context7__get-library-docs

# Perplexity tools
mcp__perplexity__perplexity_ask
mcp__perplexity__perplexity_reason
```

If tools are unavailable, fall back to WebSearch with targeted queries.

## Date Guard

All searches are validated against current date. Queries containing years older than the current year are blocked to prevent stale results.

**Opt-out**: Add "historical" to your query for intentional past data lookups.

## Progressive Enhancement

Start simple, escalate based on results (see `search:patterns` for full model):

| Level | Tools | Trigger to Escalate |
|-------|-------|---------------------|
| 1 | WebSearch | Insufficient results |
| 2 | + Context7/Perplexity | Need docs or synthesis |
| 3 | + Explore agents | Multi-faceted question |
| 4 | + User checkpoints | High-stakes decision |

**Key principle**: Escalation is reactive (based on results), not predictive. User approval required before Level 3+.

## Sub-Skills

- `caiokf:research:context7`    - Library documentation patterns
- `caiokf:research:perplexity`  - Deep research workflows
- `caiokf:research:patterns`    - General search best practices
- `caiokf:research:simple`      - Simpler Multi-step investigation workflow
- `caiokf:research:deep`        - Multi-step investigation workflow
- `caiokf:research:verify`      - Source verification and fact-checking
- `caiokf:research:plan`        - Research planning before execution
