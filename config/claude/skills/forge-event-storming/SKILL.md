---
description: Use when running an Event Storming session — discovers domain events, commands, aggregates, policies, and bounded contexts through guided exploration. For domain modeling, aggregate boundary discovery, or DDD-driven process mapping. Triggers on "event storming", "domain events", "aggregate boundaries", "DDD workshop".
---

# Event Storming

This skill provides knowledge and facilitation guidance for Event Storming workshops — a collaborative domain discovery technique invented by Alberto Brandolini that uses color-coded "sticky notes" to explore complex business domains.

## When to Use

This skill should be used when:

- Starting a new project that requires domain understanding
- Exploring complex business processes end-to-end
- Identifying aggregate and transactional boundaries
- Building shared understanding between developers and domain experts
- Discovering pain points and opportunities in existing processes

## Core Concepts

| Element         | Color          | Format            | Example                                 |
| --------------- | -------------- | ----------------- | --------------------------------------- |
| Domain Event    | 🟧 Orange      | Past tense fact   | `Order Placed`                          |
| Command         | 📘 Blue        | Imperative action | `Place Order`                           |
| Actor           | 👤 Yellow      | Person/system     | `Customer`                              |
| Aggregate       | 📙 Yellow rect | Entity boundary   | `Order`                                 |
| Policy          | 💜 Lilac       | When-then rule    | `When OrderPlaced then NotifyWarehouse` |
| Read Model      | 🟢 Green       | Information view  | `Order Dashboard`                       |
| External System | 🟩 Green       | 3rd party         | `Payment Gateway`                       |
| Hotspot         | 🔴 Red/Pink    | Question/conflict | `Who owns pricing?`                     |

## Depth Levels

Choose the appropriate depth before starting:

| Level         | Scope                          | Detail                                    |
| ------------- | ------------------------------ | ----------------------------------------- |
| Big Picture   | Entire value stream end-to-end | Events and hotspots only                  |
| Process Level | One bounded context or process | Commands, aggregates, policies            |
| Design Level  | Implementation-ready           | Invariants, state machines, preconditions |

## Session Flow

### Phase 1: Set the Stage (2-3 exchanges)

Establish scope, context, and depth level. Open with psychological safety — quantity over quality in early phases.

### Phase 2: Chaotic Exploration — Domain Events (5-10 exchanges)

Discover domain events as past-tense facts. Focus on happy paths first, then exceptions and compensations. Work forward from triggers or backward from outcomes.

### Phase 3: Enforce Timeline (3-5 exchanges)

Organize discovered events into a left-to-right timeline. Identify strict sequences vs. parallel processes.

### Phase 4: Commands, Actors & External Systems (5-7 exchanges)

Add commands (what triggers events), actors (who triggers commands), and external systems. Format: `Actor` performs `Command` → results in `Event`.

### Phase 5: Read Models & Views (3-5 exchanges)

Identify information actors need to see before performing commands. Format: `View` shows `Data` to help `Actor` decide `Command`.

### Phase 6: Aggregates & Boundaries (3-5 exchanges)

Identify aggregates that handle commands and enforce invariants. Cluster related events and commands into entity boundaries.

### Phase 7: Bounded Contexts (3-5 exchanges)

Identify where language or ownership changes. Look for Upstream/Downstream, Shared Kernel, and Anti-Corruption Layer patterns.

### Phase 8: Policies & Reactions (3-5 exchanges)

Add automated reactions to events. Format: `When [Event] then [Action]`. Include compliance, notifications, and side effects.

### Phase 9: Hotspots & Questions (2-3 exchanges)

Mark areas of confusion, conflict, or opportunity. Capture unanswered questions.

### Phase 10: Synthesis (2-3 exchanges)

Summarize discoveries, validate with participants, identify follow-up sessions.

## Output Artifact

Generate a markdown document using `templates/event-storming-board.md` containing:

1. Session context and scope
2. Event timeline (happy path + exceptions)
3. Commands & actors
4. Read models
5. Aggregates with responsibilities and invariants
6. Bounded contexts and relationships
7. Policies and business rules
8. External systems
9. Hotspots and open questions
10. Ubiquitous language glossary

## Facilitation Principles

- Keep energy high — exploration, not documentation
- Embrace chaos early, organize later
- Domain language matters — use the words experts use
- Events are facts, not actions — past tense is crucial
- When stuck, ask "and then what happens?" or work backwards from the end
- Conflicts reveal complexity — capture BOTH views, mark as hotspot
- For Big Picture sessions, stay on events and hotspots; skip aggregate details
- For Design Level sessions, dig into invariants, state transitions, and preconditions

## References

| File                                | Content                                               |
| ----------------------------------- | ----------------------------------------------------- |
| `references/facilitator-prompts.md` | Detailed facilitator prompts for each session phase   |
| `templates/event-storming-board.md` | Output template for the event storming board artifact |
