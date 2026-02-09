

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for foundry workflows
category: foundry
tags:
- general
author: system
---

# Recursive Improvement - Meta-Loop Skill

---
name: recursive-improvement
description: Self-improving meta-loop that audits and enhances skills, prompts, and expertise files
category: foundry
version: 2.0.0
triggers:
  - "improve skill"
  - "audit skill"
  - "run improvement cycle"
  - "meta-loop"
  - "self-improve"
mcp_servers:
  required: [memory-mcp]
  optional: [connascence-analyzer]
---

## Trigger Keywords

**USE WHEN user mentions:**
- "improve skill", "audit skill", "enhance skill", "optimize skill"
- "run improvement cycle", "meta-loop", "self-improve"
- "skill quality check", "documentation audit"
- "recursive improvement", "systematic improvement"
- "batch improve skills", "improve all skills"
- "skill missing [section]", "incomplete documentation"

**DO NOT USE when:**
- User wants to CREATE a new skill - use skill-creator-agent or micro-skill-creator
- User wants to CREATE an agent - use agent-creator
- User wants to improve a PROMPT (not skill) - use prompt-architect
- User wants one-off manual fix - direct editing faster
- Eval-harness benchmarks failing - fix root cause first, not improve on broken baseline
- During active feature development - finish feature, then improve

**Instead use:**
- skill-creator-agent when creating new skills from scratch
- agent-creator when creating new agents
- prompt-architect when optimizing prompts
- skill-forge when applying specific improvements (recursive-improvement coordinates it)

## Overview

The Recursive Improvement skill orchestrates the meta-loop that enables the system to improve itself. It coordinates four specialized auditors (skill-auditor, prompt-auditor, expertise-auditor, output-auditor) to detect issues, generate improvement proposals, apply changes via skill-forge, and validate results through the frozen eval-harness.

**Key Constraint**: The eval-harness is FROZEN - it never self-improves. This prevents Goodhart's Law (optimizing the metric instead of the goal).

## When to Use

**Use When**:
- Skill documentation is incomplete (missing Core Principles, Anti-Patterns, Conclusion)
- Prompt quality has degraded (inconsistent outputs, missing constraints)
- Expertise files are outdated (file locations changed, patterns stale)
- Output quality has dropped (theater code, unvalidated claims)

**Do Not Use**:
- For one-off fixes (use direct editing)
- When eval-harness benchmarks are failing (fix root cause first)
- During active feature development (finish feature first)

## Core Principles

Recursive Improvement operates on 3 fundamental principles:

### Principle 1: Frozen Eval Harness Prevents Goodhart's Law
The evaluation harness that gates all improvements is NEVER self-improved. This ensures the system optimizes for genuine quality, not for passing corrupted benchmarks.

In practice:
- Eval-harness benchmarks are defined externally and versioned separately
- Changes to eval-harness require human approval and audit trail
- All improvement proposals are tested against frozen benchmarks before commit

### Principle 2: Propose-Test-Compare-Commit Pipeline
Every improvement follows a rigorous pipeline: propose changes, test against benchmarks, compare to baseline, commit only if better. No direct edits bypass this pipeline.

In practice:
- Auditors generate structured proposals with predicted improvement deltas
- skill-forge applies proposals in sandbox before production
- A/B comparison ensures new version outperforms baseline
- Rollback available for 30 days if regressions discovered later

### Principle 3: Documentation Completeness Is Non-Negotiable
Skills are not production-ready until they pass documentation audit (100% Tier 1, 100% Tier 2). Missing sections are auto-generated using templates from SKILL-AUDIT-PROTOCOL.md.

In practice:
- Every skill audit checks for Core Principles, Anti-Patterns, Conclusion
- Missing sections trigger auto-generation using domain-specific t

