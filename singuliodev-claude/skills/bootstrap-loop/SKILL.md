

---
name: bootstrap-loop
version: 1.0.0
description: |
  Orchestrates the recursive self-improvement cycle where Prompt Forge improves Skill Forge, Skill Forge improves Prompt Forge, and both audit/improve everything else. All changes gated by frozen eval h
category: foundry
tags:
- recursive
- self-improvement
- dogfooding
- orchestration
author: system
---

# Bootstrap Loop (Recursive Self-Improvement Orchestrator)

## Purpose

Orchestrate the recursive improvement cycle:

```
+------------------+         +------------------+
|   PROMPT FORGE   |-------->|   SKILL FORGE    |
| (Meta-Prompt)    |<--------|   (Meta-Skill)   |
+------------------+         +------------------+
         |                            |
         |   Improved tools audit     |
         |   and improve everything   |
         v                            v
+--------------------------------------------------+
|              AUDITOR AGENTS                       |
|  [Prompt] [Skill] [Expertise] [Output]           |
+--------------------------------------------------+
         |                            |
         |   All changes gated by     |
         v                            v
+--------------------------------------------------+
|              EVAL HARNESS (FROZEN)               |
|  Benchmarks | Regression Tests | Human Gates     |
+--------------------------------------------------+
```

**CRITICAL**: The eval harness does NOT self-improve. It is the anchor that prevents Goodhart's Law.

## When to Use

- Running a recursive improvement cycle
- Improving meta-tools (Prompt Forge, Skill Forge)
- Auditing and improving system-wide prompts/skills
- Measuring improvement over time

## MCP Requirements

### memory-mcp (Required)

**Purpose**: Store proposals, test results, version history, metrics

**Activation**:
```bash
claude mcp add memory-mcp npx @modelcontextprotocol/server-memory
```

---

## Core Operations

### Operation 1: Run Single Improvement Cycle

Execute one full cycle of recursive improvement.

```yaml
cycle:
  id: "cycle-{timestamp}"
  target: "prompt-forge|skill-forge|all"

  phases:
    1_analyze:
      action: "Prompt Forge analyzes target for weaknesses"
      output: "Analysis with improvement opportunities"

    2_propose:
      action: "Prompt Forge generates improvement proposals"
      output: "Concrete proposals with diffs"

    3_apply:
      action: "Skill Forge applies proposals (builds new version)"
      output: "New version of target"

    4_evaluate:
      action: "Eval Harness tests new version"
      output: "Benchmark + regression results"

    5_decide:
      action: "Compare results, decide ACCEPT or REJECT"
      output: "Decision with reasoning"

    6_commit_or_rollback:
      action: "If ACCEPT: commit + archive. If REJECT: rollback"
      output: "Final state + audit log"
```

### Operation 2: Improve Prompt Forge

Use Skill Forge to improve Prompt Forge.

```yaml
improve_prompt_forge:
  process:
    - step: "Analyze Prompt Forge with prompt-auditor"
      agent: "prompt-auditor"
      output: "Audit report with issues"

    - step: "Generate improvement proposals"
      agent: "prompt-forge" (self-analysis)
      output: "Proposals for self-improvement"

    - step: "Apply improvements with Skill Forge"
      agent: "skill-forge"
      output: "prompt-forge-v{N+1}"

    - step: "Test against eval harness"
      eval: "prompt-generation-benchmark-v1"
      regression: "prompt-forge-regression-v1"

    - step: "If improved: commit. If regressed: reject"

  safeguards:
    - "Previous version archived before changes"
    - "Requires eval harness pass"
    - "Rollback available for 30 days"
    - "Auditor agents must agree on improvement"

  forbidden_changes:
    - "Removing safeguards"
    - "Bypassing eval harness"
    - "Modifying frozen benchmarks"
```

### Operation 3: Improve Skill Forge

Use Prompt Forge to improve Skill Forge.

```yaml
improve_skill_forge:
  process:
    - step: "Analyze Skill Forge with skill-auditor"
      agent: "skill-auditor"
      output: "Audit report with issues"

    - step: "Generate improvement proposals with Prompt Forge"
      agent: "prompt-forge"
      output: "Proposals with rationale"

    - step: "Apply improvements (Skill Forge rebuilds

