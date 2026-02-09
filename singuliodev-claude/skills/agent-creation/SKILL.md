

---
name: agent-creation
version: 1.0.0
description: |
  Systematic agent creation using evidence-based prompting principles and 4-phase SOP methodology. Use when creating new specialist agents, refining existing agent prompts, or designing multi-agent syst
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
- Creating new specialist agents with domain-specific expertise
- Refining existing agent system prompts for better performance
- Designing multi-agent coordination systems
- Implementing role-based agent hierarchies
- Building production-ready agents with embedded domain knowledge

### When NOT to Use This Skill
- For simple one-off tasks that don't need agent specialization
- When existing agents already cover the required domain
- For casual conversational interactions without systematic requirements
- When the task is better suited for a slash command or micro-skill

### Success Criteria
- primary_outcome: "Production-ready agent with optimized system prompt, clear role definition, and validated performance"
- quality_threshold: 0.9
- verification_method: "Agent successfully completes domain-specific tasks with consistent high-quality output, passes validation tests, and integrates with Claude Agent SDK"

### Edge Cases
- case: "Vague agent requirements"
  handling: "Use Phase 1 (Initial Analysis) to research domain, identify patterns, and clarify scope before proceeding"
- case: "Overlapping agent capabilities"
  handling: "Conduct agent registry search, identify gaps vs duplicates, propose consolidation or specialization"
- case: "Agent needs multiple conflicting personas"
  handling: "Decompose into multiple focused agents with clear coordination pattern"

### Skill Guardrails
NEVER:
  - "Create agents without deep domain research (skipping Phase 1 undermines quality)"
  - "Use generic prompts without evidence-based techniques (CoT, few-shot, role-based)"
  - "Skip validation testing (Phase 3) before considering agent production-ready"
  - "Create agents that duplicate existing registry agents without justification"
ALWAYS:
  - "Complete all 4 phases: Analysis -> Prompt Engineering -> Testing -> Integration"
  - "Apply evidence-based prompting: Chain-of-Thought for reasoning, few-shot for patterns, clear role definition"
  - "Validate with diverse test cases and measure against quality criteria"
  - "Document agent capabilities, limitations, and integration points"

### Evidence-Based Execution
self_consistency: "After agent creation, test with same task multiple times to verify consistent outputs and reasoning quality"
program_of_thought: "Decompose agent creation into: 1) Domain analysis, 2) Capability mapping, 3) Prompt architecture, 4) Test design, 5) Validation, 6) Integration"
plan_and_solve: "Plan: Research domain + identify capabilities -> Execute: Build prompts + test cases -> Verify: Multi-run consistency + edge case handling"
<!-- END SKILL SOP IMPROVEMENT -->

# Agent Creation - Systematic Agent Design

Evidence-based agent creation following best practices for prompt engineering and agent specialization.

---

## When to Use This Skill

Use when creating new specialist agents for specific domains, refining existing agent capabilities, designing multi-agent coordination systems, or implementing role-based agent hierarchies.

---

## 4-Phase Agent Creation SOP

### Phase 1: Specification
- Define agent purpose and domain
- Identify core capabilities needed
- Determine input/output formats
- Specify quality criteria

**Tools**: Use `resources/scripts/generate_agent.sh` for automated generation

### Phase 2: Prompt Engineering
- Apply evidence-based prompting principles
- Use Chain-of-Thought for reasoning tasks
- Implement few-shot learning with examples (2-5 examples)
- Define role and persona clearly

**Reference**: See `references/prompting-principles.md` for detailed techniques

### Phase 3: Testing & Vali

