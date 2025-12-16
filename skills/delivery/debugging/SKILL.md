---
name: debugging
description: Systematic debugging methodology using a 5-phase protocol. Use when troubleshooting
  code failures, investigating bugs, or analyzing unexpected behavior. Applies 10
  proven debugging techniques including binary search, rubber duck, hypothesis-driven,
  and differential debugging.
version: 1.0.0
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
5. **Logging and Instrumentation** - Add extensive debug output
6. **Breakpoint Analysis** - Step through code with debugger
7. **Stack Trace Analysis** - Work backwards from failure point
8. **State Inspection** - Examine program state at key points
9. **Input Validation** - Test with boundary and edge case inputs
10. **Isolation Testing** - Test components independently

## Integration with Tools

- **Python**: pdb, pytest, coverage.py
- **JavaScript**: Chrome DevTools, debugger statements
- **Go**: delve debugger, race detector
- **General**: GDB, Valgrind, memory sanitizers

## Automation Scripts

This skill includes production-ready automation scripts in `resources/scripts/`:

1. **binary-search-debug.js** - Automated binary search debugging
   - Bisect through git commits to find bug introduction point
   - Bisect through code lines to isolate problematic code
   - Generate comprehensive debug reports with statistics
   - Usage: `node binary-search-debug.js --mode commits --start <hash> --end <hash> --test "npm test"`

2. **log-analyzer.py** - Intelligent log file analysis
   - Parse multiple log formats (Apache, nginx, syslog, JSON, custom)
   - Detect error patterns and temporal distributions
   - Identify anomalies (error bursts, repeating errors)
   - Generate JSON reports with actionable insights
   - Usage: `python log-analyzer.py --file app.log --format custom --output report.json`

3. **stack-trace-analyzer.py** - Stack trace intelligence
   - Multi-language support (Python, JavaScript, Java, Ruby)
   - Automatic root cause categorization
   - Pattern detection across multiple traces
   - Smart recommendations based on error types
   - Usage: `python stack-trace-analyzer.py --input error.log` or `cat trace.txt | python stack-trace-analyzer.py --stdin`

4. **debug-session-recorder.sh** - Debug session management
   - Record complete debugging sessions with metadata
   - Capture system snapshots at key points
   - Log commands and test results automatically
   - Generate comprehensive markdown reports
   - Usage: `./debug-session-recorder.sh start --issue BUG-123` then `./debug-session-recorder.sh stop`

## Templates

Production-ready templates in `resources/templates/`:

1. **debug-config.template.json** - VS Code/IDE debug configurations
   - Python (current file, pytest, remote)
   - Node.js (current file, Jest, attach, Docker)
   - Go (debug, test)
   - Browser (Chrome DevTools)
   - Multi-language compound configurations

2. **logging-config.template.py** - Comprehensive logging setup
   - JSON structured logging
   - Multiple handlers (console, rotating file)
   - Performance tracking context manager
   - Function call decorator
   - Error context capture

3. **debug-checklist.template.md** - Systematic debugging checklist
   - 10-phase debugging workflow
   - Problem definition and reproduction
   - Hypothesis formation and testing
   - Root cause analysis
   - Solution design and implementation
   - Prevention and lessons learned

## Test Suite

Comprehensive tests in `tests/` directory:

1. **test-binary-search-debug.js** - 15+ test cases for binary search debugger
2. **test-log-analyzer.py** - 12+ test cases for log analysis
3. **test-stack-trace-analyzer.py** - 18+ test cases for stack trace analysis

Run tests:
```bash
# JavaScript tests
cd tests && npm test

# Python tests
python tests/test-log-analyzer.py
python tests/test-stack-trace-analyzer.py
```

## Quick Start Examples

### Binary Search Debugging
```bash
# Find commit that introduced bug
node resources/scripts/binary-search-debug.js \
  --mode commits \
  --start HEAD~10 \
  --end HEAD \
  --test "npm test"

# Find exact line causing issue
node resources/scripts/binary-search-debug.js \
  --mode code \
  --file src/buggy.js \
  --test "node test-script.js"
```

### Log Analysis
```bash
# Analyze application logs
python resources/scripts/log-analyzer.py \
  --file /var/log/app.log \
  --format custom \
  --output analysis-report.json

# Analyze JSON logs
python resources/scripts/log-analyzer.py \
  --file logs/production.json \
  --format json
```

### Stack Trace Analysis
```bash
# From file
python resources/scripts/stack-trace-analyzer.py --input crash.log

# From clipboard
python resources/scripts/stack-trace-analyzer.py --clipboard

# From stdin (pipe)
cat error.txt | python resources/scripts/stack-trace-analyzer.py --stdin
```

### Debug Session Recording
```bash
# Start session
./resources/scripts/debug-session-recorder.sh start --issue PROJ-456

# Log commands during debugging
./resources/scripts/debug-session-recorder.sh log-command "pytest -vv tests/test_auth.py"

# Capture snapshot
./resources/scripts/debug-session-recorder.sh snapshot

# Stop and generate report
./resources/scripts/debug-session-recorder.sh stop
./resources/scripts/debug-session-recorder.sh report PROJ-456-20240115-103045
```
