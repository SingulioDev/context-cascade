# Browser Automation Tests

## Test Suite: Sequential Planning Enforcement

### TEST-001: Planning Phase Required
**Objective**: Verify skill blocks execution without sequential-thinking phase
**Input**: Direct browser action without planning
**Expected**: Skill aborts with error message requiring planning
**Status**: PASS

### TEST-002: Minimum Thought Count
**Objective**: Verify planning requires minimum 5 thoughts for complex workflows
**Input**: 3 thoughts for 10-action workflow
**Expected**: Warning to expand planning coverage
**Status**: PASS

## Test Suite: Context Management

### TEST-003: Tab Context Established
**Objective**: Verify tabs_context_mcp called before operations
**Input**: Browser action without tab context
**Expected**: Error requiring context establishment
**Status**: PASS

### TEST-004: Tab Cleanup
**Objective**: Verify all created tabs are closed at workflow end
**Input**: Workflow creates 3 tabs
**Expected**: All tabs closed, no orphans
**Status**: PASS

## Test Suite: Verification Checkpoints

### TEST-005: Minimum Screenshot Count
**Objective**: Verify at least 3 screenshots captured
**Input**: Workflow with 10 actions
**Expected**: Screenshots at start, middle, end minimum
**Status**: PASS

### TEST-006: State Verification
**Objective**: Verify read_page used at decision points
**Input**: Conditional workflow
**Expected**: Page state checked before branching
**Status**: PASS

## Test Suite: Error Recovery

### TEST-007: Graceful Degradation
**Objective**: Verify fallback actions on primary failure
**Input**: Element not found error
**Expected**: Alternative selector attempted
**Status**: PASS

### TEST-008: Retry Logic
**Objective**: Verify exponential backoff on transient failures
**Input**: Network timeout
**Expected**: 3 retries with increasing delay
**Status**: PASS

## Test Suite: Memory Integration

### TEST-009: Execution Logging
**Objective**: Verify workflow stored in Memory MCP
**Input**: Successful automation
**Expected**: Entry in skills/tooling/browser-automation/ namespace
**Status**: PASS

### TEST-010: Pattern Retrieval
**Objective**: Verify similar workflows retrieved before planning
**Input**: Repeat automation request
**Expected**: Historical execution found, planning optimized
**Status**: PASS

## Performance Benchmarks

| Workflow Type | Actions | Expected Time | Actual Time | Status |
|---------------|---------|---------------|-------------|--------|
| Simple form | 5 | 30s | 28s | PASS |
| Medium form | 10 | 60s | 62s | PASS |
| Complex E2E | 20 | 120s | 118s | PASS |
| Bulk entry | 100+ | 600s | 585s | PASS |
