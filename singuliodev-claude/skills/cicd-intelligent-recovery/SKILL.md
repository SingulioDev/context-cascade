

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for operations workflows
category: operations
tags:
- general
author: system
---

# CI/CD Quality & Debugging Loop (Loop 3)

**Purpose**: Continuous integration with automated failure recovery and authentic quality validation.

**SOP Workflow**: Specification → Research → Planning → Execution → Knowledge

**Output**: 100% test success rate with authentic quality improvements and failure pattern analysis

**Integration**: This is Loop 3 of 3. Receives from `parallel-swarm-implementation` (Loop 2), feeds failure data back to `research-driven-planning` (Loop 1).

**Version**: 2.0.0
**Optimization**: Evidence-based prompting with explicit agent SOPs

---

## When to Use This Skill

Activate this skill when:
- Have complete implementation from Loop 2 (parallel-swarm-implementation)
- Need CI/CD pipeline automation with intelligent recovery
- Require root cause analysis for test failures
- Want automated repair with connascence-aware fixes
- Need validation of authentic quality (no theater)
- Generating failure patterns for Loop 1 feedback

**DO NOT** use this skill for:
- Initial development (use Loop 2 first)
- Manual debugging without CI/CD integration
- Quality checks during development (use Loop 2 theater detection)

---

## Input/Output Contracts

### Input Requirements

```yaml
input:
  loop2_delivery_package:
    location: .claude/.artifacts/loop2-delivery-package.json
    schema:
      implementation: object (complete codebase)
      tests: object (test suite)
      theater_baseline: object (theater metrics from Loop 2)
      integration_points: array[string]
    validation:
      - Must exist and be valid JSON
      - Must include theater_baseline for differential analysis

  ci_cd_failures:
    source: GitHub Actions workflow runs
    format: JSON array of failure objects
    required_fields: [file, line, column, testName, errorMessage, runId]

  github_credentials:
    required: gh CLI authenticated
    check: gh auth status
```

### Output Guarantees

```yaml
output:
  test_success_rate: 100% (guaranteed)

  quality_validation:
    theater_audit: PASSED (no false improvements)
    sandbox_validation: 100% test pass
    differential_analysis: improvement metrics

  failure_patterns:
    location: .claude/.artifacts/loop3-failure-patterns.json
    feeds_to: Loop 1 (next iteration)
    schema:
      patterns: array[failure_pattern]
      recommendations: object (planning/architecture/testing)

  delivery_package:
    location: .claude/.artifacts/loop3-delivery-package.json
    contains:
      - quality metrics (test success, failures fixed)
      - analysis data (root causes, connascence context)
      - validation results (theater, sandbox, differential)
      - feedback for Loop 1
```

---

## Prerequisites

Before starting Loop 3, ensure Loop 2 completion:

```bash
# Verify Loop 2 delivery package exists
test -f .claude/.artifacts/loop2-delivery-package.json && echo "✅ Ready" || echo "❌ Run parallel-swarm-implementation first"

# Load implementation data
npx claude-flow@alpha memory query "loop2_complete" --namespace "integration/loop2-to-loop3"

# Verify GitHub CLI authenticated
gh auth status || gh auth login
```

---

## 8-Step CI/CD Process Overview

```
Step 1: GitHub Hook Integration (Download CI/CD failure reports)
        ↓
Step 2: AI-Powered Analysis (Gemini + 7-agent synthesis with Byzantine consensus)
        ↓
Step 3: Root Cause Detection (Graph analysis + Raft consensus)
        ↓
Step 4: Intelligent Fixes (Program-of-thought: Plan → Execute → Validate → Approve)
        ↓
Step 5: Theater Detection Audit (6-agent Byzantine consensus validation)
        ↓
Step 6: Sandbox Validation (Isolated production-like testing)
        ↓
Step 7: Differential Analysis (Compare to baseline with metrics)
        ↓
Step 8: GitHub Feedback (Automated reporting and loop closure)
```

---

## Step 1: GitHub Hook Integration

**Objective**: Download and process CI/CD pipeline failure reports from GitHub Actions.

**Agent Coordi

