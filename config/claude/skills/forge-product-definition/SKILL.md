---
description: Use when transforming a fuzzy idea into a clear product definition — challenges assumptions, resolves contradictions, and guides scope vs simplicity tradeoffs. For new products, apps, or features that need structuring. Triggers on "define this product", "what should we build", "scope this feature", "product definition".
---

# Product Definition

This skill provides knowledge and facilitation guidance for product definition sessions — transforming fuzzy ideas into clear, validated product definitions by challenging assumptions, resolving contradictions, and guiding tradeoff decisions. This is about figuring out WHAT to build and WHY, not technical implementation.

## When to Use

This skill should be used when:

- Starting with an idea in your head that needs structure
- Beginning a new product, app, or feature from scratch
- Needing to validate whether an idea makes sense before investing
- Wanting assumptions challenged and contradictions found
- Making hard tradeoff decisions (features vs simplicity, scope vs UX)
- Exploring how a conceptual model serves product goals

## When NOT to Use

- Already have a clear product definition and need implementation planning → create a roadmap
- Exploring a technical domain → use `/discovery`
- Designing system architecture → use `/event-modeling` or `/event-storming`
- Need a detailed PRD with specs → do that after `/define`

## Core Principles

1. **Challenge, don't just capture** — Push back on contradictions and assumptions
2. **Tradeoffs are decisions** — Force choices, don't let "both" slide
3. **Simplicity is a feature** — Every addition has a cost
4. **Model serves product** — Conceptual choices should enable product goals
5. **Clarity over completeness** — A clear subset beats a fuzzy whole

## Session Flow

### Phase 1: The Elevator Pitch (2-3 exchanges)

Get the raw idea out — what it is, who it's for, what problem it solves, why someone would use it, the one thing it must do well.

### Phase 2: The Anti-Vision (2-3 exchanges)

Define what this is NOT — non-goals, features that would be wrong, differentiation from competitors, what would make it bloated.

### Phase 3: User & Context (3-5 exchanges)

Understand who uses this and when — ideal user's situation, trigger moments, usage frequency, environment, device, mood.

### Phase 4: Core Experience (3-5 exchanges)

Define the essential interaction — core use case walkthrough, minimum for value, the "aha moment," what makes them return.

### Phase 5: Feature Boundaries (3-5 exchanges)

Draw the line — must-have vs nice-to-have vs never. Force tradeoffs between features, complexity, and polish.

### Phase 6: Model Implications (3-5 exchanges)

Explore how conceptual structure affects product potential — the "atom," relationships, history/state, structural lock-ins, scalability.

### Phase 7: Edge Cases & Exceptions (2-3 exchanges)

Find where the model breaks — empty states, scale extremes, error recovery, concurrency, worst cases.

### Phase 8: Success Criteria (2-3 exchanges)

Define what winning looks like — metrics, user advocacy, pride points, kill criteria.

### Phase 9: Synthesis & Validation (2-3 exchanges)

Confirm the definition is coherent — playback, gap identification, remaining uncertainties.

## Session Patterns

| Starting Point           | Focus                                                              |
| ------------------------ | ------------------------------------------------------------------ |
| Brand new idea           | All phases sequentially, more back-and-forth in early phases       |
| Partially formed idea    | Skim phases 1-2, focus on phases 5-6 (tradeoffs and model)         |
| Idea with contradictions | Heavy focus on Phase 2 (Anti-Vision), challenges throughout        |
| Technical founder        | Watch for implementation jumping, keep pulling to "what" and "why" |

## Output Artifact

Generate a markdown document containing:

1. One-liner description
2. Problem statement
3. Target user (situation, not demographics)
4. Core value proposition
5. Anti-Vision — explicit non-goals
6. Core experience and "aha moment"
7. Feature set — must-have, nice-to-have, out of scope
8. Conceptual model — core entity, structure, implications
9. UX principles
10. Success criteria
11. Open questions and risks
12. Next steps

## References

| File                                    | Content                                              |
| --------------------------------------- | ---------------------------------------------------- |
| `references/facilitation-prompts.md`    | Detailed facilitator prompts for each session phase  |
| `references/facilitation-techniques.md` | Challenge techniques, recovery, and pattern handling |
