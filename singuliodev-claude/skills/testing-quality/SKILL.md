

---
name: testing-quality
version: 2.1.0
description: |
  Testing quality assessment for test suite health, coverage analysis, and test effectiveness. Use when auditing test quality, improving test coverage, or assessing test reliability and maintainability.
category: research
tags:
- general
author: system
---

# Testing Quality

Assessment and improvement of test suite quality, coverage, and effectiveness.

## Phase 0: Expertise Loading

```yaml
expertise_check:
  domain: testing-quality
  file: .claude/expertise/testing-quality.yaml

  if_exists:
    - Load quality metrics
    - Load coverage thresholds
    - Apply assessment criteria

  if_not_exists:
    - Flag discovery mode
    - Document patterns learned
```

## When to Use This Skill

Use testing-quality when:
- Auditing test suite health
- Analyzing test coverage gaps
- Assessing test reliability
- Improving test maintainability
- Identifying flaky tests

## Quality Dimensions

| Dimension | Metrics |
|-----------|---------|
| Coverage | Line, branch, function |
| Reliability | Flake rate, consistency |
| Speed | Execution time, parallelization |
| Maintainability | Complexity, duplication |

## Quality Metrics

### Coverage Analysis
```yaml
metrics:
  line_coverage: ">= 80%"
  branch_coverage: ">= 75%"
  function_coverage: ">= 80%"
  critical_path_coverage: "100%"
```

### Test Health
```yaml
metrics:
  flaky_test_rate: "< 1%"
  test_execution_time: "< 5 min"
  test_to_code_ratio: ">= 1:1"
  assertion_density: ">= 2 per test"
```

## Anti-Patterns

```yaml
anti_patterns:
  - Flaky tests (non-deterministic)
  - Test interdependence
  - Over-mocking
  - Missing assertions
  - Slow tests in CI
  - Commented-out tests
```

## MCP Requirements

- **claude-flow**: For orchestration
- **Bash**: For coverage tools

## Recursive Improvement Integration (v2.1)

### Eval Harness Integration

```yaml
benchmark: testing-quality-benchmark-v1
  tests:
    - tq-001: Coverage analysis accuracy
    - tq-002: Anti-pattern detection
  minimum_scores:
    analysis_accuracy: 0.90
    detection_rate: 0.85
```

### Memory Namespace

```yaml
namespaces:
  - testing-quality/audits/{id}: Quality audits
  - testing-quality/metrics: Health metrics
  - improvement/audits/testing-quality: Skill audits
```

### Uncertainty Handling

```yaml
confidence_check:
  if confidence >= 0.8:
    - Proceed with assessment
  if confidence 0.5-0.8:
    - Confirm scope
  if confidence < 0.5:
    - Ask for test suite details
```

### Cross-Skill Coordination

Works with: **testing**, **code-review-assistant**, **functionality-audit**

---

## !! SKILL COMPLETION VERIFICATION (MANDATORY) !!

- [ ] **Agent Spawning**: Spawned agent via Task()
- [ ] **Agent Registry Validation**: Agent from registry
- [ ] **TodoWrite Called**: Called with 5+ todos
- [ ] **Work Delegation**: Delegated to agents

**Remember: Skill() -> Task() -> TodoWrite() - ALWAYS**

## Core Principles

Testing Quality operates on 3 fundamental principles:

### Principle 1: Comprehensive Coverage Across Multiple Dimensions
Test quality is not just about line coverage percentage but about effectiveness across coverage, reliability, speed, and maintainability dimensions.

In practice:
- Line coverage measures which code is executed, but branch coverage ensures all decision paths are tested
- Function coverage validates all callable units are invoked, while critical path coverage ensures 100% validation of essential workflows
- Coverage metrics combined with assertion density ensure tests actually validate behavior, not just execute code
- Test-to-code ratio (>= 1:1) ensures adequate test investment relative to implementation complexity

### Principle 2: Test Reliability Through Determinism
Flaky tests that pass or fail non-deterministically erode confidence in the entire test suite and mask real failures.

In practice:
- Flaky test rate must be <1% with any non-deterministic tests immediately investigated and fixed
- Test isolation prevents interdependence where one test's side effects affect another's results
- Reproducible test environments (seeded random data, controlled timing) eliminate environmental variability
- Test execution monitoring tracks consistency over multiple

