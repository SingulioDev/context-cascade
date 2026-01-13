---
name: e2e-test
version: 1.0.0
description: End-to-end testing workflow for validating complete user journeys through web applications using claude-in-chrome MCP. Specializes in test assertions, suite organization, evidence collection, and pass/fail reporting.
category: tooling
tags:
- testing
- e2e
- automation
- browser
- quality
- mcp
author: ruv
cognitive_frame:
  primary: evidential
  secondary: aspectual
  rationale: "E2E testing requires rigorous evidence collection (evidential) and tracking test completion states (aspectual)"
---

# End-to-End Testing

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.

[assert|neutral] Systematic end-to-end testing workflow with assertion framework, evidence collection, and structured reporting [ground:skill-design] [conf:0.95] [state:confirmed]

## Overview

End-to-end testing validates complete user journeys through web applications, ensuring that integrated systems work correctly from the user's perspective. This skill builds upon browser-automation but adds formal testing constructs: assertions, test suites, fixtures, and detailed pass/fail reporting.

**Philosophy**: E2E tests are living documentation of expected user behavior. They must be deterministic, maintainable, and produce actionable failure reports.

**Key Differences from browser-automation**:
| Aspect | browser-automation | e2e-test |
|--------|-------------------|----------|
| **Primary Goal** | Complete workflow tasks | Validate expected behavior |
| **Output** | Task completion | Pass/Fail test report |
| **Error Handling** | Recover and continue | Fail fast with evidence |
| **Evidence** | Optional screenshots | Mandatory assertions + screenshots |
| **Organization** | Single workflow | Test suites with fixtures |
| **Cleanup** | Best effort | Mandatory teardown |

**Value Proposition**: Transform manual QA checklists into automated, repeatable test suites that catch regressions before users do.

## When to Use This Skill

**Primary Use Cases**:
- Login/authentication flow validation
- User registration and onboarding verification
- Checkout and payment flow testing
- Form submission with validation rules
- CRUD operations (Create, Read, Update, Delete)
- Multi-step wizard completion
- Cross-page state persistence
- Visual regression detection

**Apply When**:
- Validating critical user journeys before deployment
- Regression testing after code changes
- Smoke testing production environments
- Acceptance criteria verification
- Visual snapshot comparison needed

**Trigger Keywords**:
- "e2e test", "end-to-end test"
- "validate user flow", "test the journey"
- "check if login works", "verify checkout"
- "regression test", "smoke test"
- "acceptance test"

## When NOT to Use This Skill

- Unit testing (use testing frameworks directly)
- API testing without UI (use API testing tools)
- Performance/load testing (use `delivery-essential-commands-load-test`)
- Single-action validation (use browser-automation)
- Non-web applications (mobile, desktop)
- Static content verification (use visual tools)

## Core Principles

### Principle 1: Assertion-First Design

**Mandate**: Every test step MUST have explicit success/failure criteria defined upfront.

**Rationale**: Tests without assertions are just scripts. Explicit assertions make failures debuggable and intentions clear.

**In Practice**:
- Define expected outcomes before execution
- Use multiple assertion types (DOM, visual, URL, text)
- Fail immediately on assertion failure
- Capture evidence at assertion points

### Principle 2: Test Suite Organization

**Mandate**: Group related tests into suites with shared setup/teardown.

**Rationale**: Test organization reduces duplication, improves maintainability, and enables selective test runs.

**In Practice**:
- Suite = collection of related test cases
- Fixtures = reusable setup/teardown logic
- Each test case is independent (no cross-test dependencies)
- Clear naming: `suite_feature_scenario`

### Principle 3: Evidence-Based Verdicts

**Mandate**: Every test result MUST include visual evidence (screenshots) at assertion points.

**Rationale**: Screenshots provide ground truth for debugging failures and serve as visual documentation.

**In Practice**:
- Screenshot before and after critical actions
- Capture DOM state at assertion points
- Store evidence with test results
- Enable visual comparison for regression detection

### Principle 4: Deterministic Execution

**Mandate**: Tests must produce identical results on identical inputs.

**Rationale**: Flaky tests erode confidence. Determinism enables reliable CI/CD integration.

**In Practice**:
- Explicit waits over implicit timeouts
- Stable element selection (data-testid preferred)
- Isolated test data (fixtures create/destroy)
- Retry logic only for infrastructure issues

### Principle 5: Actionable Failure Reports

**Mandate**: Failed tests MUST produce reports that pinpoint the failure without additional investigation.

**Rationale**: Time-to-fix correlates with failure report quality. Good reports = faster debugging.

**In Practice**:
- Include: step that failed, expected vs actual, screenshot
- Show assertion context (what was being verified)
- Provide DOM snapshot at failure point
- Link to relevant code/documentation

---

## Test Framework Concepts

### Test Suite Structure

```yaml
test_suite:
  name: "Login Flow Tests"
  description: "Validate user authentication scenarios"

  fixtures:
    setup:
      - action: "create_test_user"
        params: { username: "testuser", password: "Test123!" }
      - action: "clear_cookies"
    teardown:
      - action: "delete_test_user"
        params: { username: "testuser" }

  test_cases:
    - name: "successful_login"
      steps: [...]
      assertions: [...]

    - name: "invalid_password"
      steps: [...]
      assertions: [...]

    - name: "empty_fields"
      steps: [...]
      assertions: [...]
```

### Assertion Types

| Type | Syntax | Use Case |
|------|--------|----------|
| **element_exists** | `assert_exists(selector)` | Verify element present in DOM |
| **element_visible** | `assert_visible(selector)` | Verify element is visible |
| **text_equals** | `assert_text(selector, expected)` | Exact text match |
| **text_contains** | `assert_contains(selector, substring)` | Partial text match |
| **url_equals** | `assert_url(expected_url)` | Exact URL match |
| **url_contains** | `assert_url_contains(substring)` | URL contains path |
| **attribute_equals** | `assert_attr(selector, attr, value)` | HTML attribute check |
| **element_count** | `assert_count(selector, count)` | Number of matching elements |
| **visual_match** | `assert_visual(baseline_image)` | Screenshot comparison |
| **form_value** | `assert_value(selector, expected)` | Form input value |

### Assertion Implementation

```javascript
const ASSERTIONS = {
  element_exists: async (context, selector) => {
    const elements = await mcp__claude-in-chrome__find({
      query: selector,
      tabId: context.tabId
    });
    return {
      passed: elements.length > 0,
      actual: `Found ${elements.length} elements`,
      expected: `At least 1 element matching "${selector}"`
    };
  },

  text_equals: async (context, selector, expected) => {
    const page = await mcp__claude-in-chrome__read_page({
      tabId: context.tabId
    });
    const element = findElementBySelector(page, selector);
    const actual = element?.text || "";
    return {
      passed: actual === expected,
      actual: actual,
      expected: expected
    };
  },

  url_equals: async (context, expected) => {
    const page = await mcp__claude-in-chrome__read_page({
      tabId: context.tabId
    });
    const actual = page.url;
    return {
      passed: actual === expected,
      actual: actual,
      expected: expected
    };
  },

  visual_match: async (context, baselineId) => {
    const screenshot = await mcp__claude-in-chrome__computer({
      action: "screenshot",
      tabId: context.tabId
    });
    const similarity = await compareImages(screenshot, baselineId);
    return {
      passed: similarity >= 0.95,
      actual: `${(similarity * 100).toFixed(1)}% match`,
      expected: "95% or higher match",
      evidence: screenshot.imageId
    };
  }
};
```

### Test Result Structure

```yaml
test_result:
  suite: "Login Flow Tests"
  test_case: "successful_login"
  status: "PASSED" | "FAILED" | "SKIPPED" | "ERROR"

  duration_ms: 2340
  timestamp: "2026-01-12T14:30:00Z"

  steps_executed: 5
  steps_passed: 5
  steps_failed: 0

  assertions:
    - name: "login_form_visible"
      type: "element_visible"
      status: "PASSED"
      expected: "Login form visible"
      actual: "Login form visible"
      screenshot_id: "img_001"

    - name: "redirect_to_dashboard"
      type: "url_contains"
      status: "PASSED"
      expected: "URL contains /dashboard"
      actual: "https://app.example.com/dashboard"
      screenshot_id: "img_002"

  evidence:
    screenshots: ["img_001", "img_002", "img_003"]
    dom_snapshots: ["dom_001", "dom_002"]
    console_logs: ["log_001"]

  failure_details: null  # Populated on failure
```

### Failure Report Structure

```yaml
failure_report:
  test_case: "checkout_with_discount"
  failed_at_step: 4

  failure:
    assertion: "discount_applied"
    type: "text_equals"
    expected: "$90.00"
    actual: "$100.00"
    message: "Discount code not applied to total"

  context:
    url: "https://shop.example.com/checkout"
    step_description: "Verify 10% discount applied after code entry"
    preceding_action: "Clicked 'Apply Discount' button"

  evidence:
    screenshot: "img_failure_001"
    dom_snapshot: "dom_failure_001"
    console_errors: []

  debug_hints:
    - "Check if discount code 'SAVE10' is still valid"
    - "Verify discount applies to current cart items"
    - "Check for JavaScript errors in console"
```

---

## Main Workflow

### Phase 1: Test Planning (via Sequential-Thinking)

**Purpose**: Decompose user journey into testable steps with explicit assertions.

**Process**:
1. Invoke sequential-thinking MCP
2. Break down user journey into atomic steps
3. Define assertion for each step
4. Identify fixture requirements (setup/teardown)
5. Plan evidence collection points
6. Define success/failure thresholds

**Input Contract**:
```yaml
inputs:
  test_description: string    # What user journey to test
  success_criteria: string    # What defines passing
  test_data: object          # Fixture data (users, products, etc.)
```

**Output Contract**:
```yaml
outputs:
  test_plan:
    suite_name: string
    fixtures: { setup: [...], teardown: [...] }
    test_cases:
      - name: string
        steps: [{ action, params, assertion }]
        timeout_ms: number
```

### Phase 2: Setup (Fixtures)

**Purpose**: Establish test prerequisites and browser state.

**Process**:
1. Get tab context (tabs_context_mcp)
2. Create dedicated test tab (tabs_create_mcp)
3. Execute fixture setup actions
4. Navigate to starting URL
5. Take initial screenshot (baseline)
6. Verify preconditions met

**Fixture Types**:
| Type | Purpose | Example |
|------|---------|---------|
| **data** | Create test data | Create user, seed products |
| **state** | Set browser state | Login, set cookies |
| **navigation** | Establish position | Navigate to starting page |
| **cleanup** | Clear residual state | Clear localStorage, cookies |

### Phase 3: Test Execution

**Purpose**: Execute test steps with assertion verification at each point.

**Process**:
```
For each test_case in suite:
  For each step in test_case.steps:
    1. Execute action (click, type, navigate)
    2. Wait for state transition (explicit wait)
    3. Capture evidence (screenshot, DOM)
    4. Run assertion
    5. If assertion fails:
       - Capture failure evidence
       - Mark test as FAILED
       - Skip remaining steps
       - Proceed to teardown
    6. If assertion passes:
       - Log success
       - Continue to next step
```

**Evidence Collection Points**:
- Before first action (initial state)
- After navigation changes
- Before and after form submissions
- At every assertion point
- On failure (mandatory)

### Phase 4: Assertion Verification

**Purpose**: Validate expected vs actual state at each checkpoint.

**Assertion Execution**:
```javascript
async function executeAssertion(assertion, context) {
  const startTime = Date.now();

  // Take pre-assertion screenshot
  const screenshot = await takeScreenshot(context.tabId);

  // Execute assertion
  const assertFn = ASSERTIONS[assertion.type];
  const result = await assertFn(context, ...assertion.params);

  // Build assertion result
  return {
    name: assertion.name,
    type: assertion.type,
    status: result.passed ? "PASSED" : "FAILED",
    expected: result.expected,
    actual: result.actual,
    duration_ms: Date.now() - startTime,
    screenshot_id: screenshot.imageId,
    evidence: result.evidence
  };
}
```

### Phase 5: Teardown

**Purpose**: Clean up test artifacts and restore state.

**Process**:
1. Execute fixture teardown actions
2. Delete test data created during setup
3. Clear cookies/localStorage if modified
4. Close test tab
5. Restore original tab context

**Teardown Rules**:
- ALWAYS execute teardown, even on test failure
- Log teardown failures but don't fail test for them
- Teardown order: reverse of setup order
- Verify cleanup completed

### Phase 6: Report Generation

**Purpose**: Produce structured test report with pass/fail summary.

**Report Contents**:
```yaml
test_report:
  summary:
    total_tests: 5
    passed: 4
    failed: 1
    skipped: 0
    duration_ms: 12500
    pass_rate: "80%"

  suite_results:
    - suite: "Login Flow Tests"
      tests: 3
      passed: 3
      failed: 0

    - suite: "Checkout Flow Tests"
      tests: 2
      passed: 1
      failed: 1

  failures:
    - test: "checkout_with_discount"
      assertion: "discount_applied"
      expected: "$90.00"
      actual: "$100.00"
      screenshot: "img_failure_001"

  evidence_index:
    screenshots: [...]
    dom_snapshots: [...]
```

---

## Production Guardrails

### MCP Preflight Check

Before executing tests, validate required MCPs:

```javascript
async function testPreflight() {
  const checks = {
    sequential_thinking: false,
    claude_in_chrome: false,
    memory_mcp: false
  };

  // Check sequential-thinking MCP (required for planning)
  try {
    await mcp__sequential-thinking__sequentialthinking({
      thought: "E2E test preflight check",
      thoughtNumber: 1,
      totalThoughts: 1,
      nextThoughtNeeded: false
    });
    checks.sequential_thinking = true;
  } catch (error) {
    throw new Error("CRITICAL: sequential-thinking MCP required for test planning");
  }

  // Check claude-in-chrome MCP (required for execution)
  try {
    await mcp__claude-in-chrome__tabs_context_mcp({});
    checks.claude_in_chrome = true;
  } catch (error) {
    throw new Error("CRITICAL: claude-in-chrome MCP required for test execution");
  }

  // Check memory-mcp (required for test history)
  try {
    checks.memory_mcp = true;
  } catch (error) {
    console.warn("Memory MCP unavailable - test history will not be stored");
  }

  return checks;
}
```

### Timeout Configuration

```javascript
const TEST_TIMEOUTS = {
  step_default: 10000,       // 10 seconds per step
  navigation: 15000,         // 15 seconds for page load
  form_submit: 20000,        // 20 seconds for form submission
  assertion: 5000,           // 5 seconds for assertion check
  screenshot: 10000,         // 10 seconds for screenshot capture
  suite_max: 300000,         // 5 minutes per suite
  test_max: 60000            // 1 minute per test case
};
```

### Retry Logic

```javascript
const RETRY_CONFIG = {
  max_retries: 2,
  retry_on: [
    "NETWORK_ERROR",
    "ELEMENT_NOT_FOUND",
    "TIMEOUT"
  ],
  no_retry_on: [
    "ASSERTION_FAILED",
    "MCP_UNAVAILABLE",
    "SETUP_FAILED"
  ],
  backoff_ms: [1000, 3000]  // Exponential backoff
};

async function executeWithRetry(testCase, context) {
  let lastError = null;

  for (let attempt = 0; attempt <= RETRY_CONFIG.max_retries; attempt++) {
    try {
      return await executeTestCase(testCase, context);
    } catch (error) {
      lastError = error;

      if (!RETRY_CONFIG.retry_on.includes(error.type)) {
        throw error;  // Don't retry assertion failures
      }

      if (attempt < RETRY_CONFIG.max_retries) {
        await sleep(RETRY_CONFIG.backoff_ms[attempt]);
      }
    }
  }

  throw lastError;
}
```

---

## Test Case Templates

### Template 1: Login Flow Test

```yaml
test_case:
  name: "successful_login"
  description: "Verify user can login with valid credentials"

  preconditions:
    - "User 'testuser' exists in system"
    - "User is logged out"

  steps:
    - step: 1
      action: navigate
      params: { url: "https://app.example.com/login" }
      assertion:
        type: url_contains
        expected: "/login"

    - step: 2
      action: form_input
      params: { selector: "[data-testid='email']", value: "testuser@example.com" }
      assertion:
        type: form_value
        selector: "[data-testid='email']"
        expected: "testuser@example.com"

    - step: 3
      action: form_input
      params: { selector: "[data-testid='password']", value: "Test123!" }
      assertion:
        type: element_exists
        selector: "[data-testid='password']"

    - step: 4
      action: click
      params: { selector: "[data-testid='login-button']" }
      wait: { type: "navigation", timeout: 10000 }
      assertion:
        type: url_contains
        expected: "/dashboard"

    - step: 5
      action: verify
      assertion:
        type: text_contains
        selector: "[data-testid='welcome-message']"
        expected: "Welcome"

  expected_result: "User redirected to dashboard with welcome message"
```

### Template 2: Form Validation Test

```yaml
test_case:
  name: "registration_validation"
  description: "Verify form validation errors display correctly"

  steps:
    - step: 1
      action: navigate
      params: { url: "https://app.example.com/register" }
      assertion:
        type: element_visible
        selector: "[data-testid='register-form']"

    - step: 2
      description: "Submit empty form to trigger validation"
      action: click
      params: { selector: "[data-testid='submit-button']" }
      assertion:
        type: element_count
        selector: ".error-message"
        expected: 3  # Email, password, confirm password

    - step: 3
      description: "Enter invalid email"
      action: form_input
      params: { selector: "[data-testid='email']", value: "invalid-email" }

    - step: 4
      action: click
      params: { selector: "[data-testid='submit-button']" }
      assertion:
        type: text_contains
        selector: "[data-testid='email-error']"
        expected: "valid email"

    - step: 5
      description: "Enter mismatched passwords"
      action: form_input
      params: { selector: "[data-testid='password']", value: "Test123!" }

    - step: 6
      action: form_input
      params: { selector: "[data-testid='confirm-password']", value: "Different123!" }

    - step: 7
      action: click
      params: { selector: "[data-testid='submit-button']" }
      assertion:
        type: text_contains
        selector: "[data-testid='password-error']"
        expected: "passwords must match"
```

### Template 3: Multi-Step Wizard Test

```yaml
test_case:
  name: "complete_onboarding_wizard"
  description: "Verify user can complete all onboarding steps"

  fixtures:
    setup:
      - action: login_as
        params: { username: "newuser", role: "new_signup" }

  steps:
    # Step 1: Profile Setup
    - step: 1
      action: verify
      assertion:
        type: text_equals
        selector: "[data-testid='wizard-step']"
        expected: "Step 1 of 4"

    - step: 2
      action: form_input
      params: { selector: "[data-testid='full-name']", value: "Test User" }

    - step: 3
      action: click
      params: { selector: "[data-testid='next-step']" }
      wait: { type: "element", selector: "[data-testid='step-2']" }
      assertion:
        type: text_equals
        selector: "[data-testid='wizard-step']"
        expected: "Step 2 of 4"

    # Step 2: Preferences
    - step: 4
      action: click
      params: { selector: "[data-testid='preference-dark-mode']" }
      assertion:
        type: attribute_equals
        selector: "[data-testid='preference-dark-mode']"
        attribute: "aria-checked"
        expected: "true"

    - step: 5
      action: click
      params: { selector: "[data-testid='next-step']" }
      assertion:
        type: text_equals
        selector: "[data-testid='wizard-step']"
        expected: "Step 3 of 4"

    # Step 3: Notification Settings
    - step: 6
      action: click
      params: { selector: "[data-testid='notify-email']" }

    - step: 7
      action: click
      params: { selector: "[data-testid='next-step']" }
      assertion:
        type: text_equals
        selector: "[data-testid='wizard-step']"
        expected: "Step 4 of 4"

    # Step 4: Confirmation
    - step: 8
      action: click
      params: { selector: "[data-testid='complete-wizard']" }
      wait: { type: "navigation" }
      assertion:
        type: url_contains
        expected: "/dashboard"

    - step: 9
      action: verify
      assertion:
        type: element_visible
        selector: "[data-testid='onboarding-complete-badge']"
```

### Template 4: CRUD Operations Test

```yaml
test_suite:
  name: "Product CRUD Tests"

  fixtures:
    setup:
      - action: login_as
        params: { role: "admin" }
      - action: navigate
        params: { url: "/admin/products" }

  test_cases:
    - name: "create_product"
      steps:
        - step: 1
          action: click
          params: { selector: "[data-testid='add-product']" }
          assertion:
            type: element_visible
            selector: "[data-testid='product-form']"

        - step: 2
          action: form_input
          params: { selector: "[data-testid='product-name']", value: "Test Product" }

        - step: 3
          action: form_input
          params: { selector: "[data-testid='product-price']", value: "99.99" }

        - step: 4
          action: click
          params: { selector: "[data-testid='save-product']" }
          assertion:
            type: text_contains
            selector: ".success-message"
            expected: "Product created"

    - name: "read_product"
      depends_on: "create_product"
      steps:
        - step: 1
          action: click
          params: { selector: "[data-testid='product-row-test-product']" }
          assertion:
            type: text_equals
            selector: "[data-testid='product-detail-name']"
            expected: "Test Product"

        - step: 2
          action: verify
          assertion:
            type: text_equals
            selector: "[data-testid='product-detail-price']"
            expected: "$99.99"

    - name: "update_product"
      depends_on: "create_product"
      steps:
        - step: 1
          action: click
          params: { selector: "[data-testid='edit-product']" }

        - step: 2
          action: form_input
          params: { selector: "[data-testid='product-price']", value: "89.99" }

        - step: 3
          action: click
          params: { selector: "[data-testid='save-product']" }
          assertion:
            type: text_contains
            selector: ".success-message"
            expected: "Product updated"

    - name: "delete_product"
      depends_on: "create_product"
      steps:
        - step: 1
          action: click
          params: { selector: "[data-testid='delete-product']" }

        - step: 2
          action: click
          params: { selector: "[data-testid='confirm-delete']" }
          assertion:
            type: text_contains
            selector: ".success-message"
            expected: "Product deleted"

        - step: 3
          action: verify
          assertion:
            type: element_count
            selector: "[data-testid='product-row-test-product']"
            expected: 0
```

---

## Visual Regression Testing

### Baseline Management

```javascript
const BASELINE_CONFIG = {
  storage_path: "skills/tooling/e2e-test/baselines/{project}/{suite}",
  comparison_threshold: 0.95,  // 95% similarity required
  highlight_differences: true,
  ignore_regions: []  // [{ x, y, width, height }]
};

async function captureBaseline(context, testName) {
  const screenshot = await mcp__claude-in-chrome__computer({
    action: "screenshot",
    tabId: context.tabId
  });

  // Store in Memory MCP as baseline
  await memoryStore({
    namespace: `${BASELINE_CONFIG.storage_path}/${testName}`,
    content: screenshot.imageId,
    tags: {
      type: "baseline",
      test: testName,
      captured: new Date().toISOString()
    }
  });

  return screenshot.imageId;
}

async function compareWithBaseline(context, testName) {
  const current = await mcp__claude-in-chrome__computer({
    action: "screenshot",
    tabId: context.tabId
  });

  const baseline = await memoryQuery({
    namespace: `${BASELINE_CONFIG.storage_path}/${testName}`,
    filter: { type: "baseline" }
  });

  if (!baseline) {
    return { status: "NO_BASELINE", message: "Baseline not found - capturing as new baseline" };
  }

  const similarity = await compareImages(current.imageId, baseline.content);

  return {
    status: similarity >= BASELINE_CONFIG.comparison_threshold ? "PASSED" : "FAILED",
    similarity: similarity,
    threshold: BASELINE_CONFIG.comparison_threshold,
    current_image: current.imageId,
    baseline_image: baseline.content
  };
}
```

### Difference Visualization

```javascript
async function generateDiffImage(currentId, baselineId) {
  // Highlight differences between screenshots
  const diff = {
    type: "visual_diff",
    current: currentId,
    baseline: baselineId,
    differences: []  // Regions that differ
  };

  // Store diff for debugging
  await memoryStore({
    namespace: "e2e-test/diffs",
    content: diff,
    tags: {
      type: "diff",
      generated: new Date().toISOString()
    }
  });

  return diff;
}
```

---

## Memory MCP Integration

### Test History Storage

**Namespace Pattern**: `skills/tooling/e2e-test/{project}/{suite}/{timestamp}`

**Store**:
- Test plans (from sequential-thinking phase)
- Execution results (pass/fail with evidence)
- Screenshots at assertion points
- Failure reports with debug context
- Visual baselines for regression testing

**Retrieve**:
- Previous test runs (for trend analysis)
- Similar failures (for pattern matching)
- Baselines (for visual comparison)
- Flaky test history (for stability analysis)

**Tagging Protocol**:
```json
{
  "WHO": "e2e-test-{session_id}",
  "WHEN": "ISO8601_timestamp",
  "PROJECT": "{project_name}",
  "WHY": "e2e-test-execution",
  "suite": "login_flow",
  "test_case": "successful_login",
  "status": "PASSED|FAILED|ERROR",
  "duration_ms": 2340,
  "assertions_total": 5,
  "assertions_passed": 5
}
```

### Test Trend Analysis

```javascript
async function getTestTrends(suite, days = 7) {
  const history = await vectorSearch({
    query: `e2e test results ${suite}`,
    namespace: `skills/tooling/e2e-test`,
    filter: {
      suite: suite,
      WHEN: { $gte: daysAgo(days) }
    },
    limit: 100
  });

  return {
    total_runs: history.length,
    pass_rate: calculatePassRate(history),
    avg_duration: calculateAvgDuration(history),
    flaky_tests: identifyFlakyTests(history),
    common_failures: groupFailures(history)
  };
}
```

---

## Success Criteria

**Quality Thresholds**:
- All test assertions verified with explicit pass/fail
- Screenshot evidence captured at every assertion point
- Test report generated with full failure details
- Fixtures executed (setup) and cleaned (teardown)
- No orphaned test data after suite completion
- Test execution within configured timeout limits

**Failure Indicators**:
- Any assertion returns FAILED status
- Test step times out before assertion
- Fixture setup fails (abort entire suite)
- Critical MCP unavailable (abort with error)
- Teardown fails (log warning, don't fail test)

---

## MCP Integration

**Required MCPs**:

| MCP | Purpose | Tools Used |
|-----|---------|------------|
| **sequential-thinking** | Test planning | `sequentialthinking` |
| **claude-in-chrome** | Test execution | `navigate`, `read_page`, `find`, `computer`, `form_input`, `tabs_context_mcp`, `tabs_create_mcp` |
| **memory-mcp** | Test history & baselines | `memory_store`, `vector_search`, `memory_query` |

**Optional MCPs**:
- **filesystem** (for saving reports locally)
- **playwright** (for advanced test scenarios)

---

## LEARNED PATTERNS

[assert|neutral] Section reserved for patterns discovered through Loop 1.5 session reflection [ground:skill-design] [conf:0.80] [state:provisional]

### High Confidence [conf:0.90+]

*(No patterns captured yet - this section will be populated through Loop 1.5 reflection)*

### Medium Confidence [conf:0.70-0.89]

*(No patterns captured yet)*

### Observations [conf:<0.70]

*(No patterns captured yet)*

---

## Anti-Patterns to Avoid

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| **Tests Without Assertions** | Just scripts, no validation | Every step needs assertion |
| **Cross-Test Dependencies** | Flaky execution order | Each test must be independent |
| **Hardcoded Selectors** | Brittle when DOM changes | Use data-testid attributes |
| **Missing Teardown** | Test pollution | Always cleanup fixtures |
| **Silent Failures** | Assertions pass incorrectly | Validate both positive and negative |
| **No Evidence** | Can't debug failures | Screenshot at every assertion |
| **Implicit Waits** | Flaky timing issues | Use explicit waits |

---

## Related Skills

**Upstream** (provide input to this skill):
- `intent-analyzer` - Detect e2e testing requests
- `browser-automation` - Base execution patterns
- `planner` - High-level test strategy

**Downstream** (use output from this skill):
- `quality-metrics-dashboard` - Test analytics
- `cicd-intelligent-recovery` - CI/CD integration
- `deployment-readiness` - Pre-deploy validation

**Parallel** (work together):
- `functionality-audit` - Verify code works
- `theater-detection` - Detect fake tests
- `visual-asset-generator` - Process screenshots

---

## Maintenance & Updates

**Version History**:
- v1.0.0 (2026-01-12): Initial release with assertion framework, suite organization, and reporting

**Feedback Loop**:
- Loop 1.5 (Session): Store learnings from test failures
- Loop 3 (Meta-Loop): Aggregate patterns every 3 days
- Update LEARNED PATTERNS section with discoveries

**Continuous Improvement**:
- Monitor test pass rates via Memory MCP
- Identify flaky tests for stabilization
- Optimize assertion coverage

---

<promise>E2E_TEST_VERILINGUA_VERIX_COMPLIANT</promise>
