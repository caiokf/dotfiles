---
description: Use when exploring an unfamiliar problem space before committing to a specific modeling technique — facilitates domain discovery through guided conversation to identify concepts, workflows, business rules, and vocabulary. Triggers on "domain discovery", "explore the domain", "understand the business", "what modeling approach should I use".
---

# Domain Discovery

This skill provides knowledge and facilitation guidance for open-ended Domain Discovery sessions — exploring and understanding a problem space before committing to specific modeling techniques. This is the most flexible session type, ideal for early exploration.

## When to Use

This skill should be used when:

- Starting a brand new project with an unfamiliar domain
- Exploring a problem space before deciding on a solution approach
- Onboarding to an existing system that needs understanding
- Conducting initial stakeholder interviews and knowledge capture
- Unsure whether to use Event Storming, Event Modeling, or something else
- Building shared vocabulary before diving into details

## Session Flow

> **Note on Structure**: These phases are areas to explore, not a strict sequence. When a participant mentions something from a later area, follow that thread while it's fresh. Return to earlier areas as needed. The goal is coverage, not sequence.

### Phase 1: Set the Stage (2-3 exchanges)

Establish the exploration scope — domain/system/problem, current knowledge level, goal of exploration, specific questions to answer.

### Phase 2: The 30,000-Foot View (3-5 exchanges)

Get the big picture — what the system does, main users/actors, core value, what breaks without it, adjacent systems.

### Phase 3: Business Drivers & Strategy (3-5 exchanges)

Understand WHY this domain matters — business problems solved, revenue/cost impact, strategic priorities, KPIs, SLAs.

### Phase 4: Core Concepts (5-7 exchanges)

Identify essential entities and concepts — key "things," relationships, lifecycles, types and variations. Build a concept inventory: name, definition, relationships, lifecycle states.

### Phase 5: Key Workflows (5-7 exchanges)

Understand what people actually do — main processes, triggers, happy paths, decisions, handoffs. Map data flows: information needed, data created/modified, sources of truth.

### Phase 6: Domain Events (3-5 exchanges)

Discover significant things that happen — state changes, triggers, consequences, external events, audit requirements.

### Phase 7: Pain Points & Complexity (3-5 exchanges)

Find where the dragons live — what's hard, what people complain about, edge cases, hidden/unwritten knowledge.

### Phase 8: Business Rules & Constraints (3-5 exchanges)

Uncover the rules — invariants, regulations, calculations, temporal rules, SLAs.

### Phase 9: Language & Vocabulary (3-5 exchanges)

Establish ubiquitous language — jargon, ambiguous terms, newcomer confusion, domain expert corrections.

### Phase 10: Boundaries & Scope (3-5 exchanges)

Define what's in and what's out — responsibility boundaries, handoffs, subdomains, core vs. supporting, team ownership.

### Phase 11: Historical Context (2-3 exchanges)

Understand how we got here — evolution, legacy constraints, regretted decisions, business/tech constraint separation.

### Phase 12: Future Direction (2-3 exchanges)

Understand where things are headed — roadmap, new capabilities, what you'd change, 2-year vision.

### Phase 13: Synthesis & Next Steps (2-3 exchanges)

Summarize, validate, identify open questions, and recommend next technique based on findings.

## Technique Recommendations

Based on discovery findings, recommend the appropriate next session:

| Finding                               | Recommended Next Step              |
| ------------------------------------- | ---------------------------------- |
| Complex workflows with many events    | `/event-storming` (Event Storming)   |
| Need to design a system end-to-end    | `/event-modeling` (Event Modeling)   |
| Multiple teams or systems interacting | `/bounded-contexts` (Context Mapping)|
| Production readiness concerns         | `/residuality` (Stressor Analysis) |

## Output Artifact

Generate a markdown document containing:

1. Session metadata — date, participants, scope, goal
2. Domain summary — one-paragraph overview
3. Actors & stakeholders — who's involved and what they care about
4. Business drivers — why this domain matters, key metrics
5. Core concepts — glossary with relationships and lifecycles
6. Key workflows — main processes and their steps
7. Domain events — significant things that happen
8. Business rules — constraints and invariants
9. Pain points — complexity and problem areas
10. Boundaries — what's in scope and adjacent
11. Ubiquitous language — vocabulary, definitions, confusion points
12. Historical context — legacy constraints, tech debt
13. Future direction — roadmap, vision, upcoming requirements
14. Open questions & hotspots — unresolved items needing follow-up
15. Recommended next steps — which session to run next

## Facilitation Principles

- This is exploration, not interrogation — be curious and follow threads
- There are no wrong answers — capture everything, filter later
- Ask "why?" and "tell me more" liberally
- Use stories: "Can you give me an example?" gets better answers than abstract questions
- Draw connections between concepts as they emerge
- Contradictions and confusion are valuable signals — don't resolve them too quickly
- Domain experts often know more than they think — help them articulate it
- When you're confused, the domain is probably complicated — that's useful information
- **Adaptive depth**: Spend more time where you encounter complexity or disagreement
- End with concrete next steps — discovery should lead somewhere

## References

| File                                | Content                                                       |
| ----------------------------------- | ------------------------------------------------------------- |
| `references/facilitator-prompts.md` | Detailed facilitator prompts for each session phase           |
| `references/recovery-techniques.md` | Recovery techniques when conversation stalls or goes sideways |
