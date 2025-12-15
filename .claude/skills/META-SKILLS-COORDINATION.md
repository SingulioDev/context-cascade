# Meta-Skills Coordination Guide

## Overview

The three meta-skills work together in a coordinated system:

```
                    +-------------------+
                    |   AGENT CREATOR   |  <-- FOUNDRY
                    |     (v2.2.0)      |
                    +-------------------+
                            |
                            | creates
                            v
              +---------------------------+
              |     AUDITOR AGENTS        |
              | prompt | skill | expertise |
              +---------------------------+
                            |
                            | audit
                            v
     +------------------+         +------------------+
     |  PROMPT FORGE    |<------->|   SKILL FORGE    |
     |    (v1.0.0)      |         |     (v2.2.0)     |
     +------------------+         +------------------+
              |                            |
              |  (distinct from)           |
              v                            |
     +------------------+                  |
     | PROMPT ARCHITECT |<-----------------+
     |    (v2.2.0)      |  skill-forge can improve
     +------------------+

                        ALL
                         |
                         v
              +-------------------+
              |   EVAL HARNESS    |  <-- FROZEN (never self-improves)
              |     (v1.0.0)      |
              +-------------------+
```

## Skill Relationships

### Agent Creator (FOUNDRY)

**Creates**:
- Auditor agents (prompt-auditor, skill-auditor, expertise-auditor, output-auditor)
- Domain expert agents
- Any new agents needed by the system

**Is improved by**:
- prompt-forge (proposals)
- skill-forge (applies proposals)
- skill-auditor (finds issues)

### Skill Forge (META-SKILL)

**Creates/Improves**:
- All skills including itself (using previous version)
- prompt-architect
- Other skills

**Is improved by**:
- prompt-forge (proposals)
- skill-auditor (finds issues)
- Its own previous version (for self-rebuild)

### Prompt Architect (PHASE 2 SKILL)

**Optimizes**:
- USER prompts (Phase 2 of 5-phase workflow)
- NOT system prompts (that's prompt-forge)

**Is improved by**:
- prompt-forge (proposals)
- skill-forge (applies proposals)
- prompt-auditor (finds issues)

### Prompt Forge (META-PROMPT)

**Improves**:
- All prompts and skills (generates proposals)
- skill-forge prompts
- agent-creator prompts
- prompt-architect prompts
- Itself (with safeguards)

**Is improved by**:
- skill-forge (applies self-improvement proposals)
- prompt-auditor (finds issues)

### Eval Harness (FROZEN)

**Does NOT self-improve** - this is critical

**Gates**:
- All changes from the improvement loop
- Benchmarks + regression tests

**Can only be expanded**:
- Manually
- With human approval
- Never reduced

## Coordination Flows

### Flow 1: Improving a Regular Skill

```
1. skill-auditor audits target skill
2. prompt-forge generates proposals
3. skill-forge applies proposals
4. eval-harness tests changes
5. If passed: commit. If failed: reject.
```

### Flow 2: Improving Skill Forge Itself

```
1. skill-auditor audits skill-forge
2. prompt-forge generates proposals
3. skill-forge (VERSION N-1) applies proposals
4. eval-harness tests skill-forge N+1 candidate
5. If passed: commit. If failed: reject.

CRITICAL: Uses PREVIOUS version, never current
```

### Flow 3: Improving Agent Creator

```
1. skill-auditor audits agent-creator
2. prompt-forge generates proposals
3. skill-forge applies proposals
4. eval-harness tests changes
5. If passed: commit. If failed: reject.
```

### Flow 4: Creating New Auditor Agent

```
1. Loop discovers need for new auditor type
2. agent-creator creates new auditor
3. eval-harness tests new auditor
4. If passed: new auditor joins loop
```

### Flow 5: User Prompt Optimization (5-Phase Workflow)

```
1. intent-analyzer (Phase 1)
2. prompt-architect (Phase 2) <-- Optimizes user prompt
3. planner (Phase 3)
4. router (Phase 4)
5. execute (Phase 5)

NOTE: prompt-architect is Phase 2, NOT recursive improvement
```

## Version Coordination

| Skill | Version | Last Updated | Status |
|-------|---------|--------------|--------|
| agent-creator | 2.2.0 | 2025-12-15 | Active |
| skill-forge | 2.2.0 | 2025-12-15 | Active |
| prompt-architect | 2.2.0 | 2025-12-15 | Active |
| prompt-forge | 1.0.0 | 2025-12-15 | Active |
| eval-harness | 1.0.0 | 2025-12-15 | FROZEN |
| bootstrap-loop | 1.0.0 | 2025-12-15 | Active |

## Version Compatibility Matrix

Shows which versions of meta-skills are compatible with each other:

| agent-creator | skill-forge | prompt-architect | Compatible? |
|---------------|-------------|------------------|-------------|
| 2.0.x | 2.0.x | 2.0.x | YES (current) |
| 2.0.x | 2.0.x | 1.x.x | NO (missing contracts) |
| 2.0.x | 1.x.x | 2.0.x | NO (missing Phase 0) |
| 1.x.x | 2.0.x | 2.0.x | NO (missing Phase 0) |
| 1.x.x | 1.x.x | 1.x.x | YES (legacy) |

**Compatibility Rules**:
1. All meta-skills should be at the same major.minor version
2. Patch versions (x.x.N) are always compatible
3. Mixing major versions breaks contracts
4. eval-harness is version-independent (FROZEN)

## Memory Namespaces

| Namespace | Owner | Purpose |
|-----------|-------|---------|
| `agent-creator/*` | agent-creator | Agent specs, generations |
| `skill-forge/*` | skill-forge | Skill creations, improvements |
| `prompt-architect/*` | prompt-architect | Analyses, improvements |
| `improvement/*` | bootstrap-loop | Cycles, commits, rollbacks |

## Anti-Patterns

### NEVER:
1. Use prompt-architect for system self-improvement (use prompt-forge)
2. Have skill-forge rebuild itself with current version
3. Allow eval-harness to self-improve
4. Skip eval harness for any meta-skill change
5. Create agents without using agent-creator

### ALWAYS:
1. Go through eval harness for all changes
2. Use proper skill for proper purpose
3. Archive before modify
4. Track versions
5. Coordinate through memory namespaces

---

## Improvement Cycle History

| Cycle | Date | Changes | Metrics |
|-------|------|---------|---------|
| 1 | 2025-12-15 | Added Phase 0, contracts, eval integration | +30% completeness |
| 2 | 2025-12-15 | Version metadata, descriptions | +10% integration |
| 3 | 2025-12-15 | Changelogs, archives, title fixes | +25% documentation |
| 4 | 2025-12-15 | Cross-skill refs, GraphViz, consistency | +15% consistency |
| 5 | 2025-12-15 | Addendum file consistency fixes | +10% consistency |
| 6 | 2025-12-15 | Phase 0 in workflows, 8-phase refs in skill-forge | +25% Phase 0 coverage |
| 7 | 2025-12-15 | GraphViz diagrams, supporting files updated | +30% visual docs |
| 8 | 2025-12-15 | ALL files in all 3 folders verified and updated | 100% folder coverage |

---

**Version**: 1.5.0
**Last Updated**: 2025-12-15
