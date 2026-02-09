

---
name: reproducibility-audit
version: 1.0.0
description: |
  Comprehensive audit of ML reproducibility packages ensuring ACM Artifact Evaluation compliance with statistical validation for Deep Research SOP Pipeline G. Use before Quality Gate 3 validation when r
category: quality
tags:
- quality
- testing
- validation
author: ruv
---

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
- **TRACK false positives**: Learn from mistakes to improve detection accuracy

## Evidence-Based Validation

Use multiple validation perspectives:
1. **Static Analysis**: Code structure, patterns, metrics (connascence, complexity)
2. **Dynamic Analysis**: Execution behavior, test results, runtime characteristics
3. **Historical Analysis**: Git history, past bug patterns, change frequency
4. **Peer Review**: Cross-validation with other quality skills (functionality-audit, theater-detection)
5. **Domain Expertise**: Leverage .claude/expertise/{domain}.yaml if available

**Validation Threshold**: Findings require 2+ confirming signals before flagging as violations.

## Integration with Quality Pipeline

This skill integrates with:
- **Pre-Phase**: Load domain expertise (.claude/expertise/{domain}.yaml)
- **Parallel Skills**: functionality-audit, theater-detection-audit, style-audit
- **Post-Phase**: Store findings in Memory MCP with WHO/WHEN/PROJECT/WHY tags
- **Feedback Loop**: Learnings feed dogfooding-system for continuous improvement

# Reproducibility Audit

Audit ML reproducibility packages for compliance with ACM Artifact Evaluation standards, ensuring research can be reprod

