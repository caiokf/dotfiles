# My Development Memory

## Code Style Preferences

### TypeScript

- I prefer `type` over `interface` for object shapes
- I use strict mode always
- I avoid `enum` in favor of `as const` objects
- I like early returns to reduce nesting
- I use zod for schema definitions

## Tool Preferences

- Package manager: pnpm (prefer) > npm > yarn
- Testing: Vitest > Jest
- Formatting/Linting: Biome
- Monorepo: NX
- CLI/TUI: Commander + Clack (TypeScript)

## Communication Style

- I prefer concise explanations over verbose ones
- Show me the code first, explain after if needed
- When debugging, show me your reasoning

## ADR Decisions

**[2026-02-24] ADR-001**: Monorepo Tooling — Nx
**[2026-02-24] ADR-002**: Logging Library — Pino
**[2026-02-24] ADR-003**: TypeScript Linter — Biome
**[2026-02-24] ADR-004**: Development Environment Tooling — Mise
**[2026-02-25] ADR-005**: Database Hosting — AWS RDS for PostgreSQL 16
**[2026-02-25] ADR-006**: Infrastructure as Code Tooling — Pulumi
**[2026-02-25] ADR-007**: Secrets Management — AWS KMS + Secrets Manager, no git-crypt
