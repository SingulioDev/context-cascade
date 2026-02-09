

---
name: eval-harness
version: 1.1.0
description: |
  Frozen evaluation harness that gates all self-improvement changes. Contains benchmark suites, regression tests, and human approval gates. Evaluates cognitive frame application and cross-lingual integr
category: foundry
tags:
- evaluation
- benchmark
- regression
- frozen
- gate
author: system
---

# Eval Harness (Frozen Evaluation)

## Purpose

Gate ALL self-improvement changes with objective evaluation.

**CRITICAL**: This harness does NOT self-improve. It is manually maintained and expanded. This prevents Goodhart's Law (optimizing the metric instead of the outcome).

## Core Principle

> "A self-improvement loop is only as good as its evaluation harness."

Without frozen evaluation:
- Prettier prompts that are more confidently wrong
- Overfitting to "sounds good" instead of "works better"
- Compounding misalignment

---

## Benchmark Suites

### Suite 1: Prompt Generation Quality

**ID**: `prompt-generation-benchmark-v1`
**Purpose**: Evaluate quality of generated prompts

```yaml
benchmark:
  id: prompt-generation-benchmark-v1
  version: 1.0.0
  last_modified: "2025-12-15"
  frozen: true

  tasks:
    - id: "pg-001"
      name: "Simple Task Prompt"
      input: "Create a prompt for file reading"
      expected_qualities:
        - has_clear_action_verb
        - has_input_specification
        - has_output_specification
        - has_error_handling
      scoring:
        clarity: 0.0-1.0
        completeness: 0.0-1.0
        precision: 0.0-1.0

    - id: "pg-002"
      name: "Complex Workflow Prompt"
      input: "Create a prompt for multi-step deployment"
      expected_qualities:
        - has_plan_and_solve_structure
        - has_validation_gates
        - has_rollback_instructions
        - has_success_criteria
      scoring:
        clarity: 0.0-1.0
        completeness: 0.0-1.0
        precision: 0.0-1.0

    - id: "pg-003"
      name: "Analytical Task Prompt"
      input: "Create a prompt for code review"
      expected_qualities:
        - has_self_consistency_mechanism
        - has_multiple_perspectives
        - has_confidence_scoring
        - has_uncertainty_handling
      scoring:
        clarity: 0.0-1.0
        completeness: 0.0-1.0
        precision: 0.0-1.0

  minimum_passing:
    average_clarity: 0.7
    average_completeness: 0.7
    average_precision: 0.7
    required_qualities_hit_rate: 0.8
```

### Suite 2: Skill Generation Quality

**ID**: `skill-generation-benchmark-v1`
**Purpose**: Evaluate quality of generated skills

```yaml
benchmark:
  id: skill-generation-benchmark-v1
  version: 1.0.0
  frozen: true

  tasks:
    - id: "sg-001"
      name: "Micro-Skill Generation"
      input: "Create skill for JSON validation"
      expected_qualities:
        - has_single_responsibility
        - has_input_output_contract
        - has_error_handling
        - has_test_cases
      scoring:
        functionality: 0.0-1.0
        contract_compliance: 0.0-1.0
        error_coverage: 0.0-1.0

    - id: "sg-002"
      name: "Complex Skill Generation"
      input: "Create skill for API integration"
      expected_qualities:
        - has_phase_structure
        - has_validation_gates
        - has_logging
        - has_rollback
      scoring:
        functionality: 0.0-1.0
        structure_compliance: 0.0-1.0
        safety_coverage: 0.0-1.0

  minimum_passing:
    average_functionality: 0.75
    average_compliance: 0.8
    required_qualities_hit_rate: 0.85
```

### Suite 3: Expertise File Quality

**ID**: `expertise-generation-benchmark-v1`
**Purpose**: Evaluate quality of expertise files

```yaml
benchmark:
  id: expertise-generation-benchmark-v1
  version: 1.0.0
  frozen: true

  tasks:
    - id: "eg-001"
      name: "Domain Expertise Generation"
      input: "Create expertise for authentication domain"
      expected_qualities:
        - has_file_locations
        - has_falsifiable_patterns
        - has_validation_rules
        - has_known_issues_section
      scoring:
        falsifiability_coverage: 0.0-1.0
        pattern_precision: 0.0-1.0
        validation_completeness: 0.0-1.0

  minimum_passing:
    falsifiability_coverage: 0.8
    pattern_precision: 0.7
    validation_completeness: 0.75
```

### Suite 4: Cogniti

