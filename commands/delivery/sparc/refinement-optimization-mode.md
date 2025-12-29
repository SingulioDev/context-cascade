---

<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: agent-creation
  file: .claude/expertise/agent-creation.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: refinement-optimization-mode-benchmark-v1
  tests:
    - command_execution_success
    - output_validation
  success_threshold: 0.9
namespace: "commands/delivery/sparc/refinement-optimization-mode/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [sparc-methodology, coder]
  related_agents: [coder, reviewer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->

name: sparc-refinement-optimization-mode
description: 🧹 Optimizer - You refactor, modularize, and improve system performance. You enforce file size limits, dependenc...
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


# 🧹 Optimizer

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.



## Role Definition
You refactor, modularize, and improve system performance. You enforce file size limits, dependency decoupling, and configuration hygiene.

## Custom Instructions
Audit files for clarity, modularity, and size. Break large components (>500 lines) into smaller ones. Move inline configs to env files. Optimize performance or structure. Use `new_task` to delegate changes and finalize with `attempt_completion`.

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
  mode: "refinement-optimization-mode",
  task_description: "optimize database queries",
  options: {
    namespace: "refinement-optimization-mode",
    non_interactive: false
  }
}
```

### Option 2: Using NPX CLI (Fallback when MCP not available)
```bash
# Use when running from terminal or MCP tools unavailable
npx claude-flow sparc run refinement-optimization-mode "optimize database queries"

# For alpha features
npx claude-flow@alpha sparc run refinement-optimization-mode "optimize database queries"

# With namespace
npx claude-flow sparc run refinement-optimization-mode "your task" --namespace refinement-optimization-mode

# Non-interactive mode
npx claude-flow sparc run refinement-optimization-mode "your task" --non-interactive
```

### Option 3: Local Installation
```bash
# If claude-flow is installed locally
./claude-flow sparc run refinement-optimization-mode "optimize database queries"
```

## Memory Integration

### Using MCP Tools (Preferred)
```javascript
// Store mode-specific context
mcp__claude-flow__memory_usage {
  action: "store",
  key: "refinement-optimization-mode_context",
  value: "important decisions",
  namespace: "refinement-optimization-mode"
}

// Query previous work
mcp__claude-flow__memory_search {
  pattern: "refinement-optimization-mode",
  namespace: "refinement-optimization-mode",
  limit: 5
}
```

### Using NPX CLI (Fallback)
```bash
# Store mode-specific context
npx claude-flow memory store "refinement-optimization-mode_context" "important decisions" --namespace refinement-optimization-mode

# Query previous work
npx claude-flow memory query "refinement-optimization-mode" --limit 5
```


---
*Promise: `<promise>REFINEMENT_OPTIMIZATION_MODE_VERIX_COMPLIANT</promise>`*
