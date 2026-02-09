

---
name: code-review-assistant
version: 1.1.0
description: |
  Comprehensive PR review using multi-agent swarm with specialized reviewers for security, performance, style, tests, and documentation. Provides detailed feedback with auto-fix suggestions and merge re
category: quality
tags:
- review
- pr
- github
- swarm
- essential
triggers:
  - "when reviewing code comprehensively"
  - "when reviewing code comprehensively"
author: ruv
---

## Kanitsal Kod Incelemesi (Evidential Code Review)

Her bulgu icin kaynak belirtilmeli:
- **DOGRUDAN**: Kod satirinda goruldu [file:line]
- **STIL_KURALI**: Style guide referansi [rule_id]
- **EN_IYI_PRATIK**: Best practice citation [reference]

Every review comment MUST cite:
1. **Code location**: [file:line] with surrounding context
2. **Evidence type**: DIRECT (seen in code), STYLE_RULE (documented standard), BEST_PRACTICE (industry reference)
3. **Reference source**: Style guide section, security advisory, performance benchmark

## Keigo Wakugumi (Hierarchical Organization)

Rejisutaa Shurui (Severity Levels):
- **SONKEIGO (CRITICAL)**: Architecture-level issues (security vulnerabilities, data loss risks)
- **TEINEIGO (MAJOR)**: Module-level issues (performance bottlenecks, maintainability problems)
- **CASUAL (MINOR)**: Function-level improvements (code style, readability)
- **NIT**: Line-level suggestions (formatting, naming)

Review findings are organized hierarchically:
1. System-level concerns (architecture, security, data integrity)
2. Component-level issues (modules, services, APIs)
3. Implementation details (functions, algorithms)
4. Surface-level polish (style, naming, comments)

## When to Use This Skill

Use this skill when:
- Code quality issues are detected (violations, smells, anti-patterns)
- Audit requirements mandate systematic review (compliance, release gates)
- Review needs arise (pre-merge, production hardening, refactoring preparation)
- Quality metrics indicate degradation (test coverage drop, complexity increase)
- Theater detection is needed (mock data, stubs, incomplete implementations)

## When NOT to Use This Skill

Do NOT use this skill for:
- Simple formatting fixes (use linter/prettier directly)
- Non-code files (documentation, configuration without logic)
- Trivial changes (typo fixes, comment updates)
- Generated code (build artifacts, vendor dependencies)
- Third-party libraries (focus on application code)

## Success Criteria
- This skill succeeds when:
- *Violations Detected**: All quality issues found with ZERO false negatives
- *False Positive Rate**: <5% (95%+ findings are genuine issues)
- *Actionable Feedback**: Every finding includes file path, line number, and fix guidance
- *Root Cause Identified**: Issues traced to underlying causes, not just symptoms
- *Fix Verification**: Proposed fixes validated against codebase constraints

## Edge Cases and Limitations

Handle these edge cases carefully:
- **Empty Files**: May trigger false positives - verify intent (stub vs intentional)
- **Generated Code**: Skip or flag as low priority (auto-generated files)
- **Third-Party Libraries**: Exclude from analysis (vendor/, node_modules/)
- **Domain-Specific Patterns**: What looks like violation may be intentional (DSLs)
- **Legacy Code**: Balance ideal standards with pragmatic technical debt management

## Quality Analysis Guardrails

CRITICAL RULES - ALWAYS FOLLOW:
- **NEVER approve code without evidence**: Require actual execution, not assumptions
- **ALWAYS provide line numbers**: Every finding MUST include file:line reference
- **VALIDATE findings against multiple perspectives**: Cross-check with complementary tools
- **DISTINGUISH symptoms from root causes**: Report underlying issues, not just manifestations
- **AVOID false confidence**: Flag uncertain findings as "needs manual review"
- **PRESERVE context**: Show surrounding code (5 lines before/after minimum)
- **TRACK false positives**: Learn from mistakes to improve detectio

