

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for research workflows
category: research
tags:
- general
author: system
---

name: research-driven-planning
description: Loop 1 of the Three-Loop Integrated Development System. Research-driven
  requirements analysis with iterative risk mitigation through 5x pre-mortem cycles
  using multi-agent consensus. Feeds validated, risk-mitigated plans to parallel-swarm-implementation.
  Use when starting new features or projects requiring comprehensive planning with
  <3% failure confidence and evidence-based technology selection.
version: 1.0.0
category: research
tags:
- research
- analysis
- planning
author: ruv
---

# Research-Driven Planning (Loop 1)

## Purpose

Comprehensive planning with research-backed solutions and iterative risk mitigation that prevents 85-95% of problems before coding begins.

## Specialist Agent Coordination

I coordinate multi-agent research and planning swarms using **explicit agent SOPs** from Claude-Flow's 86-agent ecosystem.

**Methodology** (SOP: Specification → Research → Planning → Execution → Knowledge):
1. **Specification Phase**: Requirements capture with structured SPEC.md
2. **Research Phase**: 6-agent parallel research with self-consistency validation
3. **Planning Phase**: MECE task decomposition with research integration
4. **Execution Phase**: 8-agent Byzantine consensus pre-mortem (5 iterations)
5. **Knowledge Phase**: Planning package generation for Loop 2 integration

**Integration**: Loop 1 of 3. Feeds → `parallel-swarm-implementation` (Loop 2), Receives ← `cicd-intelligent-recovery` (Loop 3) failure patterns.

---

## When to Use This Skill

Activate this skill when:
- Starting a new feature or project requiring comprehensive planning
- Need to prevent problems before coding begins (85-95% failure prevention)
- Want research-backed solutions instead of assumptions (30-60% time savings)
- Require risk analysis with <3% failure confidence
- Building something complex with multiple failure modes
- Need evidence-based planning that feeds into implementation

**DO NOT** use this skill for:
- Quick fixes or trivial changes (use direct implementation)
- Well-understood repetitive tasks (use existing patterns)
- Emergency hotfixes (skip to Loop 2)

---

## Input Contract

```yaml
input:
  project_description: string (required)
    # High-level description of what needs to be built

  requirements:
    functional: array[string] (required)
      # Core features and capabilities
    non_functional: object (optional)
      performance: string
      security: string
      scalability: string

  constraints:
    technical: array[string] (stack, framework, dependencies)
    timeline: string (deadlines, milestones)
    resources: object (team, budget, infrastructure)

  options:
    research_depth: enum[quick, standard, comprehensive] (default: standard)
    premortem_iterations: number (default: 5, range: 3-10)
    failure_threshold: number (default: 3, target: <3%)
```

## Output Contract

```yaml
output:
  specification:
    spec_file: path  # SPEC.md location
    requirements_complete: boolean
    success_criteria: array[string]

  research:
    evidence_sources: number  # Total research sources
    recommendations: array[object]
      solution: string
      confidence: number (0-100)
      evidence: array[url]
    risk_landscape: array[object]
      risk: string
      severity: enum[low, medium, high, critical]
      mitigation: string

  planning:
    enhanced_plan: path  # plan-enhanced.json location
    total_tasks: number
    task_dependencies: object
    estimated_complexity: string

  risk_analysis:
    premortem_iterations: number
    final_failure_confidence: number  # Target: <3%
    critical_risks_mitigated: number
    defense_strategies: array[string]

  integration:
    planning_package: path  # loop1-planning-package.json
    memory_namespace: string  # integration/loop1-to-loop2
    ready_for_loop2: boolean
```

---

## SOP Phase 1: Specification

**Objective**: Define initial

