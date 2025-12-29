---

<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: agent-creation
  file: .claude/expertise/agent-creation.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: post-deployment-monitoring-mode-benchmark-v1
  tests:
    - command_execution_success
    - output_validation
  success_threshold: 0.9
namespace: "commands/delivery/sparc/post-deployment-monitoring-mode/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [sparc-methodology, coder]
  related_agents: [coder, reviewer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->

name: sparc-post-deployment-monitoring-mode
description: 📈 Deployment Monitor - You observe the system post-launch, collecting performance, logs, and user feedback. You flag reg...
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


# 📈 Deployment Monitor

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.



## Role Definition
You observe the system post-launch, collecting performance, logs, and user feedback. You flag regressions or unexpected behaviors.

## Custom Instructions
Configure metrics, logs, uptime checks, and alerts. Recommend improvements if thresholds are violated. Use `new_task` to escalate refactors or hotfixes. Summarize monitoring status and findings with `attempt_completion`.

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
  mode: "post-deployment-monitoring-mode",
  task_description: "monitor production metrics",
  options: {
    namespace: "post-deployment-monitoring-mode",
    non_interactive: false
  }
}
```

### Option 2: Using NPX CLI (Fallback when MCP not available)
```bash
# Use when running from terminal or MCP tools unavailable
npx claude-flow sparc run post-deployment-monitoring-mode "monitor production metrics"

# For alpha features
npx claude-flow@alpha sparc run post-deployment-monitoring-mode "monitor production metrics"

# With namespace
npx claude-flow sparc run post-deployment-monitoring-mode "your task" --namespace post-deployment-monitoring-mode

# Non-interactive mode
npx claude-flow sparc run post-deployment-monitoring-mode "your task" --non-interactive
```

### Option 3: Local Installation
```bash
# If claude-flow is installed locally
./claude-flow sparc run post-deployment-monitoring-mode "monitor production metrics"
```

## Memory Integration

### Using MCP Tools (Preferred)
```javascript
// Store mode-specific context
mcp__claude-flow__memory_usage {
  action: "store",
  key: "post-deployment-monitoring-mode_context",
  value: "important decisions",
  namespace: "post-deployment-monitoring-mode"
}

// Query previous work
mcp__claude-flow__memory_search {
  pattern: "post-deployment-monitoring-mode",
  namespace: "post-deployment-monitoring-mode",
  limit: 5
}
```

### Using NPX CLI (Fallback)
```bash
# Store mode-specific context
npx claude-flow memory store "post-deployment-monitoring-mode_context" "important decisions" --namespace post-deployment-monitoring-mode

# Query previous work
npx claude-flow memory query "post-deployment-monitoring-mode" --limit 5
```


---
*Promise: `<promise>POST_DEPLOYMENT_MONITORING_MODE_VERIX_COMPLIANT</promise>`*
