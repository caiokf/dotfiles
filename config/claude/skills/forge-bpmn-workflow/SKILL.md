---
description: Use when discovering and modeling business processes as BPMN workflows — guided conversation to map processes, discover edge cases and decision points, and iteratively refine diagrams. Triggers on "business process", "workflow discovery", "process map", "model a workflow".
---

# BPMN Workflow Discovery

This skill provides knowledge and facilitation guidance for interactive BPMN workflow discovery sessions — modeling business processes through guided conversation and iterative refinement to find the right level of granularity.

## When to Use

This skill should be used when:

- A high-level process idea needs fleshing out
- Determining appropriate diagram granularity
- Discovering edge cases, exceptions, and decision points
- Validating process understanding with stakeholders
- Modeling cross-team workflows

## When NOT to Use

- Already know exactly what to diagram → use `/bpmn` directly
- Exploring a domain without a specific process → use `/discovery`
- Focusing on events and eventual consistency → use `/event-storming`

## Invocation Modes

### New Process

Start fresh — discovers process from scratch, creates new `.bpmn` file.

### Refine Existing Process

Load existing `.bpmn` file, summarize current state, then continue refinement:

- Drill into a subprocess
- Add missing exception paths
- Expand a collapsed task
- Add participants/lanes

When refining, skip completed phases and jump to the relevant work.

## Session Flow

### Phase 1: Process Overview (2-3 exchanges)

Establish the process context and boundaries (new) or summarize existing file and ask what to work on (refine). Capture process name, trigger, outcome, key participants.

### Phase 2: Happy Path Discovery (3-5 exchanges)

Map the main flow without exceptions. Walk through ideal scenario start to finish, identify parallel steps and hidden sub-steps.

**OUTPUT:** Generate initial Level 0 diagram showing the happy path.

### Phase 3: Decision Points & Branches (3-5 exchanges)

Discover gateways and alternative paths. Identify exclusive vs parallel vs inclusive gateways, decision criteria, and who/what makes each decision.

**OUTPUT:** Update diagram with decision gateways and branches.

### Phase 4: Exception Paths & Error Handling (3-5 exchanges)

Discover what happens when things go wrong — failures, timeouts, retries, rollbacks, cancellations, escalations.

**OUTPUT:** Add error events, compensation flows, and escalation paths.

### Phase 5: Granularity Negotiation (3-5 exchanges)

Find the right level of detail. Drill down when steps take multiple minutes, involve multiple people, or contain hidden decisions. Roll up when details are implementation-specific or audience doesn't need them.

**OUTPUT:** Create subprocess diagrams for expanded steps.

### Phase 6: Participants & Handoffs (2-3 exchanges)

Clarify roles, transitions, and handoff mechanisms between people/teams.

**OUTPUT:** Update diagrams with swimlanes and handoff points.

### Phase 7: External Systems & Integrations (2-3 exchanges)

Identify system touchpoints, sync vs async interactions, data flows, and failure handling for external dependencies.

**OUTPUT:** Add system tasks and message events.

### Phase 8: Validation & Completeness (2-3 exchanges)

Review and fill gaps. Ensure every gateway has 2+ paths, all paths reach an end event, no orphaned steps, lanes are consistent.

### Phase 9: Documentation & Artifacts (2-3 exchanges)

Capture business rules, glossary terms, metrics/SLAs, and identify reviewers and follow-up sessions.

## Granularity Guidance

| Signal                      | Action                          |
| --------------------------- | ------------------------------- |
| "It depends..."             | Add a gateway                   |
| "Well, first we... then..." | Consider subprocess             |
| "Someone has to approve..." | Add decision gateway with actor |
| "Unless it fails..."        | Add error path                  |
| "At the same time..."       | Add parallel gateway            |
| "We wait for..."            | Add intermediate event          |
| "The system does..."        | Add service task                |

## Output Artifacts

Generate BPMN 2.0 XML files (`.bpmn`):

```
[process-name]/
├── [process-name].bpmn              # Main process (Level 0)
├── [subprocess-a].bpmn              # Expanded subprocess
├── [subprocess-b].bpmn              # Expanded subprocess
└── ...
```

Progressive output — diagrams are updated after each major phase.

## Iteration Pattern

This skill supports iterative refinement across multiple sessions:

```
Session 1: Discover Level 0 (happy path + major decisions)
    └─► Output: order-fulfillment.bpmn
Session 2: Expand subprocess, add error handling
    └─► Output: updated .bpmn files
Session 3: Add remaining exception paths
    └─► Output: complete, validated .bpmn files
```

## Facilitation Principles

- Start broad, narrow down — easier to add detail than remove it
- Use the participant's language — match their terminology
- Sketch before perfecting — rough diagrams spark better discussions
- Time-box deep dives — don't get lost in one subprocess
- Mark uncertainties as hotspots — capture what you don't know
- Diagrams are communication tools — optimize for the audience

## References

| File                                | Content                                                   |
| ----------------------------------- | --------------------------------------------------------- |
| `references/facilitator-prompts.md` | Detailed facilitator prompts for each session phase       |
| `../bpmn/SKILL.md`                  | BPMN 2.0 XML element reference for generating .bpmn files |
