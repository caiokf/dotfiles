---
description: Use when generating C4 architecture documentation from an existing codebase — bottom-up analysis producing context, container, component, and code diagrams. For onboarding docs, stakeholder overviews, or API documentation. Triggers on "C4 diagram", "architecture documentation", "document this codebase", "system context diagram".
---

# C4 Architecture Documentation

This skill provides knowledge and workflow guidance for generating comprehensive C4 architecture documentation from an existing codebase using bottom-up analysis — from code level through components, containers, to system context.

## When to Use

This skill should be used when:

- Documenting an existing codebase for new team members
- Creating architecture overview for stakeholders
- Generating API documentation from code analysis
- Building a complete architecture documentation set

## Prerequisites

- Access to the codebase root directory
- Understanding of deployment structure (Docker, K8s, cloud services)
- Knowledge of external system integrations

## Workflow Overview

```
Phase 1: Code Level      →  Analyze directories bottom-up
Phase 2: Component Level →  Synthesize into logical components
Phase 3: Container Level →  Map to deployment units + APIs
Phase 4: Context Level   →  Create stakeholder-friendly overview
```

**Note**: Per the [C4 model](https://c4model.com/diagrams), most teams only need Context and Container diagrams. Generate all levels for completeness, but stop at any phase if sufficient.

## Phase Summaries

### Phase 1: Code-Level Documentation

Document every code directory from deepest to shallowest. For each directory, identify functions/methods, classes/modules, internal and external dependencies, and design patterns. Output: `c4-code-[directory-name].md` per directory.

### Phase 2: Component-Level Synthesis

Group code documentation into logical components by domain, technical, or organizational boundaries. Document responsibilities, interfaces, and dependencies. Create component index with master Mermaid diagram.

### Phase 3: Container-Level Synthesis

Map components to deployment units by analyzing Dockerfiles, K8s manifests, Terraform configs, etc. Document container APIs with OpenAPI specifications. Create container diagram.

### Phase 4: Context-Level Documentation

Create stakeholder-friendly system overview. Identify all personas (human and programmatic), document system features and user journeys, map external dependencies. Create context diagram.

## Output Structure

```
C4-Documentation/
├── c4-context.md              # Level 1: System context (start here)
├── c4-container.md            # Level 2: Deployment architecture
├── c4-component.md            # Level 3: Component index
├── c4-component-[name].md     # Level 3: Individual components
├── c4-code-[name].md          # Level 4: Code-level docs
└── apis/
    └── [container]-api.yaml   # OpenAPI specs
```

## Success Criteria

- Every code directory has a `c4-code-*.md` file
- Code docs include complete function signatures and dependencies
- Components have clear boundaries and responsibilities
- Component index includes relationship diagram
- Containers map to actual deployment units
- Container APIs have OpenAPI specifications
- Context includes all personas (human + programmatic)
- User journeys documented for key features
- All external dependencies identified
- Mermaid diagrams render correctly at each level
- Documentation links work between levels

## Configuration Options

| Option             | Default                         | Description                    |
| ------------------ | ------------------------------- | ------------------------------ |
| `target_directory` | repo root                       | Root directory to analyze      |
| `output_directory` | C4-Documentation/               | Where to write docs            |
| `exclude_patterns` | node_modules, .git, build, dist | Directories to skip            |
| `include_tests`    | true                            | Analyze test files for context |
| `api_format`       | openapi                         | Format for API specs           |
| `levels`           | all                             | Which C4 levels to generate    |

## Tips

- **Start with Context**: Even if generating bottom-up, review `c4-context.md` first for the big picture
- **Skip Code level for simple areas**: Only generate `c4-code-*.md` for complex modules
- **Update incrementally**: Re-run on changed directories rather than full regeneration
- **Review with stakeholders**: Context diagram should make sense to non-technical people
- **Validate APIs**: Test generated OpenAPI specs with Swagger UI or similar tools

## References

| File                                   | Content                                                               |
| -------------------------------------- | --------------------------------------------------------------------- |
| `references/workflow-phases.md`        | Detailed tasks and actions for each phase                             |
| `references/documentation-patterns.md` | C4 documentation templates, Mermaid syntax, and validation checklists |
