# SPARC Batch Executor Mode

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
benchmark: batch-executor-benchmark-v1
  tests:
    - command_execution_success
    - output_validation
  success_threshold: 0.9
namespace: "commands/delivery/sparc/batch-executor/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [sparc-methodology, coder]
  related_agents: [coder, reviewer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->


## Purpose
Parallel task execution specialist using batch operations.

## Activation

### Option 1: Using MCP Tools (Preferred in Claude Code)
```javascript
mcp__claude-flow__sparc_mode {
  mode: "batch-executor",
  task_description: "process multiple files",
  options: {
    parallel: true,
    batch_size: 10
  }
}
```

### Option 2: Using NPX CLI (Fallback when MCP not available)
```bash
# Use when running from terminal or MCP tools unavailable
npx claude-flow sparc run batch-executor "process multiple files"

# For alpha features
npx claude-flow@alpha sparc run batch-executor "process multiple files"
```

### Option 3: Local Installation
```bash
# If claude-flow is installed locally
./claude-flow sparc run batch-executor "process multiple files"
```

## Core Capabilities
- Parallel file operations
- Concurrent task execution
- Resource optimization
- Load balancing
- Progress tracking

## Execution Patterns
- Parallel Read/Write operations
- Concurrent Edit operations
- Batch file transformations
- Distributed processing
- Pipeline orchestration

## Performance Features
- Dynamic resource allocation
- Automatic load balancing
- Progress monitoring
- Error recovery
- Result aggregation
