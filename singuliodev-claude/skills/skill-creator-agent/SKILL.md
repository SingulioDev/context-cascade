

---
name: skill-creator-agent
version: 1.0.0
description: |
  Creates Claude Code skills where each skill is tied to a specialist agent optimized with evidence-based prompting techniques. Use this skill when users need to create reusable skills that leverage spe
category: foundry
tags:
- foundry
- creation
- meta-tools
author: ruv
---

<!-- SKILL SOP IMPROVEMENT v1.0 -->
## Skill Execution Criteria

### When to Use This Skill
- [AUTO-EXTRACTED from skill description and content]
- [Task patterns this skill is optimized for]
- [Workflow contexts where this skill excels]

### When NOT to Use This Skill
- [Situations where alternative skills are better suited]
- [Anti-patterns that indicate wrong skill choice]
- [Edge cases this skill doesn't handle well]

### Success Criteria
- primary_outcome: "[SKILL-SPECIFIC measurable result based on skill purpose]"
- quality_threshold: 0.85
- verification_method: "[How to validate skill executed correctly and produced expected outcome]"

### Edge Cases
- case: "Ambiguous or incomplete input"
  handling: "Request clarification, document assumptions, proceed with explicit constraints"
- case: "Conflicting requirements or constraints"
  handling: "Surface conflict to user, propose resolution options, document trade-offs"
- case: "Insufficient context for quality execution"
  handling: "Flag missing information, provide template for needed context, proceed with documented limitations"

### Skill Guardrails
NEVER:
  - "[SKILL-SPECIFIC anti-pattern that breaks methodology]"
  - "[Common mistake that degrades output quality]"
  - "[Shortcut that compromises skill effectiveness]"
ALWAYS:
  - "[SKILL-SPECIFIC requirement for successful execution]"
  - "[Critical step that must not be skipped]"
  - "[Quality check that ensures reliable output]"

### Evidence-Based Execution
self_consistency: "After completing this skill, verify output quality by [SKILL-SPECIFIC validation approach]"
program_of_thought: "Decompose this skill execution into: [SKILL-SPECIFIC sequential steps]"
plan_and_solve: "Plan: [SKILL-SPECIFIC planning phase] -> Execute: [SKILL-SPECIFIC execution phase] -> Verify: [SKILL-SPECIFIC verification phase]"
<!-- END SKILL SOP IMPROVEMENT -->

# Skill Creator with Agent Specialization

n## Trigger Keywords

**USE WHEN user mentions:**
- "create skill", "build skill", "new skill", "design skill"
- "skill that spawns agent", "agent-based skill"
- "reusable skill", "skill for [domain]", "professional skill"
- "skill with specialist agent", "complex skill"
- "skill for team", "skill library", "skill template"
- "skill using Claude Agent SDK"

**DO NOT USE when:**
- User wants just an AGENT (not skill wrapper) - use agent-creator
- User wants simple atomic skill without agent - use micro-skill-creator
- User wants to improve existing skill - use skill-forge
- User wants prompt optimization - use prompt-architect
- Task is one-off without reuse value - direct implementation better

**Instead use:**
- agent-creator when building agents directly (no skill layer needed)
- micro-skill-creator when creating simple, atomic skills
- skill-forge when improving existing skills
- cascade-orchestrator when composing existing skills into workflows

This skill extends the standard skill creation process by tying each skill to a specialist agent that is invoked when the skill is triggered. Rather than having Claude Code directly execute skill instructions, this approach spawns a specialized agent configured with optimal prompting patterns, domain expertise, and communication protocols. The result is more consistent, higher-quality outputs and better separation of concerns.

## When to Use This Skill

Use the skill-creator-agent skill when creating skills for complex domains where specialist expertise significantly improves outcomes, when building skills that require consistent behavior across many invocations, when creating skills for team use where quality consistency matters, or when the skill involves multi-step processes that benefit from structured cognitive frameworks. This skill is particularly valuable when building professional-grade tools rather than simple helper scripts.

