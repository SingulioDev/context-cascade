

---
name: debugging
version: 1.0.0
description: |
  Systematic debugging methodology using a 5-phase protocol. Use when troubleshooting code failures, investigating bugs, or analyzing unexpected behavior. Applies 10 proven debugging techniques includin
category: delivery
tags:
- delivery
- development
- workflow
author: ruv
---

# Debugging - Systematic Code Investigation

## When to Use This Skill

- **Production Incidents**: Critical bugs affecting live users requiring rapid diagnosis
- **Intermittent Failures**: Flaky tests, race conditions, or timing-dependent bugs
- **Performance Issues**: Slow endpoints, memory leaks, or CPU spikes
- **Integration Failures**: Third-party API errors, database connectivity issues
- **Regression Analysis**: New bugs introduced by recent changes
- **Complex Stack Traces**: Multi-layered errors spanning multiple services

## When NOT to Use This Skill

- **Feature Development**: Building new functionality (use feature-dev-complete instead)
- **Code Reviews**: Reviewing code quality or architecture (use code-review-assistant)
- **Refactoring**: Restructuring code without fixing bugs (use refactoring skills)
- **Known Issues**: Bugs with clear root cause already identified

## Success Criteria

- [ ] Root cause identified with supporting evidence
- [ ] Fix implemented and tested
- [ ] Regression test added to prevent recurrence
- [ ] All related test suites passing
- [ ] Fix validated in production-like environment
- [ ] Documentation updated with troubleshooting notes
- [ ] Monitoring/alerting adjusted if needed

## Edge Cases to Handle

- **Heisenbugs**: Bugs that disappear when debugger attached
- **Multi-Service Failures**: Cascading errors across microservices
- **Data Corruption**: State inconsistencies requiring rollback
- **Timezone Issues**: Date/time bugs across regions
- **Concurrency Bugs**: Race conditions, deadlocks, or thread safety
- **Memory Corruption**: Pointer errors, buffer overflows in native code

## Guardrails

- **NEVER** deploy debug code or verbose logging to production
- **ALWAYS** reproduce bugs locally before proposing fixes
- **NEVER** fix symptoms without understanding root cause
- **ALWAYS** add regression tests for fixed bugs
- **NEVER** disable tests to make CI pass
- **ALWAYS** verify fixes do not introduce new bugs
- **NEVER** modify production data without backup

## Evidence-Based Validation

- [ ] Bug reproduced consistently with minimal test case
- [ ] Stack traces analyzed with error tracking tools (Sentry, Rollbar)
- [ ] Performance profiled with appropriate tools (Chrome DevTools, py-spy)
- [ ] Fix verified with automated tests
- [ ] Integration tests passing
- [ ] No new errors in application logs
- [ ] Memory/CPU usage within normal bounds

Systematic debugging through proven methodologies and comprehensive error analysis.

## When to Use This Skill

Use when code fails or produces unexpected results, investigating intermittent bugs, analyzing production errors, or debugging complex race conditions and edge cases.

## 5-Phase Debugging Protocol

### Phase 1: Reproduce Reliably
- Create minimal test case that triggers the bug
- Document exact sequence of inputs/conditions
- Verify bug occurs consistently
- Strip away unnecessary complexity

### Phase 2: Understand Root Cause
- Trace execution path leading to failure
- Examine variable values and state
- Identify incorrect assumptions
- Understand what code should do vs. what it does

### Phase 3: Design the Fix
- Determine changes needed to eliminate bug
- Consider impact on other functionality
- Check for similar bugs elsewhere
- Plan testing strategy

### Phase 4: Implement Using Best Practices
- Write clear, readable code
- Add comprehensive comments
- Handle edge cases properly
- Validate assumptions

### Phase 5: Verify the Fix
- Confirm bug no longer occurs
- Run regression tests
- Test edge cases
- Validate under original conditions

## 10 Debugging Methodologies

1. **Binary Search Debugging** - Divide and conquer to isolate bug location
2. **Rubber Duck Debugging** - Explain code to surface blind spots
3. **Hypothesis-Driven** - Form and test explicit hypotheses
4. **Differential Debugging** - Compare working vs. broken code
5. **Logg

