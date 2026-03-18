---
description: Use when mapping DDD bounded contexts — identifying, defining, and relating contexts within a domain. Covers monolith decomposition, service boundary design, model ownership conflicts, system integrations, and team topologies. Triggers on "bounded context", "context map", "service boundaries", "domain decomposition".
---

# Bounded Context Mapping

This skill provides knowledge and facilitation guidance for DDD Bounded Context Mapping sessions — identifying, defining, and relating bounded contexts within a domain to establish clear boundaries between different models and understand how they interact.

## When to Use

This skill should be used when:

- Decomposing a monolith into services
- Designing microservices architecture from scratch
- Understanding an existing system's implicit boundaries
- Resolving conflicts between teams over model ownership
- Planning integration between systems or teams
- Establishing team topologies and ownership

## Core Concepts

### Context Classification

| Type                 | Description                       | Investment                        |
| -------------------- | --------------------------------- | --------------------------------- |
| Core Domain          | Competitive advantage             | Build in-house, invest heavily    |
| Supporting Subdomain | Necessary but not differentiating | Build simple, don't over-engineer |
| Generic Subdomain    | Commodity functionality           | Buy or use off-the-shelf          |

### Relationship Patterns

| Pattern               | Description                       | Power Dynamic                   | When to Use                  |
| --------------------- | --------------------------------- | ------------------------------- | ---------------------------- |
| Partnership           | Mutual dependency, joint planning | Equal power                     | Close collaboration needed   |
| Customer-Supplier     | Upstream serves downstream        | Downstream can influence        | Clear service relationship   |
| Conformist            | Downstream adopts upstream model  | Upstream has all power          | Can't influence upstream     |
| Anti-Corruption Layer | Translate between models          | Downstream invests in isolation | Protect from external models |
| Shared Kernel         | Shared code/model subset          | Both must coordinate            | Tight coupling acceptable    |
| Open Host Service     | Published API for many consumers  | Provider defines interface      | Platform/service provider    |
| Published Language    | Standard interchange format       | Standard defines interface      | Industry standards exist     |
| Separate Ways         | No integration                    | Full independence               | Independence more valuable   |

### Current vs. Target State

Throughout the session, be explicit about whether mapping how things ARE today or how they SHOULD be. Use solid lines for current boundaries, dashed for proposed. Document both when they differ.

## Session Flow

### Phase 1: Set the Stage (2-3 exchanges)

Establish scope, current state (greenfield vs brownfield), teams involved, existing service boundaries. For large domains (>6-8 contexts), identify priority clusters.

### Phase 2: Domain Exploration (5-7 exchanges)

Understand the full landscape — business capabilities, core workflows, key entities. For existing systems, find implicit boundaries and "big ball of mud" areas.

### Phase 3: Linguistic Boundaries (5-7 exchanges)

Identify where language changes — the key signal for context boundaries. Document language variations across teams and areas.

### Phase 4: Context Identification (5-7 exchanges)

Draw context boundaries based on language differences. Capture name, core concepts, responsibilities, team ownership.

### Phase 5: Boundary Rationale (3-5 exchanges)

Understand WHY boundaries exist — independence drivers, compliance factors, operational needs, organizational factors.

### Phase 6: Context Classification (3-5 exchanges)

Classify each context as Core Domain, Supporting Subdomain, or Generic Subdomain.

### Phase 7: Data Ownership (3-5 exchanges)

Establish source of truth for each entity. Map creators, writers, and readers.

### Phase 8: Relationship Mapping (7-10 exchanges)

Define how contexts interact using relationship patterns. Capture direction, power dynamics, integration mechanisms, contracts.

### Phase 9: External Systems (3-5 exchanges)

Map third-party integrations. Determine which internal context owns each integration.

### Phase 10: Event Flows (3-5 exchanges)

Map domain events flowing between contexts. Identify ordering constraints and failure modes.

### Phase 11: Team Alignment (3-5 exchanges)

Map contexts to team structure. Identify misalignments and coordination overhead.

### Phase 12: Boundary Validation (3-5 exchanges)

Test boundaries with concrete scenarios. Walk through real use cases to find ambiguities.

### Phase 13: Synthesis (2-3 exchanges)

Compile context map, identify needed boundary changes and migration priorities.

## Output Artifact

Generate a markdown document using `templates/context-map.md` containing:

1. Domain overview
2. Bounded contexts with details
3. Context classification (core/supporting/generic)
4. Data ownership — source of truth for key entities
5. Ubiquitous language by context
6. Context map diagram
7. Relationship inventory with patterns
8. External systems
9. Event flows across boundaries
10. Integration specifications
11. Team alignment and gaps
12. Recommendations and migration path

## Facilitation Principles

- Follow the language — where words change meaning, boundaries exist
- Contexts are about models, not about code or databases
- Teams should own whole contexts, not parts of contexts
- Smaller contexts are easier to maintain but create integration overhead
- Not every relationship needs an ACL — sometimes conforming is fine
- Context boundaries often reveal organizational dysfunction
- The map reflects reality first, aspiration second — be honest about current state
- Power dynamics matter — Conformist means "you have no negotiating power"

## References

| File                                | Content                                                          |
| ----------------------------------- | ---------------------------------------------------------------- |
| `references/facilitator-prompts.md` | Detailed facilitator prompts for each session phase              |
| `references/common-situations.md`   | Handling contested boundaries, overlapping contexts, uncertainty |
| `templates/context-map.md`          | Output template for the context map artifact                     |
