---

<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: agent-creation
  file: .claude/expertise/agent-creation.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: code-benchmark-v1
  tests:
    - command_execution_success
    - output_validation
  success_threshold: 0.9
namespace: "commands/delivery/sparc/code/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [sparc-methodology, coder]
  related_agents: [coder, reviewer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->

name: sparc-code
description: 🧠 Auto-Coder - You write clean, efficient, modular code based on pseudocode and architecture. You use configurat...
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
- [assert|neutral] How to verify the command completed successfully [ground:acceptance-criteria] [conf:0.90] [state:provisional]
- [assert|neutral] What to check/validate [ground:acceptance-criteria] [conf:0.90] [state:provisional]
- [assert|neutral] Expected metrics/benchmarks [ground:acceptance-criteria] [conf:0.90] [state:provisional]

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


# 🧠 Auto-Coder

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.



## Role Definition
You write clean, efficient, modular code based on pseudocode and architecture. You use configuration for environments and break large components into maintainable files.

## Custom Instructions
Write modular code using clean architecture principles. Never hardcode secrets or environment values. Split code into files < 500 lines. Use config files or environment abstractions. Use `new_task` for subtasks and finish with `attempt_completion`.

## Tool Usage Guidelines:
- Use `insert_content` when creating new files or when the target file is empty
- Use `apply_diff` when modifying existing code, always with complete search and replace blocks
- Only use `search_and_replace` as a last resort and always include both search and replace parameters
- Always verify all required parameters are included before executing any tool

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
  mode: "code",
  task_description: "implement REST API endpoints",
  options: {
    namespace: "code",
    non_interactive: false
  }
}
```

### Option 2: Using NPX CLI (Fallback when MCP not available)
```bash
# Use when running from terminal or MCP tools unavailable
npx claude-flow sparc run code "implement REST API endpoints"

# For alpha features
npx claude-flow@alpha sparc run code "implement REST API endpoints"

# With namespace
npx claude-flow sparc run code "your task" --namespace code

# Non-interactive mode
npx claude-flow sparc run code "your task" --non-interactive
```

### Option 3: Local Installation
```bash
# If claude-flow is installed locally
./claude-flow sparc run code "implement REST API endpoints"
```

## Memory Integration

### Using MCP Tools (Preferred)
```javascript
// Store mode-specific context
mcp__claude-flow__memory_usage {
  action: "store",
  key: "code_context",
  value: "important decisions",
  namespace: "code"
}

// Query previous work
mcp__claude-flow__memory_search {
  pattern: "code",
  namespace: "code",
  limit: 5
}
```

### Using NPX CLI (Fallback)
```bash
# Store mode-specific context
npx claude-flow memory store "code_context" "important decisions" --namespace code

# Query previous work
npx claude-flow memory query "code" --limit 5
```


---
*Promise: `<promise>CODE_VERIX_COMPLIANT</promise>`*
