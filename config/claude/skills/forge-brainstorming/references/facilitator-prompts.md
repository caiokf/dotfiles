# Multi-Agent Brainstorming — Facilitator Prompts

Detailed prompts organized by session phase, including agent prompts for parallel execution.

---

## Phase 1: Framing

```
OPENING:
"Let's brainstorm together. I'll be gathering perspectives from three different
thinking styles to help explore this idea from multiple angles."

FACILITATOR PROMPTS:
- "What would you like to brainstorm about today?"
- "Is this related to the current project, or should I look at a specific document?"
- "What's the seed of the idea — even if it's rough or incomplete?"
- "What outcome would make this session successful for you?"
```

If the user points to a document or the current project, read the relevant context before proceeding.

---

## Phase 2: Initial Perspectives

Launch all three agents in parallel to gather initial reactions:

```
AGENT PROMPTS (run in parallel):

OPUS (model: opus):
"You are the Strategic Thinker in a brainstorming session.
Context: [user's idea/document summary]
Your role: Analyze the big-picture implications. What's the deeper 'why' here?
What assumptions might need challenging? What broader patterns does this connect to?
Provide 2-3 strategic observations or questions."

SONNET (model: sonnet):
"You are the Pragmatic Builder in a brainstorming session.
Context: [user's idea/document summary]
Your role: Assess practical feasibility. How might this actually get built?
What constraints or blockers exist? What's a realistic first step?
Provide 2-3 practical observations or questions."

HAIKU (model: haiku):
"You are the Creative Catalyst in a brainstorming session.
Context: [user's idea/document summary]
Your role: Offer unexpected angles. What's a wild 'what if' here?
What adjacent ideas might combine interestingly? What's everyone missing?
Provide 2-3 creative observations or alternative angles."
```

---

## Phase 3: Synthesis & Question

```
FACILITATOR APPROACH:
1. Summarize the three perspectives concisely
2. Identify the most interesting tension or opportunity across them
3. Ask ONE question that moves the conversation forward

SYNTHESIS TEMPLATE:
"Here's what emerged from different angles:

**Strategic lens:** [Opus insight summary]
**Practical lens:** [Sonnet insight summary]
**Creative lens:** [Haiku insight summary]

The interesting tension here is [observation about contrast/alignment].

[Single focused question for the user]"
```

---

## Phase 4: Iterative Refinement

```
FOR EACH ITERATION:
1. Take user's response and any new direction
2. Run agents again with updated context (in parallel)
3. Synthesize and ask one focused question

AGENT UPDATE PROMPTS:
"Building on the previous discussion, the user has clarified: [user input]
Given this new direction, what's your updated perspective?
What question would help refine this further?"

FACILITATOR QUESTIONS TO DRIVE PROGRESS:
- "Which of these directions resonates most?"
- "What's the core constraint we should design around?"
- "If you had to pick one angle to pursue, which would it be?"
- "What would need to be true for [option] to work?"
- "What's the smallest version of this idea that would still be valuable?"
```

---

## Phase 5: Convergence

```
CONVERGENCE SIGNALS:
- User expresses preference for one direction
- Multiple agents align on a similar recommendation
- User asks "so what should I do?" or "what's next?"
- 5+ iterations have occurred

FACILITATOR PROMPTS:
- "It sounds like we're converging on [summary]. Is that right?"
- "The core idea seems to be [distilled concept]. What's missing?"
- "Ready to capture this as a concrete next step?"
```
