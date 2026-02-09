

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

# Deployment Readiness

Validate ML models and systems for production deployment, ensuring operational readiness across performance, monitoring, security, and incident management dimensions.

---

## Aspektual'naya Ramka (Deployment State Tracking)

### Tipy Sostoyaniya (State Types)

**Perfective [SV] - Completed Actions**:
- `[SV:ZAVERSHENO]` - Stage fully completed
- `[SV:PROVERENO]` - Validated and verified
- `[SV:ODOBRENO]` - Approved for next stage
- `[SV:RAZVERNUTO]` - Deployed successfully

**Imperfective [NSV] - Ongoing/Incomplete Actions**:
- `[NSV:V_PROTSESSE]` - Stage actively in progress
- `[NSV:VYPOLNYAETSYA]` - Currently executing
- `[NSV:TESTIRUYETSYA]` - Testing in progress
- `[NSV:MONITORITSYA]` - Under monitoring

**Blocked/Special States**:
- `[ZABLOKIROVANO]` - Blocked by dependency
- `[OZHIDAET]` - Waiting for prerequisite
- `[OTKAT]` - Rollback initiated
- `[AVARIYA]` - Emergency state

### Deployment Pipeline States

```
Infrastructure Setup:
  Capacity Planning      [SV|NSV|ZABLOKIROVANO]
  Environment Setup      [SV|NSV|ZABLOKIROVANO]
  Network Configuration  [SV|NSV|ZABLOKIROVANO]
  → Output: [SV:ZAVERSHENO] or [NSV:V_PROTSESSE]

Performance Benchmarking:
  Latency Testing        [SV|NSV|ZABLOKIROVANO]
  Throughput Testing     [SV|NSV|ZABLOKIROVANO]
  Resource Utilization   [SV|NSV|ZABLOKIROVANO]
  → Output: [SV:PROVERENO] or [NSV:TESTIRUYETSYA]

Monitoring Setup:
  Metrics Collection     [SV|NSV|ZABLOKIROVANO]
  Alerting Configuration [SV|NSV|ZABLOKIROVANO]
  Dashboard Creation     [SV|NSV|ZABLOKIROVANO]
  → Output: [SV:ODOBRENO] or [NSV:V_PROTSESSE]

Deployment Execution:
  Staging Deployment     [SV|NSV|ZABLOKIROVANO|OTKAT]
  Production Deployment  [SV|NSV|ZABLOKIROVANO|OTKAT|AVARIYA]
  Post-Deploy Validation [SV|NSV|ZABLOKIROVANO]
  → Output: [SV:RAZVERNUTO] or [OTKAT] or [AVARIYA]
```

### State Transition Rules

1. **Sequential Progression**: `[NSV] → [SV] → Next Stage [NSV]`
2. **Rollback Path**: `[AVARIYA] → [OTKAT] → Previous [SV]`
3. **Blocking Cascade**: Parent `[ZABLOKIROVANO]` → Children `[OZHIDAET]`
4. **Monitoring Loop**: `[SV:RAZVERNUTO] → [NSV:MONITORITSYA]` (continuous)

### Example State Tracking Output

```markdown
## Deployment Status Report - 2025-12-19 14:32:00

### Infrastructure Validation [SV:ZAVERSHENO]
- Capacity Planning: [SV:ZAVERSHENO] at 2025-12-19 10:15
- Environment Setup: [SV:ZAVERSHENO] at 2025-12-19 12:45
- Network Configuration: [SV:PROVERENO] at 2025-12-19 13:20

### Performance Benchmarking [NSV:TESTIRUYETSYA]
- Latency Testing: [SV:PROVERENO] at 2025-12-19 14:00
- Throughput Testing: [NSV:VYPOLNYAETSYA] started 2025-12-19 14:15
- Resource Utilization: [OZHIDAET] (blocked by throughput test)

### Monitoring Setup [OZHIDAET]
- Blocked by: Performance Benchmarking [NSV:TESTIRUYETSYA]

### Deployment Execution [OZHIDAET]
- Blocked by: All prerequisites must be [SV:ZAVERSHENO]
```

---

## Liangci Kuangjia (Deployment Classification Framework)

### Deployment Type Classifiers

**FEATURE (xin gong-neng)** - New Functionality
- Risk: MEDIUM-HIGH
- Testing: Comprehensive E2E required
- Rollback: Feature flag toggle
- Monitoring: New metrics for feature usage
- Example: "New payment gateway integration"

**HOTFIX (jin-ji xiu-fu)** - Critical Bug Fix
- Risk: HIGH (expedited process)
- Testing: Focused regression on affected area
- Rollback: Immediate revert capability required
- Monitoring: Error rate alerts with 1-min interval
- Example: "Fix authentication bypass vulnerability"

**ROLLBACK (hui-gun)** - Revert to Previous Version
- Risk: LOW-MEDIUM (known good state)
- Testing: Smoke tests only
- Rollback: N/A (is rollback)
- Monitoring: Verify previous metrics restored
- Example: "Revert failed v2.3.0 deployment"

**CONFIG (pei-zhi)** - Configuration-Only Change
- Risk: LOW
- Testing: Config validation, no code changes
- Rollback: Config file revert
- Monitoring: Service health checks
-

