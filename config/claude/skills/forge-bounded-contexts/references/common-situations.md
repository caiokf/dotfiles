# Bounded Context Mapping — Handling Common Situations

## When Boundaries Are Contested

- "Let's explore both options. What would we gain if [Boundary A]? What would we lose?"
- "What concrete scenario would help us decide which boundary is better?"
- "Is this a permanent decision or can we start with one and evolve?"
- "Let's capture both perspectives and mark this as 'needs validation.'"

## When Contexts Seem to Overlap

- "Both contexts need [Concept]. What attributes does each actually need?"
- "Is this overlap or the same concept viewed through different lenses?"
- "Could one context be the source of truth while others get projected views?"
- "Is a Shared Kernel appropriate, or would translation be safer?"

## When You're Uncertain

- "It's okay to mark this boundary as 'provisional — needs validation.'"
- "What would we need to learn to be confident about this boundary?"
- "Let's document the uncertainty: 'Could be one context or two, depending on [factor].'"

## When Sessions Go Sideways

- If stuck on one boundary: "Let's park this and come back. What other boundaries are clearer?"
- If drowning in detail: "We're in the weeds. What's the one-sentence summary?"
- If earlier context was wrong: "We've learned something. Let's update before continuing."
- If two people are looping: "I'm hearing two perspectives. Let's capture both and move on."

## Context Map Diagram Format

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   ┌──────────────┐         Partnership        ┌──────────────┐ │
│   │              │◄──────────────────────────►│              │ │
│   │   Orders     │                            │   Payments   │ │
│   │   (Core)     │                            │  (Support)   │ │
│   └──────────────┘                            └──────────────┘ │
│          │                                           ▲         │
│          │ Customer-Supplier                         │         │
│          ▼                                           │         │
│   ┌──────────────┐                            ┌──────────────┐ │
│   │              │         Conformist         │              │ │
│   │   Shipping   │───────────────────────────►│   Billing    │ │
│   │  (Support)   │                            │  (Generic)   │ │
│   └──────────────┘                            └──────────────┘ │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```
