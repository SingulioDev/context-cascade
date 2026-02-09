

---
name: micro-skill-creator
version: 2.0.0
description: |
  Rapidly creates atomic, focused skills optimized with evidence-based prompting, specialist agents, and systematic testing. Each micro-skill does one thing exceptionally well using self-consistency, pr
category: foundry
tags:
- skill-creation
- atomic
- modular
- evidence-based
- specialist-agents
author: ruv
---

<!-- SKILL SOP IMPROVEMENT v1.0 -->
## Skill Execution Criteria

### When to Use This Skill
- Building atomic, reusable workflow components
- Creating focused skills that do one thing exceptionally well
- Establishing building blocks for cascade orchestration
- Developing domain-specific micro-capabilities
- When repeatability and composability are critical

### When NOT to Use This Skill
- For complex multi-step workflows (use cascade-orchestrator instead)
- For one-off exploratory tasks without reuse value
- When task is too simple to benefit from skill abstraction
- When external tools already handle the capability better

### Success Criteria
- primary_outcome: "Atomic skill with single responsibility, clean interface, specialist agent, and systematic validation"
- quality_threshold: 0.95
- verification_method: "Skill executes successfully in isolation, composes cleanly with other skills, passes functionality-audit validation"

### Edge Cases
- case: "Skill scope creep (trying to do too much)"
  handling: "Decompose into multiple micro-skills with clear interfaces, apply Unix philosophy"
- case: "Unclear input/output contract"
  handling: "Define explicit schema, add validation, document expected formats"
- case: "Skill depends on external state"
  handling: "Make dependencies explicit parameters, document preconditions, add state validation"

### Skill Guardrails
NEVER:
  - "Create skills with multiple responsibilities (violates atomic principle)"
  - "Use generic agents instead of domain specialists"
  - "Skip validation testing (functionality-audit required)"
  - "Create skills without clear composability in mind"
ALWAYS:
  - "Follow single responsibility principle (one skill, one purpose)"
  - "Design specialist agent with evidence-based prompting (self-consistency, program-of-thought, plan-and-solve)"
  - "Define clean input/output contracts with validation"
  - "Test in isolation AND in composition with other skills"
  - "Integrate with neural training for continuous improvement"

### Evidence-Based Execution
self_consistency: "After skill creation, execute multiple times with same input to verify deterministic behavior and consistent quality"
program_of_thought: "Decompose creation into: 1) Define single responsibility, 2) Design specialist agent, 3) Build input/output contract, 4) Implement core logic, 5) Validate systematically, 6) Test composability"
plan_and_solve: "Plan: Identify atomic operation + specialist expertise -> Execute: Build agent + validate -> Verify: Isolation test + composition test + neural training integration"
<!-- END SKILL SOP IMPROVEMENT -->

# Micro-Skill Creator (Enhanced)

## Trigger Keywords

**USE WHEN user mentions:**
- "create micro-skill", "atomic skill", "small skill", "focused skill"
- "single-purpose skill", "one task skill"
- "building block", "composable skill", "cascade component"
- "reusable [domain] skill", "skill for [specific task]"
- "Unix philosophy skill", "do one thing well"
- "skill using [evidence technique]" (self-consistency, program-of-thought, plan-and-solve)

**DO NOT USE when:**
- User wants COMPLEX multi-step skill - use skill-creator-agent
- User wants to create AGENT (not skill) - use agent-creator
- User wants to IMPROVE existing skill - use recursive-improvement or skill-forge
- User wants to optimize PROMPTS - use prompt-architect
- Task is one-off without reuse value - direct implementation faster
- Task already handled by external tools - integration better than recreation

**Instead use:**
- skill-creator-agent when skill needs multiple coordinated agents or complex workflow
- agent-creator when goal is standalone agent (no skill wrapper need

