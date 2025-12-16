---

<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: agent-creation
  file: .claude/expertise/agent-creation.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: tutorial-benchmark-v1
  tests:
    - command_execution_success
    - output_validation
  success_threshold: 0.9
namespace: "commands/delivery/sparc/tutorial/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [sparc-methodology, coder]
  related_agents: [coder, reviewer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->

name: sparc-tutorial
description: 📘 SPARC Tutorial - You are the SPARC onboarding and education assistant. Your job is to guide users through the full...
---

## Command Purpose
One-line description of what this command does.

## Input Requirements
- **Parameters**: What parameters are needed
- **Context**: What context must be available
- **Prerequisites**: What must be true before running

## Expected Output
- **Primary**: Main deliverable/result
- **Side Effects**: Files created, state changes
- **Format**: Structure of output (reports, files, logs)

## Success Indicators
- How to verify the command completed successfully
- What to check/validate
- Expected metrics/benchmarks

## Error Handling
- **Common Errors**: Typical failure modes
- **Recovery**: How to handle failures
- **Fallbacks**: Alternative approaches

## Related Commands
- **Before**: Commands that should run first
- **After**: Commands that typically follow
- **Complementary**: Commands that work together

## SPARC Integration
- **Phase**: Which SPARC phase this command supports (Specification/Pseudocode/Architecture/Refinement/Completion)
- **Activation**: MCP vs NPX vs local execution
- **Memory**: What gets stored in Memory MCP


# 📘 SPARC Tutorial

## Role Definition
You are the SPARC onboarding and education assistant. Your job is to guide users through the full SPARC development process using structured thinking models. You help users understand how to navigate complex projects using the specialized SPARC modes and properly formulate tasks using new_task.

## Custom Instructions
You teach developers how to apply the SPARC methodology through actionable examples and mental models.

## Available Tools
- **read**: File reading and viewing

## Usage

### Option 1: Using MCP Tools (Preferred in Claude Code)
```javascript
mcp__claude-flow__sparc_mode {
  mode: "tutorial",
  task_description: "guide me through SPARC methodology",
  options: {
    namespace: "tutorial",
    non_interactive: false
  }
}
```

### Option 2: Using NPX CLI (Fallback when MCP not available)
```bash
# Use when running from terminal or MCP tools unavailable
npx claude-flow sparc run tutorial "guide me through SPARC methodology"

# For alpha features
npx claude-flow@alpha sparc run tutorial "guide me through SPARC methodology"

# With namespace
npx claude-flow sparc run tutorial "your task" --namespace tutorial

# Non-interactive mode
npx claude-flow sparc run tutorial "your task" --non-interactive
```

### Option 3: Local Installation
```bash
# If claude-flow is installed locally
./claude-flow sparc run tutorial "guide me through SPARC methodology"
```

## Memory Integration

### Using MCP Tools (Preferred)
```javascript
// Store mode-specific context
mcp__claude-flow__memory_usage {
  action: "store",
  key: "tutorial_context",
  value: "important decisions",
  namespace: "tutorial"
}

// Query previous work
mcp__claude-flow__memory_search {
  pattern: "tutorial",
  namespace: "tutorial",
  limit: 5
}
```

### Using NPX CLI (Fallback)
```bash
# Store mode-specific context
npx claude-flow memory store "tutorial_context" "important decisions" --namespace tutorial

# Query previous work
npx claude-flow memory query "tutorial" --limit 5
```
