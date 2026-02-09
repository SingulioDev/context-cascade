

---
name: stream-chain
version: 1.0.0
description: |
  Stream-JSON chaining for multi-agent pipelines, data transformation, and sequential workflows
category: workflow
tags:
- streaming
- pipeline
- chaining
- multi-agent
- workflow
triggers:
  - "when chaining agent pipelines"
author: ruv
---

## Orchestration Skill Guidelines

### When to Use This Skill
- **Multi-agent coordination** requiring centralized orchestration
- **Complex workflows** with multiple dependent tasks
- **Parallel execution** benefiting from concurrent agent spawning
- **Quality-controlled delivery** needing validation and consensus
- **Production workflows** requiring audit trails and state management

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination requirements
- **Simple sequential work** completing in <30 minutes
- **Trivial operations** with no quality gates
- **Exploratory work** not needing formal orchestration

### Success Criteria
- *All agents complete successfully** with 100% task completion
- *Coordination overhead minimal** (<20% of total execution time)
- *No orphaned agents** - All spawned agents tracked and terminated
- *State fully recoverable** - Can resume from any failure point
- *Quality gates pass** - All validation checks successful

### Edge Cases to Handle
- **Agent failures** - Detect and replace failed agents automatically
- **Timeout scenarios** - Configure per-agent timeout with escalation
- **Resource exhaustion** - Limit concurrent agents, queue excess work
- **Conflicting results** - Implement conflict resolution strategy
- **Partial completion** - Support incremental progress with rollback

### Guardrails (NEVER Violate)
- NEVER: lose orchestration state** - Persist to memory after each phase
- ALWAYS: track all agents** - Maintain real-time agent registry
- ALWAYS: cleanup resources** - Terminate agents and free memory on completion
- NEVER: skip validation** - Run quality checks before marking complete
- ALWAYS: handle errors** - Every orchestration step needs error handling

### Evidence-Based Validation
- **Verify all agent outputs** - Check actual results vs expected contracts
- **Validate execution order** - Confirm dependencies respected
- **Measure performance** - Track execution time vs baseline
- **Check resource usage** - Monitor memory, CPU, network during execution
- **Audit state consistency** - Verify orchestration state matches reality

# Stream-Chain Skill

Execute sophisticated multi-step workflows where each agent's output flows into the next, enabling complex data transformations and sequential processing pipelines.

## Overview

Stream-Chain provides two powerful modes for orchestrating multi-agent workflows:

1. **Custom Chains** (`run`): Execute custom prompt sequences with full control
2. **Predefined Pipelines** (`pipeline`): Use battle-tested workflows for common tasks

Each step in a chain receives the complete output from the previous step, enabling sophisticated multi-agent coordination through streaming data flow.

---

## Quick Start

### Run a Custom Chain

```bash
claude-flow stream-chain run \
  "Analyze codebase structure" \
  "Identify improvement areas" \
  "Generate action plan"
```

### Execute a Pipeline

```bash
claude-flow stream-chain pipeline analysis
```

---

## Custom Chains (`run`)

Execute custom stream chains with your own prompts for maximum flexibility.

### Syntax

```bash
claude-flow stream-chain run <prompt1> <prompt2> [...] [options]
```

**Requirements:

