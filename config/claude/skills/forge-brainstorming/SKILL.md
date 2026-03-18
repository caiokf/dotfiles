---
description: Use when exploring ideas with structured multi-perspective brainstorming — three AI agents (Strategic, Pragmatic, Creative) debate in parallel. For getting unstuck, fleshing out early concepts, or generating diverse perspectives. Triggers on "brainstorm with agents", "multi-perspective", "get unstuck", "creative ideation".
---

# Multi-Agent Brainstorming

This skill provides knowledge and facilitation guidance for multi-perspective brainstorming sessions using three AI agents with different thinking styles (Strategic, Pragmatic, Creative) to explore ideas from multiple angles through iterative refinement.

## When to Use

This skill should be used when:

- Starting with a vague idea that needs shape
- Exploring possibilities for a new feature or project
- Getting unstuck on a problem with no clear solution
- Wanting diverse perspectives on an approach
- Fleshing out a concept before implementation

## Agent Roles

| Agent              | Thinking Style         | Focus                                              | Question Type |
| ------------------ | ---------------------- | -------------------------------------------------- | ------------- |
| Opus (Strategic)   | Big-picture, long-term | Implications, assumptions, patterns                | "Why?"        |
| Sonnet (Pragmatic) | Practical, feasible    | Implementation, constraints, next steps            | "How?"        |
| Haiku (Creative)   | Novel, unexpected      | Lateral thinking, fresh perspectives, alternatives | "What if?"    |

## Session Flow

### Phase 1: Framing (1-2 exchanges)

Establish the brainstorm focus — what to brainstorm, relevant context (project/document), seed of the idea, success criteria.

### Phase 2: Initial Perspectives (1 exchange)

Launch all three agents in parallel to gather initial reactions. Each provides 2-3 observations or questions from their perspective.

### Phase 3: Synthesis & Question (1 exchange)

Summarize agent perspectives, identify the most interesting tension or opportunity across them, ask ONE focused question.

### Phase 4: Iterative Refinement (3-7 exchanges)

Based on user response, run agents again with updated context. Synthesize and ask one focused question per iteration. Drive progress with focusing questions.

### Phase 5: Convergence (1-2 exchanges)

When ideas take shape — user expresses preference, agents align, or 5+ iterations — drive toward synthesis.

### Phase 6: Output (1 exchange)

Produce summary: the idea (2-3 sentences), key insights, open questions, suggested next steps.

## Execution Instructions

1. **Start by framing** — Ask what to brainstorm and gather context
2. **Read context if needed** — If user points to a file or project, read relevant files first
3. **Run agents in parallel** — Use the Task tool with different models:
   - `subagent_type: "generalPurpose"` with `model: "opus"` for strategic
   - `subagent_type: "generalPurpose"` with `model: "sonnet"` for pragmatic
   - `subagent_type: "generalPurpose"` with `model: "haiku"` for creative
4. **Synthesize and ask ONE question** — Don't overwhelm with multiple questions
5. **Iterate until convergence** — Usually 3-7 rounds of agent consultation
6. **Produce summary** — Capture what emerged when ideas take shape

## Output Artifact

```markdown
## Brainstorm Summary: [Topic]

### The Idea

[2-3 sentence distillation of the refined concept]

### Key Insights

- [Strategic insight that shaped the direction]
- [Practical constraint or opportunity identified]
- [Creative angle that added value]

### Open Questions

- [Unresolved question worth exploring]
- [Risk or assumption to validate]

### Suggested Next Steps

1. [Concrete first action]
2. [Follow-up exploration if relevant]
```

## Facilitation Principles

- Keep agent consultations brief — quick perspectives, not essays
- ONE question at a time to the user — don't overwhelm
- Let interesting tensions drive the conversation forward
- It's okay if agents disagree — that's valuable signal
- Watch for convergence signals and help close the loop
- If stuck, ask "what would make this clearer?"

## References

| File                                | Content                                                       |
| ----------------------------------- | ------------------------------------------------------------- |
| `references/facilitator-prompts.md` | Detailed facilitator and agent prompts for each session phase |
