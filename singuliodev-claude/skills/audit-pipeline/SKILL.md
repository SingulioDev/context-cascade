

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for quality workflows
category: quality
tags:
- general
author: system
---

# Audit Pipeline - Complete Code Quality Workflow

## Cognitive Frame Activation

### Kanitsal Kalite Hatti (Evidential Quality Pipeline)

Her bulgu icin metrik kaniti gereklidir:
- **Finding**: [description of quality issue]
- **Evidence**: [metric: value at location]
- **Standard**: [threshold from reference]
- **Impact**: [quantified effect on quality score]
- **Confidence**: [0.0-1.0]

Every quality finding MUST include:
1. **Metric evidence**: Concrete measurement (complexity=13, coverage=60%, lines=72)
2. **Location evidence**: Exact file path and line number [file:line]
3. **Standard reference**: Documented threshold (NASA limit, WCAG level, OWASP category)
4. **Impact quantification**: Quality score delta, risk level, maintainability cost

### Al-Tahlil al-Sarfi lil-Jawda (Morphological Quality Analysis)

Root Cause Decomposition - Every quality issue has layers:

```
DIMENSION: [Maintainability | Performance | Security | Reliability]
  SURFACE: [visible symptom in code]
    - Location: [file:line]
    - Metric: [measurement]
  ROOT: [underlying cause]
    - Pattern: [anti-pattern name]
    - Origin: [design decision, knowledge gap, time pressure]
  DERIVED: [contributing factors]
    - Technical debt
    - Missing tests
    - Unclear requirements
  REMEDIATION: [target the root cause]
    - Fix: [address root, not symptom]
    - Prevent: [process change to avoid recurrence]
```

**Example Decomposition**:
```
DIMENSION: Maintainability
  SURFACE: God Object with 26 methods
    - Location: src/UserService.js:1-450
    - Metric: methods=26 (threshold=15), lines=450 (threshold=250)
  ROOT: Single Responsibility Principle violation
    - Pattern: God Object anti-pattern
    - Origin: Feature additions without refactoring
  DERIVED:
    - Missing abstraction for authentication logic
    - Missing abstraction for data validation
    - Missing abstraction for error handling
  REMEDIATION:
    - Fix: Extract AuthService, ValidationService, ErrorHandler
    - Prevent: Code review gate at 15 methods, refactoring sprint every 3 months
```

## Purpose
Execute a comprehensive 3-phase code quality audit that systematically transforms code from prototype to production-ready by eliminating theater, verifying functionality through sandbox testing with Codex iteration, and polishing style to meet professional standards.

## The 3-Phase Pipeline

This orchestrator runs three audit skills in the optimal sequence:

### Phase 1: Theater Detection Audit
**Finds**: Mock data, hardcoded responses, TODO markers, stub functions, placeholder code
**Goal**: Identify all "fake" implementations that need to be completed
**Skill**: `theater-detection-audit`

### Phase 2: Functionality Audit (with Codex Sandbox)
**Validates**: Code actually works through execution testing
**Method**: Sandbox testing + Codex iteration loop for fixes
**Skill**: `functionality-audit` + `codex-auto`
**Goal**: Verify and fix functionality using Codex's Full Auto mode for iterative debugging

### Phase 3: Style & Quality Audit
**Polishes**: Code organization, naming, documentation, best practices
**Goal**: Production-grade code quality and maintainability
**Skill**: `style-audit`

## Why This Order Matters

**1. Theater First** - No point testing or polishing fake code
- Identifies what's real vs. placeholder
- Provides roadmap for completion
- Ensures subsequent phases test actual functionality

**2. Functionality Second** - Must work before polishing
- Validates real implementations
- Uses Codex sandbox for safe iterative testing
- Fixes bugs before style improvements
- Ensures refactoring won't break working code

**3. Style Last** - Polish after functionality is verified
- Refactors with confidence (tests prove it works)
- Improves maintainability of working code
- Final production-ready state

## Usage

### Complete Pipeline (All 3 Phases)
```bash
/audit-pipeline
```

### With Specific T

