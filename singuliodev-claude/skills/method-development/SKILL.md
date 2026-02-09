

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for research workflows
category: research
tags:
- general
author: system
---

name: method-development
description: Develop novel machine learning methods with rigorous ablation studies
  for Deep Research SOP Pipeline D. Use after baseline replication passes Quality
  Gate 1, when creating new algorithms, proposing modifications to existing methods,
  or conducting systematic experimental validation. Includes architectural innovation,
  hyperparameter optimization, and component-wise ablation analysis leading to Quality
  Gate 2.
version: 1.0.0
category: research
tags:
- research
- analysis
- planning
author: ruv
---

# Method Development

Systematically develop and validate novel machine learning methods through controlled experimentation, ablation studies, and architectural innovation following Deep Research SOP Pipeline D.

## Overview

**Purpose**: Develop novel ML methods with rigorous experimental validation after baseline replication

**When to Use**:
- Quality Gate 1 (baseline replication) has APPROVED status
- Proposing architectural modifications to baseline methods
- Developing new training algorithms or optimization strategies
- Creating novel model components or attention mechanisms
- Systematic hyperparameter optimization required
- Ablation studies needed to validate design choices

**Quality Gate**: Leads to Quality Gate 2 (Model & Evaluation Validation)

**Prerequisites**:
- Baseline replication completed with ±1% tolerance (Quality Gate 1 passed)
- Baseline reproducibility package available
- Statistical analysis framework in place
- Docker environment configured
- GPU resources allocated (4-8 GPUs recommended)

**Outputs**:
- Novel method implementation with complete codebase
- Ablation study results (minimum 5 components tested)
- Performance comparison vs. baseline (statistical significance)
- Architectural diagrams and design documentation
- Hyperparameter sensitivity analysis
- Quality Gate 2 checklist (model validation requirements)

**Time Estimate**: 3-7 days (varies by complexity)
- Phase 1 (Architecture Design): 4-8 hours
- Phase 2 (Prototype Implementation): 1-2 days
- Phase 3 (Ablation Studies): 2-3 days
- Phase 4 (Optimization): 1-2 days
- Phase 5 (Comparative Evaluation): 4-8 hours
- Phase 6 (Documentation): 2-4 hours
- Phase 7 (Gate 2 Validation): 2-4 hours

**Agents Used**: system-architect, coder, tester, ethics-agent, reviewer, archivist, evaluator

---

## Quick Start

### 1. Prerequisites Check
```bash
# Verify baseline replication passed Gate 1
npx claude-flow@alpha memory retrieve --key "sop/gate-1/status"

# Load baseline reproducibility package
cd baseline-replication-package/
docker build -t baseline:latest .

# Verify baseline results
python scripts/verify_baseline_results.py --tolerance 0.01
```

### 2. Initialize Method Development
```bash
# Run architecture design workflow
npx claude-flow@alpha hooks pre-task \
  --description "Method development: Novel attention mechanism"

# Create method development workspace
mkdir -p novel-method/{src,experiments,ablations,docs}
cd novel-method/
```

### 3. Design Novel Architecture
```bash
# Invoke system-architect agent
# Document architectural decisions
# Create comparison diagrams (baseline vs. novel)
```

### 4. Run Ablation Studies
```bash
# Minimum 5 component ablations required
python scripts/run_ablations.py \
  --components "attention,normalization,residual,activation,pooling" \
  --baseline baseline:latest \
  --runs 3 \
  --seeds 42,123,456
```

### 5. Statistical Validation
```bash
# Compare novel method vs. baseline
python scripts/statistical_comparison.py \
  --method novel-method \
  --baseline baseline \
  --test paired-ttest \
  --significance 0.05
```

### 6. Quality Gate 2 Validation
```bash
# Validate Gate 2 requirements
npx claude-flow@alpha sparc run evaluator \
  "/validate-gate-2 --pipeline E --method novel-method"
```

---

## Detailed Instructions

### Phase 1: Architecture Design (4-8 hours)

**Agent**: system-

