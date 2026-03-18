# BPMN Workflow Discovery — Facilitator Prompts

Detailed prompts organized by session phase. Use these during facilitation to guide the conversation through each phase.

---

## Phase 1: Process Overview

### New Process

```
OPENING:
"Let's map out your workflow step by step. We'll start high-level and
drill into details where it matters. Think of this as sketching on a
whiteboard — we can always refine as we go."

FACILITATOR PROMPTS:
- "In one or two sentences, what does this process accomplish?"
- "What triggers this process to start? What signals that it's complete?"
- "Who are the main participants — people, teams, or systems involved?"
- "What's the scope? Where does this process end and another begin?"
```

### Existing File

```
OPENING:
"I've loaded [filename].bpmn. Here's what I see: [summary of process,
tasks, gateways, current state]. What would you like to work on?"

FACILITATOR PROMPTS:
- "Which part of this process should we drill into?"
- "Are there tasks here that are actually multiple steps?"
- "What's missing — exception paths, participants, integrations?"
- "Should we expand [Task X] into a subprocess?"
```

---

## Phase 2: Happy Path Discovery

```
FACILITATOR PROMPTS:
- "Walk me through the ideal scenario. What's the first thing that happens after the trigger?"
- "And then what happens? Keep going until we reach the end."
- "Who performs each of these steps?"
- "Are any of these steps happening at the same time (in parallel)?"

PROBING PROMPTS:
- "Between [Step A] and [Step B], is there anything else that happens?"
- "You mentioned [X] — is that one action or actually multiple steps?"
- "How long does [Step] typically take? Does timing matter?"
```

```
IF STUCK:
- "Let's work backwards. What's the last thing that happens before completion?"
- "Think of a specific recent instance of this process. Walk me through what happened."
```

---

## Phase 3: Decision Points & Branches

```
FACILITATOR PROMPTS:
- "At any point, are there decisions that change the flow?"
- "What questions get asked at [Step]? What are the possible answers?"
- "Are there situations where you'd skip [Step] entirely?"
- "When do different participants get involved based on conditions?"

GATEWAY IDENTIFICATION:
- "Is this an either/or decision (exclusive) or could multiple paths be taken (parallel/inclusive)?"
- "What information is needed to make this decision?"
- "Who or what makes this decision — a person, a rule, or a system?"

BRANCH EXPLORATION:
For each gateway identified:
- "If [Condition A], what happens next?"
- "If [Condition B], what's the alternative path?"
- "Do these paths eventually merge back together, or do they lead to different outcomes?"
```

---

## Phase 4: Exception Paths & Error Handling

```
FACILITATOR PROMPTS:
- "What can go wrong at [Step]? How is it handled?"
- "Are there timeouts or deadlines? What happens if they're missed?"
- "If [Step] fails, can you retry? Roll back? Escalate?"
- "Are there any steps that can be cancelled or reversed mid-process?"

COMPENSATION PROMPTS:
- "If the process needs to be undone after [Step], what gets reversed?"
- "Are there any cleanup actions needed when the process fails?"

ESCALATION PROMPTS:
- "When does a human need to intervene?"
- "What triggers an escalation? Who gets notified?"
```

---

## Phase 5: Granularity Negotiation

```
FACILITATOR PROMPTS:
- "Looking at [Step], is this one atomic action or actually several steps?"
- "For your purposes, do we need to see inside [Step] or can it stay as a black box?"
- "Who is the audience for this diagram? What decisions will they make based on it?"

DRILL-DOWN TRIGGERS:
- Step takes more than a few minutes
- Multiple people are involved in one "step"
- There are decisions hidden inside the step
- Errors need specific handling within the step

ROLL-UP TRIGGERS:
- Details are implementation-specific, not process-relevant
- Audience doesn't need to see internal mechanics
- Steps are always performed together by same person/system

SUBPROCESS EXPLORATION:
- "Let's zoom into [Step]. What's the first thing that happens inside it?"
- "Are there decision points within [Step]?"
- "What would cause [Step] to fail, and how is it handled internally?"
```

---

## Phase 6: Participants & Handoffs

```
FACILITATOR PROMPTS:
- "Let's confirm who does what. For each step, who's responsible?"
- "Where do handoffs occur between people or teams?"
- "Are there steps that require coordination between participants?"
- "Who's waiting on whom at any point?"

HANDOFF PROMPTS:
- "When [Actor A] finishes [Step], how does [Actor B] know to start?"
- "Is there a formal handoff, or does the next person just pick it up?"
- "What information passes between [Actor A] and [Actor B]?"
```

---

## Phase 7: External Systems & Integrations

```
FACILITATOR PROMPTS:
- "What external systems does this process interact with?"
- "Are there any automated steps that a system performs?"
- "Where does data come from? Where does it go?"
- "Are there any waiting points where you're expecting a response from outside?"

INTEGRATION PROMPTS:
- "Is [System] synchronous (wait for response) or asynchronous (fire and forget)?"
- "What happens if [System] is unavailable?"
- "Are there any third-party services involved — payments, notifications, shipping?"
```

---

## Phase 8: Validation & Completeness

```
FACILITATOR PROMPTS:
- "Let's walk through the diagram from start to finish. Does anything feel missing?"
- "Are there any paths that don't have a clear ending?"
- "For each decision, have we covered all the possible outcomes?"
- "Is there any scenario this diagram doesn't handle?"

COMPLETENESS CHECKS:
- Every gateway has at least two outgoing paths
- All paths eventually reach an end event
- No orphaned steps (everything is connected)
- Swimlanes are consistent (steps assigned to participants)
```

---

## Phase 9: Documentation & Artifacts

```
FACILITATOR PROMPTS:
- "Are there any business rules we should document alongside the diagram?"
- "What terms should go in the glossary for someone new to this process?"
- "Are there metrics or SLAs associated with this process?"
- "What should happen next — who needs to review this? What follow-up sessions?"
```
