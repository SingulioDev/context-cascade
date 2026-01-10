# LEARNED PATTERNS - Session 2026-01-08

## Session Context
- Task: Applied skill-forge 8-phase methodology to upgrade /council and /startup skills
- User corrected fundamental misunderstanding about Skills vs Agents
- Successfully upgraded both skills from v2.0.0 to v2.1.0 with full skill-forge compliance

---

## High Confidence Patterns [conf >= 0.85]

### Pattern 1: Skills Define SOPs, Agents Execute via Task()
**Pattern**: Skills define SOPs (Standard Operating Procedures), NOT agent execution. Use Skill() to invoke the SOP, then Task() with valid subagent_types (general-purpose, Explore, Plan, Bash, claude-code-guide, statusline-setup) to execute the work.

**Ground**: session:2026-01-08:user-correction

**Confidence**: 0.95

**Evidence**: User explicitly corrected: "you are wrong about how skills work. look up skill(skill forge)" when I attempted to do work directly after invoking a skill instead of spawning agents.

**Impact**: Fundamental to Context Cascade architecture - prevents misuse of Skill() tool and ensures proper work delegation pattern.

---

### Pattern 2: Registry Agents Are Conceptual Personas, Not Valid subagent_types
**Pattern**: The 217 registry agents (bug-fixer, security-auditor, etc.) are conceptual personas for prompts, NOT valid Task() subagent_types. Passing agent names like "bug-fixer" to Task() will fail silently or cause errors.

**Ground**: session:2026-01-08:user-correction + api-spec

**Confidence**: 0.95

**Evidence**:
- CLAUDE.md documents 217 conceptual agent personas
- Valid Task() subagent_types are ONLY: general-purpose, Explore, Plan, Bash, claude-code-guide, statusline-setup
- User correction emphasized distinction between registry agents (personas) and Task() parameter types

**Impact**: Critical for correct Task() invocation - using wrong types causes silent failures or execution errors.

---

### Pattern 3: Skill() -> Task() -> TodoWrite() Invocation Pattern
**Pattern**: Correct invocation pattern is: Skill("skill-name") -> Task("desc", "prompt", "general-purpose") -> TodoWrite(). The Skill defines WHAT to do (SOP), Task executes HOW with a valid subagent_type, TodoWrite tracks progress.

**Ground**: session:2026-01-08:user-correction

**Confidence**: 0.92

**Evidence**: User corrected when I invoked Skill("skill-forge") but didn't follow with Task() spawning. This is the core workflow pattern for Context Cascade.

**Impact**: Ensures proper separation of concerns - skills for procedural knowledge, agents for execution, todos for tracking.

---

### Pattern 4: Skill-Forge 8-Phase Methodology Works for Skill Upgrades
**Pattern**: The skill-forge 8-phase methodology (Phase 0: Expertise Loading -> Phase 1: Intent Analysis -> ... -> Phase 7: Validation) successfully upgrades existing skills to higher standards, not just creates new skills.

**Ground**: session:2026-01-08:successful-application

**Confidence**: 0.90

**Evidence**: Successfully applied methodology to upgrade /council and /startup from v2.0.0 to v2.1.0, adding Input/Output contracts, examples, anti-patterns, cross-skill coordination, MCP requirements, and GraphViz diagrams.

**Impact**: Validates skill-forge as both creation AND improvement framework.

---

### Pattern 5: GraphViz Semantic Shapes Follow Blog Post Guidelines
**Pattern**: GraphViz diagrams should use semantic shapes per blog post guidelines:
- ellipse (start/end points)
- diamond (decisions requiring user choice)
- box (actions/processes)
- octagon (warnings/checkpoints)
- cylinder (external refs/data stores)
- folder (principle/concept groups)

Color coding: green for success, yellow for decisions, orange for warnings, lightblue for actions, lightgray for external.

**Ground**: session:2026-01-08:diagram-creation

**Confidence**: 0.88

**Evidence**:
- Created council-process.dot (469 lines) and startup-process.dot (247 lines)
- Both diagrams follow semantic shape guidelines from https://blog.fsck.com/2025/09/29/using-graphviz-for-claudemd/
- Include legends, subgraph clusters, clear edge labels

**Impact**: Standardizes diagram creation across all skills for better AI comprehension and human readability.

---

## Medium Confidence Patterns [conf 0.70-0.84]

### Pattern 6: Version Increments for Enhanced Capabilities
**Pattern**: Skill version upgrades should increment from v2.0 to v2.1.0 when adding Phase 0 Expertise Loading, LEARNED PATTERNS sections, and enhanced metadata. This signals enhanced capability without breaking changes.

**Ground**: observation:2026-01-08:version-pattern

**Confidence**: 0.80

**Evidence**: Both /council and /startup upgraded from v2.0.0 to v2.1.0 after adding skill-forge v2.0 standards (contracts, examples, anti-patterns, diagrams, learned patterns).

**Impact**: Establishes versioning convention for skill improvements that don't break compatibility.

---

### Pattern 7: LEARNED PATTERNS Section for Loop 1.5 Integration
**Pattern**: When documenting skills, include a LEARNED PATTERNS section at the end to capture high/medium confidence learnings from sessions. This feeds into Loop 1.5 session reflection and Meta-Loop optimization.

**Ground**: observation:2026-01-08:documentation-pattern

**Confidence**: 0.78

**Evidence**:
- /council and /startup both received LEARNED PATTERNS sections
- /reflect skill is designed to extract these patterns
- Meta-Loop aggregates learnings every 3 days for system optimization

**Impact**: Enables continuous improvement through systematic learning capture.

---

### Pattern 8: Quality Validation Should Check Invocation Correctness
**Pattern**: Quality validation in skill-forge should explicitly check for:
- Skill() vs Task() invocation correctness
- Valid subagent_type usage (not registry agent names)
- Proper TodoWrite() integration
- Correct 3-tier pattern adherence

**Ground**: observation:2026-01-08:validation-need

**Confidence**: 0.75

**Evidence**: User had to correct fundamental invocation pattern misunderstanding, suggesting this is a common failure mode that should be caught in validation.

**Impact**: Prevents common architectural violations during skill creation/improvement.

---

## Corrections Applied This Session

### Correction 1: Task() Subagent Type Usage
**From**: Using `Task("desc", "prompt", "bug-fixer")` with registry agent names

**To**: Using `Task("desc", "prompt", "general-purpose")` with valid subagent_types

**Impact**: Prevents silent failures and ensures proper agent spawning

**Confidence**: 0.95

**Ground**: user-correction:2026-01-08

---

### Correction 2: Skill vs Agent Understanding
**From**: Treating skills as executable agents that do work directly

**To**: Understanding skills as SOP definitions that invoke agents via Task() for execution

**Impact**: Clarifies the invocation pattern and prevents architectural misuse

**Confidence**: 0.92

**Ground**: user-correction:2026-01-08

---

## Meta-Observations

1. **Architecture Clarity**: The Context Cascade architecture has a clear three-layer separation: Skills (SOPs) -> Agents (execution via Task()) -> TodoWrite (tracking). This pattern is fundamental and must be preserved.

2. **Common Confusion Point**: The distinction between registry agents (217 conceptual personas) and Task() subagent_types (6 valid types) is a common source of confusion. Documentation should emphasize the valid types list prominently in all skills.

3. **Skill-Forge Validation**: Successfully upgraded two production skills (/council, /startup) using the 8-phase methodology, validating the framework's effectiveness for both creation AND improvement tasks.

4. **GraphViz Standards**: Semantic shape usage in GraphViz diagrams improves both AI comprehension and human readability. The blog post guidelines provide excellent standards.

---

## Recommendations for Future Sessions

1. **Emphasize Valid subagent_types**: In skill documentation, prominently list the 6 valid Task() subagent_types at the top to prevent confusion with registry agents.

2. **Add Validation Gates**: Include explicit checks in skill-forge Phase 7 (Validation) to verify:
   - Skill() invocations are followed by Task() spawning
   - Task() uses valid subagent_types
   - TodoWrite() tracks progress

3. **Document Common Anti-Patterns**: Add "Skills as Agents" anti-pattern to skill-forge documentation with clear examples of correct vs incorrect usage.

4. **Memory MCP Integration**: Store these patterns in Memory MCP namespace `skills/foundry/skill-forge` for retrieval in future skill improvement sessions.

---

Confidence: 0.90 (ceiling: observation 0.95) - Session reflection for skill-forge application to /council and /startup skills.

Ground: session:2026-01-08:reflect-invocation

---

*This document captures learnings to be integrated into skill-forge SKILL.md and stored in Memory MCP for Loop 1.5 and Loop 3 optimization cycles.*
