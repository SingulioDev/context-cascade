

---
name: meta-loop-orchestrator
version: 1.0.0
description: |
  Orchestrates the recursive self-improvement meta loop by coordinating foundry skills (agent-creator, skill-forge, prompt-forge) with Ralph Wiggum persistence loops. Use when running recursive improvem
category: orchestration
tags:
- orchestration
- meta-loop
- recursive-improvement
- foundry
- ralph-wiggum
author: Context Cascade
---

# Meta Loop Orchestrator

Orchestrates the recursive self-improvement pipeline by coordinating foundry skills with Ralph Wiggum persistence loops. This skill enables bounded self-improvement where skills, agents, and prompts can improve themselves while being gated by frozen eval harness validation.

## SKILL-SPECIFIC GUIDANCE

### When to Use This Skill

- Recursive improvement of foundry skills (agent-creator, skill-forge, prompt-forge)
- Self-improvement cycles on the plugin's own components
- Coordinating multiple foundry skills in a pipeline
- Running auditor validation on foundry outputs
- Executing eval harness gated improvement cycles

### When NOT to Use This Skill

- One-time skill/agent creation (use individual foundry skills directly)
- Tasks not involving self-improvement of plugin components
- Non-foundry skills (use cascade-orchestrator instead)
- Quick fixes without full validation cycle

### Success Criteria
- All nested Ralph loops complete within max iterations
- All 4 auditors pass validation
- Eval harness shows improvement >= 0% (no regression)
- Changes committed and monitoring initiated

### Edge Cases

- If nested Ralph loop hits max iterations: Escalate to human
- If auditor fails repeatedly: Route back to foundry skill
- If eval harness regression detected: REJECT and rollback

### Critical Guardrails

NEVER:
- Modify eval harness code (FROZEN)
- Skip auditor validation
- Commit without eval harness pass
- Disable monitoring phase
- Bypass human gates for large changes (>500 lines)

ALWAYS:
- Run all 4 auditors in parallel
- Store all intermediate states in memory-mcp
- Maintain rollback capability
- Log all iterations for debugging

## Core Architecture

```
META-LOOP ORCHESTRATION FLOW
============================

INPUT: Task + Target + Foundry Skill
                |
                v
        +---------------+
        |   PREPARE     |
        |   - Parse     |
        |   - Load exp  |
        |   - Select    |
        +---------------+
                |
                v
    +=======================+
    |   EXECUTE (Ralph #1)  |
    |   Foundry skill runs  |
    |   until proposal ready|
    +=======================+
                |
                v
    +=======================+
    |  IMPLEMENT (Ralph #2) |
    |   Apply changes to    |
    |   target file(s)      |
    +=======================+
                |
                v
    +-------+-------+-------+-------+
    |       |       |       |       |
    v       v       v       v       v
  [R#3]   [R#4]   [R#5]   [R#6]   <- Parallel Ralph Loops
  Prompt  Skill   Expert  Output
  Audit   Audit   Audit   Audit
    |       |       |       |
    +-------+-------+-------+
                |
                v
    +=======================+
    |    EVAL (Ralph #7)    |
    |    Run eval harness   |
    |    Fix until pass     |
    +=======================+
                |
                v
        +---------------+
        |    COMPARE    |
        |   baseline vs |
        |   candidate   |
        +---------------+
                |
        +-------+-------+
        |               |
        v               v
     ACCEPT          REJECT
        |               |
        v               v
     COMMIT        LOG FAILURE
        |           (retry)
        v
    +=======================+
    |  MONITOR (Ralph #8)   |
    |    7-day watch        |
    +=======================+
        |
        v
     COMPLETE
```

## Phase Definitions

### Phase 1: PREPARE

```yaml
prepare:
  actions:
    - Parse task and target from input
    - Detect domain from target

