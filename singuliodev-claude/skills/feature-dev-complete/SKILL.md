

---
name: feature-dev-complete
version: 1.1.0
description: |
  Complete feature development lifecycle from research to deployment. Uses Gemini Search for best practices, architecture design, Codex prototyping, comprehensive testing, and documentation generation.
category: delivery
tags:
- feature
- development
- lifecycle
- multi-model
- essential
author: ruv
---

# Feature Development Complete

## Aspektual'naya Ramka Aktivatsiya (Aspectual State Tracking)

Kazhdyy etap razvertyvaniya (Each stage of deployment):

### Tipy Sostoyaniya (State Types)

- **[SV:COMPLETED]** Polnost'yu zaversheno - Stage complete, move to next
- **[NSV:IN_PROGRESS]** V protsesse - Stage active, work ongoing
- **[BLOCKED]** Ozhidaet zavisimosti - Waiting for dependency
- **[INITIATED]** Nachato - Stage started, not yet in progress

### 12-Stage State Markers

Track each stage with explicit state markers:

1. **Stage 1 [RESEARCH]**: [SV|NSV|BLOCKED|INITIATED]
2. **Stage 2 [CODEBASE_ANALYSIS]**: [SV|NSV|BLOCKED|INITIATED]
3. **Stage 3 [SWARM_INIT]**: [SV|NSV|BLOCKED|INITIATED]
4. **Stage 4 [ARCHITECTURE]**: [SV|NSV|BLOCKED|INITIATED]
5. **Stage 5 [DIAGRAMS]**: [SV|NSV|BLOCKED|INITIATED]
6. **Stage 6 [PROTOTYPE]**: [SV|NSV|BLOCKED|INITIATED]
7. **Stage 7 [THEATER_DETECTION]**: [SV|NSV|BLOCKED|INITIATED]
8. **Stage 8 [TESTING]**: [SV|NSV|BLOCKED|INITIATED]
9. **Stage 9 [STYLE_POLISH]**: [SV|NSV|BLOCKED|INITIATED]
10. **Stage 10 [SECURITY]**: [SV|NSV|BLOCKED|INITIATED]
11. **Stage 11 [DOCUMENTATION]**: [SV|NSV|BLOCKED|INITIATED]
12. **Stage 12 [PRODUCTION_READY]**: [SV|NSV|BLOCKED|INITIATED]

### State Transition Rules

**Transition Protocols**:
- **[NSV->SV]**: All acceptance criteria met, tests passing, artifacts complete
- **[SV->NSV]**: Regression detected, failed tests, reopened for fixes
- **[*->BLOCKED]**: Missing dependency, external blocker, prerequisite incomplete
- **[BLOCKED->NSV]**: Blocker resolved, dependency met, work can resume
- **[INITIATED->NSV]**: Work has begun, active development underway

**Validation Checkpoints**:
Each transition requires evidence:
- Test results (for TESTING stage)
- Coverage reports (for quality gates)
- Security scan output (for SECURITY stage)
- Artifact existence (for DIAGRAMS, DOCUMENTATION)

## Keigo Wakugumi (Hierarchical Work Breakdown)

### Work Structure Hierarchy

```
EPIC: [Feature Name]
  |
  +-- STORY: User story 1 (Business value)
      |
      +-- TASK: Implementation task 1
          |
          +-- SUBTASK: Atomic work item 1.1
          +-- SUBTASK: Atomic work item 1.2
      |
      +-- TASK: Implementation task 2
          |
          +-- SUBTASK: Atomic work item 2.1
  |
  +-- STORY: User story 2 (Business value)
      |
      +-- TASK: Implementation task 3
```

### Hierarchy Levels Explained

1. **EPIC Level**: Overall feature (e.g., "User Authentication System")
2. **STORY Level**: User-facing value (e.g., "As a user, I can log in securely")
3. **TASK Level**: Technical implementation (e.g., "Implement JWT middleware")
4. **SUBTASK Level**: Atomic work units (e.g., "Write token validation function")

### Stage-to-Hierarchy Mapping

Each 12-stage workflow maps to hierarchical levels:

| Stage | Hierarchy Level | Example |
|-------|----------------|---------|
| 1-2 (Research) | EPIC planning | Define feature scope |
| 3-5 (Architecture) | STORY breakdown | User stories + design |
| 6-8 (Implementation) | TASK execution | Code, test, fix |
| 9-11 (Quality) | SUBTASK refinement | Polish, docs, security |
| 12 (Production) | EPIC completion | Deploy, validate |

## When to Use This Skill

- **Full Feature Development**: Complete end-to-end feature implementation
- **Greenfield Features**: Building new functionality from scratch
- **Research Required**: Features needing best practice research
- **Multi-Layer Changes**: Features spanning frontend, backend, database
- **Production Deployment**: Features requiring full testing and documentation
- **Architecture Design**: Features needing upfront design decisions

## When NOT to Use This Skill

- **Bug Fixes**: Use debugging or smart-bug-fix skills instead
- **Quick Prototypes**: Exploratory coding without production requirements
- **Refactoring**: Code restructuring without new features
- **Documentation Only**: Pure documen

