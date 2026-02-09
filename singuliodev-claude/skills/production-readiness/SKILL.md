

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

# Production Readiness

## Purpose

Comprehensive pre-deployment validation to ensure code is production-ready.

## Specialist Agent

I am a production readiness specialist ensuring deployment safety.

**Methodology** (Deployment Gate Pattern):
1. Complete quality audit (theater → functionality → style)
2. Security deep-dive (vulnerabilities, secrets, unsafe patterns)
3. Performance benchmarking (load testing, bottlenecks)
4. Documentation validation (README, API docs, deployment docs)
5. Dependency audit (outdated, vulnerable packages)
6. Configuration check (environment variables, secrets management)
7. Monitoring setup (logging, metrics, alerts)
8. Rollback plan verification
9. Generate deployment checklist
10. Final go/no-go decision

**Quality Gates** (all must pass):
- ✅ All tests passing (100%)
- ✅ Code quality ≥ 85/100
- ✅ Test coverage ≥ 80%
- ✅ Zero critical security issues
- ✅ Zero high-severity bugs
- ✅ Performance within SLAs
- ✅ Documentation complete
- ✅ Rollback plan documented

## Input Contract

```yaml
input:
  target_path: string (directory to validate, required)
  environment: enum[staging, production] (default: production)
  skip_performance: boolean (default: false)
  strict_mode: boolean (default: true)
```

## Output Contract

```yaml
output:
  ready_for_deployment: boolean
  quality_gates: object
    tests_passing: boolean
    code_quality: number
    test_coverage: number
    security_clean: boolean
    performance_ok: boolean
    docs_complete: boolean
  blocking_issues: array[issue]
  warnings: array[warning]
  deployment_checklist: array[task]
  rollback_plan: markdown
```

## Execution Flow

```bash
#!/bin/bash
set -e

TARGET_PATH="${1:-./}"
ENVIRONMENT="${2:-production}"
SKIP_PERFORMANCE="${3:-false}"

READINESS_DIR="production-readiness-$(date +%s)"
mkdir -p "$READINESS_DIR"

echo "================================================================"
echo "Production Readiness Check"
echo "Environment: $ENVIRONMENT"
echo "================================================================"

# Initialize quality gates
declare -A GATES
GATES[tests]=0
GATES[quality]=0
GATES[coverage]=0
GATES[security]=0
GATES[performance]=0
GATES[docs]=0

# GATE 1: Complete Quality Audit
echo "[1/10] Running complete quality audit..."
npx claude-flow audit-pipeline "$TARGET_PATH" \
  --phase all \
  --model codex-auto \
  --output "$READINESS_DIR/quality-audit.json"

# Check tests
TESTS_PASSED=$(cat "$READINESS_DIR/quality-audit.json" | jq '.functionality_audit.all_passed')
if [ "$TESTS_PASSED" = "true" ]; then
  GATES[tests]=1
  echo "✅ GATE 1: Tests passing"
else
  echo "❌ GATE 1: Tests failing"
fi

# Check code quality
QUALITY_SCORE=$(cat "$READINESS_DIR/quality-audit.json" | jq '.style_audit.quality_score')
if [ "$QUALITY_SCORE" -ge 85 ]; then
  GATES[quality]=1
  echo "✅ GATE 2: Code quality $QUALITY_SCORE/100"
else
  echo "❌ GATE 2: Code quality too low: $QUALITY_SCORE/100 (need ≥85)"
fi

# Check test coverage
TEST_COVERAGE=$(cat "$READINESS_DIR/quality-audit.json" | jq '.functionality_audit.coverage_percent')
if [ "$TEST_COVERAGE" -ge 80 ]; then
  GATES[coverage]=1
  echo "✅ GATE 3: Test coverage $TEST_COVERAGE%"
else
  echo "❌ GATE 3: Test coverage too low: $TEST_COVERAGE% (need ≥80%)"
fi

# GATE 2: Security Deep-Dive
echo "[2/10] Running security deep-dive..."
npx claude-flow security-scan "$TARGET_PATH" \
  --deep true \
  --check-secrets true \
  --check-dependencies true \
  --output "$READINESS_DIR/security-scan.json"

CRITICAL_SECURITY=$(cat "$READINESS_DIR/security-scan.json" | jq '.critical_issues')
HIGH_SECURITY=$(cat "$READINESS_DIR/security-scan.json" | jq '.high_issues')

if [ "$CRITICAL_SECURITY" -eq 0 ] && [ "$HIGH_SECURITY" -eq 0 ]; then
  GATES[security]=1
  echo "✅ GATE 4: Security scan clean"
else
  echo "❌ GATE 4: Security issues found (Critical: $CRITICAL_SECURITY, High: $HIGH_SECURITY)"
fi

# GATE 3: Performance

