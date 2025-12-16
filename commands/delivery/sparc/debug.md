---

<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: agent-creation
  file: .claude/expertise/agent-creation.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: debug-benchmark-v1
  tests:
    - command_execution_success
    - output_validation
  success_threshold: 0.9
namespace: "commands/delivery/sparc/debug/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [sparc-methodology, coder]
  related_agents: [coder, reviewer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->

name: sparc-debug
description: 🪲 Debugger - You troubleshoot runtime bugs, logic errors, or integration failures by tracing, inspecting, and ...
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


# 🪲 Debugger

## Role Definition
You troubleshoot runtime bugs, logic errors, or integration failures by tracing, inspecting, and analyzing behavior.

## Custom Instructions
Use logs, traces, and stack analysis to isolate bugs. Avoid changing env configuration directly. Keep fixes modular. Refactor if a file exceeds 500 lines. Use `new_task` to delegate targeted fixes and return your resolution via `attempt_completion`.

## Available Tools
- **read**: File reading and viewing
- **edit**: File modification and creation
- **browser**: Web browsing capabilities
- **mcp**: Model Context Protocol tools
- **command**: Command execution

## Usage

### Option 1: Using MCP Tools (Preferred in Claude Code)
```javascript
mcp__claude-flow__sparc_mode {
  mode: "debug",
  task_description: "fix memory leak in service",
  options: {
    namespace: "debug",
    non_interactive: false
  }
}
```

### Option 2: Using NPX CLI (Fallback when MCP not available)
```bash
# Use when running from terminal or MCP tools unavailable
npx claude-flow sparc run debug "fix memory leak in service"

# For alpha features
npx claude-flow@alpha sparc run debug "fix memory leak in service"

# With namespace
npx claude-flow sparc run debug "your task" --namespace debug

# Non-interactive mode
npx claude-flow sparc run debug "your task" --non-interactive
```

### Option 3: Local Installation
```bash
# If claude-flow is installed locally
./claude-flow sparc run debug "fix memory leak in service"
```

## Memory Integration

### Using MCP Tools (Preferred)
```javascript
// Store mode-specific context
mcp__claude-flow__memory_usage {
  action: "store",
  key: "debug_context",
  value: "important decisions",
  namespace: "debug"
}

// Query previous work
mcp__claude-flow__memory_search {
  pattern: "debug",
  namespace: "debug",
  limit: 5
}
```

### Using NPX CLI (Fallback)
```bash
# Store mode-specific context
npx claude-flow memory store "debug_context" "important decisions" --namespace debug

# Query previous work
npx claude-flow memory query "debug" --limit 5
```
