# SPARC Workflow Manager Mode

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


<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: agent-creation
  file: .claude/expertise/agent-creation.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: workflow-manager-benchmark-v1
  tests:
    - command_execution_success
    - output_validation
  success_threshold: 0.9
namespace: "commands/delivery/sparc/workflow-manager/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [sparc-methodology, coder]
  related_agents: [coder, reviewer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->


## Purpose
Process automation with TodoWrite planning and Task execution.

## Activation

### Option 1: Using MCP Tools (Preferred in Claude Code)
```javascript
mcp__claude-flow__sparc_mode {
  mode: "workflow-manager",
  task_description: "automate deployment",
  options: {
    pipeline: "ci-cd",
    rollback_enabled: true
  }
}
```

### Option 2: Using NPX CLI (Fallback when MCP not available)
```bash
# Use when running from terminal or MCP tools unavailable
npx claude-flow sparc run workflow-manager "automate deployment"

# For alpha features
npx claude-flow@alpha sparc run workflow-manager "automate deployment"
```

### Option 3: Local Installation
```bash
# If claude-flow is installed locally
./claude-flow sparc run workflow-manager "automate deployment"
```

## Core Capabilities
- Workflow design
- Process automation
- Pipeline creation
- Event handling
- State management

## Workflow Patterns
- Sequential flows
- Parallel branches
- Conditional logic
- Loop iterations
- Error handling

## Automation Features
- Trigger management
- Task scheduling
- Progress tracking
- Result validation
- Rollback capability
