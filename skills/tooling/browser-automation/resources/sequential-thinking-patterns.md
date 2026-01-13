# Sequential-Thinking Patterns for Browser Automation

## Pattern 1: Linear Workflow (Simple)

**Use Case**: Single-page form with 5-10 fields

**Structure**:
- Thought 1: Navigate to page
- Thought 2-N: Fill each field group
- Thought N+1: Submit and verify

**Example**:
```
Thought 1/6: Navigate to contact form
Thought 2/6: Fill name and email fields
Thought 3/6: Fill message textarea
Thought 4/6: Verify fields populated
Thought 5/6: Click submit button
Thought 6/6: Verify success message
```

## Pattern 2: Conditional Branching (Medium)

**Use Case**: Form with validation and error states

**Structure**:
- Thought 1-2: Navigate and inspect
- Thought 3-N: Main path with checkpoints
- Thought N+1-M: Alternative paths for errors
- Thought M+1: Final verification

**Example**:
```
Thought 1/10: Navigate to registration
Thought 2/10: Check if username field exists
Thought 3/10: Enter username and validate
Thought 4/10: If validation fails, try alternative
Thought 5/10: If validation passes, proceed to password
...
```

## Pattern 3: Iterative Processing (Complex)

**Use Case**: Bulk operations across multiple pages

**Structure**:
- Thought 1-2: Setup and pagination logic
- Thought 3-N: Loop structure with checkpoints
- Thought N+1: Aggregation and verification

**Example**:
```
Thought 1/12: Navigate to product list
Thought 2/12: Count total pages (pagination)
Thought 3/12: Loop: For each page
Thought 4/12:   Extract product data
Thought 5/12:   Verify extraction complete
Thought 6/12:   Navigate to next page
Thought 7/12:   Handle last page edge case
Thought 8/12: Aggregate all extracted data
Thought 9/12: Verify data completeness
...
```

## Pattern 4: Multi-Tab Coordination (Very Complex)

**Use Case**: Workflows requiring multiple browser contexts

**Structure**:
- Thought 1-2: Tab management strategy
- Thought 3-N: Per-tab workflows with coordination
- Thought N+1: Cross-tab verification

**Example**:
```
Thought 1/15: Create Tab A for main workflow
Thought 2/15: Create Tab B for verification
Thought 3/15: Tab A: Fill registration form
Thought 4/15: Tab A: Submit form
Thought 5/15: Tab B: Open email client
Thought 6/15: Tab B: Find verification email
Thought 7/15: Tab B: Extract verification link
Thought 8/15: Tab A: Navigate to link (from Tab B)
...
```

## Anti-Patterns to Avoid

### Anti-Pattern 1: Insufficient Planning
**Problem**: Only 2-3 thoughts for complex workflow
**Fix**: Minimum 5 thoughts per workflow; expand to cover edge cases

### Anti-Pattern 2: No Error Paths
**Problem**: Only happy path planned
**Fix**: Include "what if X fails" thoughts for critical steps

### Anti-Pattern 3: Missing Verification
**Problem**: No state checking between steps
**Fix**: Add verification thoughts after major state changes

### Anti-Pattern 4: Vague Actions
**Problem**: "Do the thing" without specific MCP tool calls
**Fix**: Name exact tools (navigate, form_input, screenshot, etc.)
