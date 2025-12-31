# Cognitive Architecture: VeriLingua x VERIX x GlobalMOO

**Version**: 3.1.1 | **Last Updated**: 2024-12-30

This document describes the cognitive architecture powering Context Cascade - a system designed to improve AI reasoning precision, evidence tracking, and self-optimization.

---

## Table of Contents

1. [Overview](#overview)
2. [VeriLingua: Cognitive Frame System](#verilingua-cognitive-frame-system)
3. [VERIX: Epistemic Notation](#verix-epistemic-notation)
4. [Three-Loop Architecture](#three-loop-architecture)
5. [GlobalMOO Integration](#globalmoo-integration)
6. [Meta-Loop Recursive Improvement](#meta-loop-recursive-improvement)
7. [Named Modes (Pareto-Optimal Configurations)](#named-modes)

---

## Overview

The Context Cascade cognitive architecture combines three systems:

| System | Purpose | Inspiration |
|--------|---------|-------------|
| **VeriLingua** | Force explicit cognitive distinctions | 7 natural languages with mandatory grammatical markers |
| **VERIX** | Track epistemic status of claims | Speech act theory + Bayesian confidence |
| **GlobalMOO** | Optimize cognitive configurations | Multi-objective Pareto optimization |

**Core Insight**: Many languages grammatically require speakers to make distinctions that English leaves optional. By activating these frames, we force more precise, self-aware AI responses.

---

## VeriLingua: Cognitive Frame System

VeriLingua draws from 7 natural languages that require cognitive distinctions:

### 1. Evidential Frame (Turkish -mis/-di)

Turkish grammar requires marking whether you witnessed something directly or learned it secondhand.

| Marker | Meaning | Example |
|--------|---------|---------|
| `[witnessed]` | Direct observation | `[witnessed] The function returns null - I traced the code` |
| `[reported:source]` | Secondhand information | `[reported:docs] The API rate limit is 100/min` |
| `[inferred]` | Logical deduction | `[inferred] The cache is stale because TTL expired` |
| `[assumed:conf]` | Explicit assumption | `[assumed:0.7] The server uses REST conventions` |

### 2. Aspectual Frame (Russian Perfective/Imperfective)

Russian verbs require indicating whether an action is complete or ongoing.

| Marker | Meaning | Example |
|--------|---------|---------|
| `[complete]` | Action finished | `[complete] Migration executed successfully` |
| `[ongoing]` | In progress | `[ongoing] Test suite running - 45/100 done` |
| `[habitual]` | Repeating | `[habitual] Cron job runs every hour` |
| `[attempted]` | Tried, pending | `[attempted] Connection initiated, awaiting response` |

### 3. Morphological Frame (Arabic Trilateral Roots)

Arabic derives words from 3-consonant roots, revealing semantic relationships.

| Pattern | Purpose | Example |
|---------|---------|---------|
| `[root:X]` | Identify core concept | `[root:auth]` = authentication/authorize/authority |
| `[primitive:X]` | Basic building block | `[primitive:user]` = base user concept |
| `[composed:A+B=C]` | Show composition | `[composed:auth+role=rbac]` |

### 4. Compositional Frame (German Compounding)

German creates compound words by combining primitives (Schadenfreude = harm + joy).

| Pattern | Purpose |
|---------|---------|
| `[builds:A->B->C]` | Show construction hierarchy |
| `[decomposes:C->B,A]` | Break down complex concepts |

### 5. Honorific Frame (Japanese Keigo)

Japanese has distinct registers based on social context and audience.

| Marker | Audience | Use Case |
|--------|----------|----------|
| `[audience:developer]` | Technical peers | Code discussions |
| `[audience:executive]` | Decision makers | Status reports |
| `[audience:user]` | End users | Documentation |
| `[register:formal/casual]` | Formality level | Match context |

### 6. Classifier Frame (Chinese Measure Words)

Chinese uses classifiers to categorize nouns by type/shape.

| Marker | Purpose | Example |
|--------|---------|---------|
| `[type:entity]` | Categorize item | `[type:service]`, `[type:function]` |
| `[count:N of TYPE]` | Quantify with type | `[count:3 endpoints]` |

### 7. Spatial Frame (Guugu Yimithirr Absolute Direction)

Guugu Yimithirr uses absolute directions instead of relative (north vs left).

| Marker | Purpose | Example |
|--------|---------|---------|
| `[position:X in Y]` | Absolute location | `[position:line 42 in auth.py]` |
| `[direction:toward X]` | Movement/flow | `[direction:toward database]` |

---

## VERIX: Epistemic Notation

VERIX (VERIfied eXpression) makes claim properties explicit.

### Grammar

```
STATEMENT := [illocution|affect] content [ground:source] [conf:X.XX] [state:status]
```

### Components

**Illocution** (What you're doing with the utterance):
- `assert` - Making a factual claim
- `query` - Asking a question
- `direct` - Giving an instruction
- `commit` - Making a promise
- `express` - Expressing attitude

**Affect** (Emotional stance):
- `neutral` - No emotional loading
- `positive` - Favorable/recommended
- `negative` - Unfavorable/warning
- `uncertain` - Epistemic uncertainty

**Ground** (Evidence source):
- `[ground:witnessed]` - Personal observation
- `[ground:documentation]` - Official docs
- `[ground:user_input]` - From user
- `[ground:inference]` - Logical deduction
- `[ground:system_policy]` - Non-negotiable rule

**Confidence** (Bayesian probability):
- Range: 0.00 to 1.00
- Ceilings by evidence type:
  - Definition: 0.95 max
  - Observation: 0.95 max
  - Inference: 0.70 max
  - Report: 0.70 max

**State** (Claim lifecycle):
- `provisional` - May revise
- `confirmed` - Verified true
- `retracted` - Withdrawn

### Example

```
[assert|positive] Use async/await for I/O operations [ground:performance_testing] [conf:0.92] [state:confirmed]
```

---

## Three-Loop Architecture

Context Cascade operates on three concurrent improvement loops:

### Loop 1: Execution Loop (Per-Request)
- **Trigger**: Every user request
- **Duration**: Seconds to minutes
- **Function**: 5-phase workflow execution
  1. Intent Analysis
  2. Prompt Optimization
  3. Strategic Planning
  4. Playbook Routing
  5. Parallel Execution

### Loop 2: Quality Loop (Per-Session)
- **Trigger**: After significant work completed
- **Duration**: Minutes to hours
- **Function**: Theater detection, functionality audit
- **Tools**: Byzantine consensus, multi-agent review

### Loop 3: Meta-Loop (Every 3 Days)
- **Trigger**: Scheduled or on-demand
- **Duration**: Hours
- **Function**: Self-optimization of cognitive architecture
- **Tools**: GlobalMOO, connascence analysis, telemetry synthesis

---

## GlobalMOO Integration

GlobalMOO provides cloud-based multi-objective optimization.

### Integration Pattern

```
GlobalMOO (5D exploration) -> PyMOO NSGA-II (14D refinement)
```

### Optimization Dimensions

**Objectives** (what we optimize):
1. Accuracy - Correctness of outputs
2. Efficiency - Token/time usage
3. Reliability - Consistency across runs
4. User Satisfaction - Task completion rate

**Decision Variables** (what we tune):
1. Evidential weight (0-1)
2. Aspectual weight (0-1)
3. Morphological weight (0-1)
4. Compositional weight (0-1)
5. Honorific weight (0-1)
6. Classifier weight (0-1)
7. Spatial weight (0-1)
8. VERIX verbosity (0-1)
9. Confidence threshold (0.5-0.95)
10. Byzantine consensus threshold (0.5-0.9)
... and more

### Subscription Limits

Current GlobalMOO plan limits to 5 dimensions, so we:
1. Use GlobalMOO for coarse 5D exploration
2. Use local PyMOO NSGA-II for fine 14D refinement
3. Distill results into named modes

---

## Meta-Loop Recursive Improvement

The meta-loop is a 3-day cycle for self-optimization:

### Day 1: Collect
- Aggregate telemetry from memory-mcp
- Run connascence analysis on codebase
- Identify high-severity violations

### Day 2: Optimize
- Run GlobalMOO with current telemetry
- Explore Pareto frontier for new configurations
- Run local PyMOO refinement

### Day 3: Apply
- Distill results into named modes
- Update skill/agent/command configurations
- Validate changes don't break existing functionality

### Connascence-Guided Refactoring

The meta-loop uses connascence analysis to identify code quality issues:

| Connascence Type | Severity | Fix Pattern |
|------------------|----------|-------------|
| CoP (Parameter Bomb) | High | Dataclass extraction |
| CoI (God Object) | High | Mixin extraction |
| CoE (Deep Nesting) | High | Handler extraction |
| CoN (Name coupling) | Medium | Rename consistency |
| CoT (Type coupling) | Medium | Interface extraction |

---

## Named Modes

Named modes are Pareto-optimal configurations discovered through GlobalMOO:

| Mode | Accuracy | Efficiency | Primary Frames | Use Case |
|------|----------|------------|----------------|----------|
| **audit** | 0.960 | 0.763 | evidential, aspectual, morphological | Code review, security analysis |
| **speed** | 0.734 | 0.950 | minimal frames | Quick tasks, simple queries |
| **research** | 0.980 | 0.824 | evidential, honorific, classifier | Deep research, literature review |
| **robust** | 0.960 | 0.769 | evidential, aspectual, morphological | Production code, critical systems |
| **balanced** | 0.882 | 0.928 | evidential, spatial | General-purpose, default mode |

### Mode Selection

Modes are automatically selected based on:
1. Task complexity
2. Domain requirements
3. User preferences
4. Resource constraints

---

## Immutable Safety Bounds

Regardless of optimization, these bounds cannot be changed:

```
EVD >= 1  (evidential frame always active)
ASP >= 1  (aspectual frame always active)
```

This ensures all claims have evidence markers and completion status.

---

## References

- `/cognitive-architecture/docs/VERILINGUA-GUIDE.md` - Full VeriLingua specification
- `/cognitive-architecture/docs/VERIX-GUIDE.md` - Complete VERIX notation guide
- `/cognitive-architecture/docs/GLOBALMOO-GUIDE.md` - API integration details
- `/cognitive-architecture/docs/META-LOOP-BOOTSTRAP-RESULTS.md` - Optimization history

---

## VCL v3.1.1 Compliance

This document and system are VCL (VeriLingua Cognitive Language) v3.1.1 compliant:

- 7-slot cognitive forcing: HON -> MOR -> COM -> CLS -> EVD -> ASP -> SPC
- VERIX epistemic markers on all claims
- Confidence ceilings by evidence type
- L2 (pure English) for user-facing output, L1 for internal documentation
