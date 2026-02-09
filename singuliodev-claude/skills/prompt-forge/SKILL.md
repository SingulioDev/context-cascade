

---
name: prompt-forge
version: 2.0.1
description: |
  Meta-prompt that generates improved prompts and templates. Can improve other prompts including Skill Forge and even itself. All improvements are gated by frozen eval harness. Use when optimizing promp
category: foundry
tags:
- meta-prompt
- self-improvement
- recursive
- dogfooding
- cognitive-frames
author: system
---

# Prompt Forge (Meta-Prompt)

## Purpose

Generate improved prompts and templates with:
- Explicit rationale for each change
- Predicted improvement metrics
- Risk assessment
- Actionable diffs

**Key Innovation**: Can improve Skill Forge prompts, then Skill Forge can improve Prompt Forge prompts - creating a recursive improvement loop.

## When to Use

- Optimizing existing prompts for better performance
- Creating prompt diffs with clear rationale
- Running the recursive improvement loop
- Auditing prompts for common issues

## MCP Requirements

### memory-mcp (Required)

**Purpose**: Store proposals, test results, version history

**Activation**:
```bash
claude mcp add memory-mcp npx @modelcontextprotocol/server-memory
```

---

## Core Operations

### Operation 1: Analyze Prompt

Before improving, deeply understand the target prompt.

```yaml
analysis:
  target: "{prompt_path}"

  structural_analysis:
    sections: [list of sections]
    flow: "How sections connect"
    dependencies: "What inputs/outputs exist"

  quality_assessment:
    clarity:
      score: 0.0-1.0
      issues: ["Ambiguous instruction in section X"]
    completeness:
      score: 0.0-1.0
      issues: ["Missing failure handling for case Y"]
    precision:
      score: 0.0-1.0
      issues: ["Vague success criteria in section Z"]

  pattern_detection:
    evidence_based_techniques:
      self_consistency: present|missing|partial
      program_of_thought: present|missing|partial
      plan_and_solve: present|missing|partial
    failure_handling:
      explicit_errors: present|missing|partial
      edge_cases: present|missing|partial
      uncertainty: present|missing|partial

  improvement_opportunities:
    - area: "Section X"
      issue: "Lacks explicit timeout handling"
      priority: high|medium|low
      predicted_impact: "+X% reliability"
```

### Operation 2: Generate Improvement Proposal

Create concrete, testable improvement proposals.

```yaml
proposal:
  id: "prop-{timestamp}"
  target: "{prompt_path}"
  type: "prompt_improvement"

  summary: "One-line description of improvement"

  changes:
    - section: "Section name"
      location: "Line X-Y"
      before: |
        Original text...
      after: |
        Improved text...
      rationale: "Why this change improves the prompt"
      technique: "Which evidence-based technique applied"

  predicted_improvement:
    primary_metric: "success_rate"
    expected_delta: "+5%"
    confidence: 0.8
    reasoning: "Based on similar improvements in prompt X"

  risk_assessment:
    regression_risk: low|medium|high
    affected_components:
      - "Component 1"
      - "Component 2"
    rollback_complexity: simple|moderate|complex

  test_plan:
    - test: "Run on benchmark task A"
      expected: "Improvement in clarity score"
    - test: "Check for regressions in task B"
      expected: "No degradation"
```

### Operation 3: Apply Evidence-Based Techniques

Systematically apply research-validated prompting patterns.

#### Self-Consistency Enhancement

```markdown
BEFORE:
"Analyze the code and report issues"

AFTER:
"Analyze the code from three perspectives:
1. Security perspective: What vulnerabilities exist?
2. Performance perspective: What bottlenecks exist?
3. Maintainability perspective: What code smells exist?

Cross-reference findings. Flag any inconsistencies between perspectives.
Provide confidence scores for each finding.
Return only findings that appear in 2+ perspectives OR have >80% confidence."
```

#### Program-of-Thought Enhancement

```markdown
BEFORE:
"Calculate the optimal configuration"

AFTER:
"Calculate the optimal configuration step by step:

Step 1: Identify all configuration parameters
  - List each parameter
  - Document valid ranges
  - Note dependencies between parameters

Step 2: Define optimization criteria
  - Primary metric: [what to maximize/minimize]
  - Constraints: [hard limits]
  - T

