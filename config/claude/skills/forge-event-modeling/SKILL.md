---
description: Use when designing system blueprints with Event Modeling — maps information flow from UI through commands, events, and read models. For end-to-end feature design, CQRS/event-sourced architectures, or shared frontend-backend blueprints. Triggers on "event modeling", "system blueprint", "CQRS design", "information flow diagram".
---

# Event Modeling

This skill provides knowledge and facilitation guidance for Event Modeling sessions — a system design technique created by Adam Dymitruk that produces a complete blueprint showing how information flows from user interface through commands, events, and read models.

## When to Use

This skill should be used when:

- Domain events from an Event Storming need to be translated into system design
- Designing a new feature or user journey end-to-end
- Creating a shared blueprint between frontend, backend, and infrastructure teams
- Planning CQRS or event-sourced architectures
- Documenting existing system flows with Given-When-Then specifications

## Core Concepts — Four Swimlanes

The model uses four horizontal swimlanes arranged in a left-to-right timeline:

```
┌─────────────────────────────────────────────────────────────────┐
│  UI/UX        │ [Wireframes and screens - white]                │
├───────────────┼─────────────────────────────────────────────────┤
│  Commands     │ [User intentions - blue]                        │
├───────────────┼─────────────────────────────────────────────────┤
│  Events       │ [Facts that happened - orange]                  │
├───────────────┼─────────────────────────────────────────────────┤
│  Read Models  │ [Query-side projections - green]                │
├───────────────┼─────────────────────────────────────────────────┤
│  Automation   │ [Policies & processors - lilac]                 │
└───────────────┴─────────────────────────────────────────────────┘
                 ─────────────────────────────────────────────────→
                              TIME (left to right)
```

- **Blue commands** are synchronous intent
- **Orange events** are asynchronous facts
- Every command should produce at least one event
- Every event should be consumed by at least one read model or automation

## Session Flow

### Phase 1: System Context (2-3 exchanges)

Establish what system/feature is being modeled, actors, key business rules, existing systems, and compliance requirements.

### Phase 2: UI Screens & Data Requirements (3-5 exchanges)

Start with what the user sees — white boxes. Capture screens, fields (with types and validation), actions, empty states, error messages.

### Phase 3: Commands — Blue Boxes (5-7 exchanges)

Define commands users trigger. Capture payload, preconditions, rejection events, authorization, idempotency strategy.

### Phase 4: Events — Orange Boxes (5-7 exchanges)

Record events resulting from commands. Capture data schemas, versioning, ordering constraints, metadata (correlationId, timestamp, actor).

### Phase 5: Read Models — Green Boxes (5-7 exchanges)

Define read models powering the UI. Capture fields, source events, freshness requirements (real-time / near real-time / eventually consistent / cached), access controls.

### Phase 6: Automation & Policies — Lilac Swimlane (3-5 exchanges)

Add automated processes reacting to events. Capture failure handling, retry strategies, escalation paths, priority ordering.

### Phase 7: Timeline Organization (3-5 exchanges)

Arrange everything into coherent left-to-right timeline. Identify lifecycle phases, saga coordination needs, compensating actions, and gaps.

### Phase 8: Given-When-Then Specifications (3-5 exchanges)

Create executable specifications for happy paths, alternative scenarios, boundary conditions, failure modes, and security edge cases.

### Phase 9: Synthesis (2-3 exchanges)

Compile complete event model, quantify elements, identify gaps and risks, determine implementation priority.

## Output Artifact

Generate a markdown document using `templates/event-model.md` containing:

1. System overview and scope
2. UI/Wireframes — screens and purpose
3. Commands — full list with payloads
4. Events — full list with data schemas
5. Read models — projections and sources
6. Automations — policies and processors
7. Specifications — Given-When-Then scenarios
8. Implementation notes — tasks and open questions

## Common Pitfalls

| Pitfall                           | Problem                                                           |
| --------------------------------- | ----------------------------------------------------------------- |
| Commands without failure events   | What happens when preconditions aren't met?                       |
| Orphan events                     | Events not consumed by any read model or automation indicate gaps |
| Unclear freshness                 | "Fast" is not a requirement — specify latency bounds              |
| No failure handling in automation | What if the email service is down?                                |
| Missing idempotency               | Distributed systems have at-least-once delivery                   |
| Undocumented authorization        | Who can actually execute this command?                            |

## Facilitation Principles

- Start with what the user sees — UI first grounds the conversation
- The timeline is the spec — it shows what to build and in what order
- Validate at each transition: "Every command produces event(s), every event feeds a read model or automation"

## References

| File                                  | Content                                             |
| ------------------------------------- | --------------------------------------------------- |
| `references/facilitator-prompts.md`   | Detailed facilitator prompts for each session phase |
| `references/unsticking-techniques.md` | Techniques for when participants get blocked        |
| `templates/event-model.md`            | Output template for the event model artifact        |
