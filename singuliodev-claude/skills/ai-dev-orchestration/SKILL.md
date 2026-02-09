

---
name: ai-dev-orchestration
version: 2.1.0
description: |
  Meta-orchestrator for AI-assisted app development with behavioral guardrails and prompt templates. 5-phase SOP - Product Framing (planner) -> Setup & Foundations (system-architect) -> Feature Developm
category: orchestration
tags:
- general
author: system
---

# AI-Assisted App Development Orchestration

## Phase 0: Expertise Loading

Before orchestrating AI development:

1. **Detect Domain**: Identify app type and tech stack
2. **Check Expertise**: Look for `.claude/expertise/ai-dev-${stack}.yaml`
3. **Load Context**: If exists, load guardrail patterns and successful prompts
4. **Apply Configuration**: Use expertise for development orchestration

**Purpose**: Ship reliable apps with AI coding tools while minimizing bugs, rework, and chaos

**Core Principle**: Treat AI as a junior dev with superpowers inside a structured pipeline. Real leverage comes from tight specs, clean context, and strong foundations.

**Timeline**: Varies by complexity (Product Framing 30-60min, Foundations 1-2hrs, Per-Feature 1-3hrs, Testing 30-90min, Deployment 15-30min)

**Integration**: Wraps feature-dev-complete, sparc-methodology, cicd-intelligent-recovery with AI-specific guardrails

---

## System Architecture

```
[User Product Idea]
    ↓
[Phase 0: Product Framing] (planner) - OPTIONAL
    ↓  (App One-Pager, Persona, Validation)
    ↓
[Phase 1: Setup & Foundations] (system-architect)
    ↓  (Stack selection, MVP definition, Foundation implementation)
    ↓
[Phase 2: Feature Development Loop] (coder + tester + reviewer) - ITERATIVE
    ↓  (Per-feature: Plan → Implement → Test → Accept/Rollback)
    ↓  (Fresh context per feature, Do Not Touch lists, Manual testing)
    ↓
[Phase 3: Testing & Refactors] (tester + coder)
    ↓  (Bug fixes, Refactoring with scope limits)
    ↓
[Phase 4: Deployment] (cicd-engineer)
    ↓  (Staging/Production, Monitoring, Health checks)
    ↓
[Memory-MCP Storage] (with WHO/WHEN/PROJECT/WHY tags)
```

---

## When to Use This Skill

Activate this skill when:
- Building apps with AI coding tools (Cursor, Claude Code, Lovable, Bolt)
- Need to prevent AI coding chaos and "theater implementations"
- Want systematic approach to AI-assisted development
- Building greenfield projects (web, mobile, internal tools)
- Small teams or solo builders using AI agents
- Need AI-safe guardrails (scope limiting, context management, testing gates)

**DO NOT** use this skill for:
- Traditional development without AI assistance (use feature-dev-complete)
- Quick scripts or throwaway code (too much process)
- Well-understood repetitive tasks (use existing patterns)
- Emergency hotfixes (skip structured workflow)

---

## Guiding Principles (from second-order insights)

1. **Spec > Code**: Quality depends more on *how well you specify* than how fast you type
2. **Foundations First**: Mini-waterfall for architecture, agile for features
3. **Ephemeral Context**: Fresh chat per feature; persistent knowledge in code/docs, not chat history
4. **Guardrails Over Brute Force**: Constrain what AI can touch; use "do not change X" aggressively
5. **Small, Tested Steps**: One feature at a time, each fully tested before moving on
6. **Human Product Judgment**: AI can simulate validation, but real users validate markets
7. **AI is Factory, You are Orchestrator**: Your job is design specs, run pipeline, decide pass/fail

---

## Input Contract

```yaml
input:
  product:
    name: string (required)
    description: string (required)  # 1-2 sentence "who + what outcome"
    target_user: string (optional)  # Narrow customer segment
    differentiators: array[string] (optional)  # How you differ from competitors

  requirements:
    must_have_features: array[string] (1-2 core features for MVP)
    nice_to_have: array[string]
    constraints:
      technical: array[string]  # Required stack, frameworks
      timeline: string
      budget: string

  options:
    run_product_framing: boolean (default: true)  # Skip if already validated
    auto_test: boolean (default: true)  # Run tests after each feature
    manual_review: boolean (default: true)  # Human approval gates
    deployment_target: enum[staging, production] (default: staging)
`

