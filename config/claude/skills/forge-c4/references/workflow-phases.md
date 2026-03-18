# C4 Architecture — Detailed Workflow Phases

Step-by-step tasks for each phase of C4 documentation generation.

---

## Phase 1: Code-Level Documentation

### 1.1 Discover Directories

```
ACTIONS:
1. List all subdirectories in the codebase
2. Sort by depth (deepest first for bottom-up processing)
3. Filter out: node_modules, .git, build, dist, __pycache__, vendor, etc.
4. Create processing queue
```

### 1.2 Document Each Directory

For each directory, create a `c4-code-[directory-name].md` file:

```
ANALYSIS TASKS:
- Identify all functions/methods with complete signatures
- Document classes, modules, and their relationships
- Map internal dependencies (imports from this codebase)
- Map external dependencies (libraries, frameworks)
- Note design patterns in use
- Create Mermaid diagram if relationships are complex

OUTPUT: C4-Documentation/c4-code-[sanitized-directory-name].md
```

**Repeat for every directory** until all have corresponding documentation.

---

## Phase 2: Component-Level Synthesis

### 2.1 Analyze Code Documentation

```
ANALYSIS TASKS:
- Review all c4-code-*.md files from Phase 1
- Identify logical boundaries:
  - Domain boundaries (related business functionality)
  - Technical boundaries (shared frameworks, patterns)
  - Organizational boundaries (team ownership if evident)
- Group related code files into components
```

### 2.2 Create Component Documentation

For each identified component:

```
DOCUMENTATION TASKS:
- Name the component descriptively
- Define its responsibilities and purpose
- List software features it provides
- Document interfaces (APIs, methods, contracts)
- Link to contained c4-code-*.md files
- Map dependencies on other components
- Create Mermaid component diagram

OUTPUT: C4-Documentation/c4-component-[component-name].md
```

### 2.3 Create Component Index

```
CREATE: C4-Documentation/c4-component.md

CONTENTS:
- List of all components with descriptions
- Links to individual component docs
- Master Mermaid diagram showing all component relationships
```

---

## Phase 3: Container-Level Synthesis

### 3.1 Analyze Deployment Definitions

```
SEARCH FOR:
- Dockerfiles
- docker-compose.yml
- Kubernetes manifests (deployment, service, ingress)
- Terraform / CloudFormation configs
- Cloud function definitions (AWS Lambda, Azure Functions)
- CI/CD pipeline definitions
- Package.json scripts, Procfiles, etc.
```

### 3.2 Map Components to Containers

```
ANALYSIS TASKS:
- Determine which components deploy together
- Identify container boundaries from deployment configs
- Map technology stacks per container
- Identify inter-container communication patterns
```

### 3.3 Create Container Documentation

```
DOCUMENTATION TASKS:
- Document each container (type, technology, deployment)
- List components deployed in each container
- Document all container APIs/interfaces
- Create OpenAPI specs for REST APIs
- Map container dependencies and protocols
- Link to deployment configurations
- Create Mermaid container diagram

OUTPUT:
- C4-Documentation/c4-container.md
- C4-Documentation/apis/[container]-api.yaml (per container with APIs)
```

---

## Phase 4: Context-Level Documentation

### 4.1 Analyze System Documentation

```
GATHER:
- README files
- Architecture documentation
- Requirements documents
- Test files (to understand behavior)
- API documentation
- User documentation
```

### 4.2 Create Context Documentation

```
DOCUMENTATION TASKS:
- Write system overview (short + long descriptions)
- Identify all personas:
  - Human users (roles, goals, features used)
  - Programmatic users (external systems, API consumers)
- Document system features with user mappings
- Create user journey maps for key features
- Document all external dependencies
- Create Mermaid context diagram

OUTPUT: C4-Documentation/c4-context.md
```
