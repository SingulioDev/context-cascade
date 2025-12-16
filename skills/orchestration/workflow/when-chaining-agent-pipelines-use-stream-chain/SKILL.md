---
name: when-chaining-agent-pipelines-use-stream-chain
description: Chain agent outputs as inputs in sequential or parallel pipelines for
  data flow orchestration
version: 1.0.0
tags:
- pipeline
- streaming
- data-flow
- chaining
- orchestration
category: workflow
agents:
- task-orchestrator
- memory-coordinator
complexity: intermediate
estimated_duration: 30-60 minutes
prerequisites:
- Claude Flow installed
- Understanding of pipeline concepts
- Agent coordination experience
outputs:
- Pipeline configuration
- Streaming data flows
- Chained results
- Performance metrics
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
- **All agents complete successfully** with 100% task completion
- **Coordination overhead minimal** (<20% of total execution time)
- **No orphaned agents** - All spawned agents tracked and terminated
- **State fully recoverable** - Can resume from any failure point
- **Quality gates pass** - All validation checks successful

### Edge Cases to Handle
- **Agent failures** - Detect and replace failed agents automatically
- **Timeout scenarios** - Configure per-agent timeout with escalation
- **Resource exhaustion** - Limit concurrent agents, queue excess work
- **Conflicting results** - Implement conflict resolution strategy
- **Partial completion** - Support incremental progress with rollback

### Guardrails (NEVER Violate)
- **NEVER lose orchestration state** - Persist to memory after each phase
- **ALWAYS track all agents** - Maintain real-time agent registry
- **ALWAYS cleanup resources** - Terminate agents and free memory on completion
- **NEVER skip validation** - Run quality checks before marking complete
- **ALWAYS handle errors** - Every orchestration step needs error handling

### Evidence-Based Validation
- **Verify all agent outputs** - Check actual results vs expected contracts
- **Validate execution order** - Confirm dependencies respected
- **Measure performance** - Track execution time vs baseline
- **Check resource usage** - Monitor memory, CPU, network during execution
- **Audit state consistency** - Verify orchestration state matches reality


# Agent Pipeline Chaining SOP

## Overview

This skill implements agent pipeline chaining where outputs from one agent become inputs to the next, supporting both sequential and parallel execution patterns with streaming data flows.

## Agents & Responsibilities

### task-orchestrator
**Role:** Pipeline coordination and orchestration
**Responsibilities:**
- Design pipeline architecture
- Connect agent stages
- Monitor data flow
- Handle pipeline errors

### memory-coordinator
**Role:** Data flow and state management
**Responsibilities:**
- Store intermediate results
- Coordinate data passing
- Manage pipeline state
- Ensure data consistency

## Phase 1: Design Pipeline

### Objective
Design pipeline architecture with stages, data flows, and execution strategy.

### Scripts

```bash
# Design pipeline architecture
npx claude-flow@alpha pipeline design \
  --stages "research,analyze,code,test,review" \
  --flow sequential \
  --output pipeline-design.json

# Define data flow
npx claude-flow@alpha pipeline dataflow \
  --design pipeline-design.json \
  --output dataflow-spec.json

# Visualize pipeline
npx claude-flow@alpha pipeline visualize \
  --design pipeline-design.json \
  --output pipeline-diagram.png

# Store design in memory
npx claude-flow@alpha memory store \
  --key "pipeline/design" \
  --file pipeline-design.json
```

### Pipeline Patterns

**Sequential Pipeline:**
```
Agent1 → Agent2 → Agent3 → Agent4
```

**Parallel Pipeline:**
```
       ┌─ Agent2 ─┐
Agent1 ├─ Agent3 ─┤ Agent5
       └─ Agent4 ─┘
```

**Hybrid Pipeline:**
```
Agent1 → ┬─ Agent2 ─┐
         └─ Agent3 ─┴─ Agent4 → Agent5
```

## Phase 2: Connect Agents

### Objective
Connect agents with proper data flow channels and state management.

### Scripts

```bash
# Initialize pipeline
npx claude-flow@alpha pipeline init \
  --design pipeline-design.json

# Spawn pipeline agents
npx claude-flow@alpha agent spawn --type researcher --pipeline-stage 1
npx claude-flow@alpha agent spawn --type analyst --pipeline-stage 2
npx claude-flow@alpha agent spawn --type coder --pipeline-stage 3
npx claude-flow@alpha agent spawn --type tester --pipeline-stage 4

# Connect pipeline stages
npx claude-flow@alpha pipeline connect \
  --from-stage 1 --to-stage 2 \
  --data-channel "memory"

npx claude-flow@alpha pipeline connect \
  --from-stage 2 --to-stage 3 \
  --data-channel "stream"

# Verify connections
npx claude-flow@alpha pipeline status --show-connections
```

### Data Flow Mechanisms

**Memory-Based:**
```bash
# Agent 1 stores output
npx claude-flow@alpha memory store \
  --key "pipeline/stage-1/output" \
  --value "research findings..."

# Agent 2 retrieves input
npx claude-flow@alpha memory retrieve \
  --key "pipeline/stage-1/output"
```

**Stream-Based:**
```bash
# Agent 1 streams output
npx claude-flow@alpha stream write \
  --channel "stage-1-to-2" \
  --data "streaming data..."

# Agent 2 consumes stream
npx claude-flow@alpha stream read \
  --channel "stage-1-to-2"
```

## Phase 3: Execute Pipeline

### Objective
Execute pipeline with proper sequencing and data flow.

### Scripts

```bash
# Execute sequential pipeline
npx claude-flow@alpha pipeline execute \
  --design pipeline-design.json \
  --input initial-data.json \
  --strategy sequential

# Execute parallel pipeline
npx claude-flow@alpha pipeline execute \
  --design pipeline-design.json \
  --input initial-data.json \
  --strategy parallel \
  --max-parallelism 3

# Monitor execution
npx claude-flow@alpha pipeline monitor --interval 5

# Track stage progress
npx claude-flow@alpha pipeline stages --show-progress
```

### Execution Strategies

**Sequential:**
- Stages execute one after another
- Output of stage N is input to stage N+1
- Simple error handling
- Predictable execution time

**Parallel:**
- Independent stages execute simultaneously
- Outputs merged at synchronization points
- Complex error handling
- Faster overall execution

**Adaptive:**
- Dynamically switches between sequential and parallel
- Based on stage dependencies and resource availability
- Optimizes for throughput

## Phase 4: Monitor Streaming

### Objective
Monitor data flow and pipeline execution in real-time.

### Scripts

```bash
# Monitor data flow
npx claude-flow@alpha stream monitor \
  --all-channels \
  --interval 2 \
  --output stream-metrics.json

# Track stage throughput
npx claude-flow@alpha pipeline metrics \
  --metric throughput \
  --per-stage

# Monitor backpressure
npx claude-flow@alpha stream backpressure --detect

# Generate flow report
npx claude-flow@alpha pipeline report \
  --include-timing \
  --include-throughput \
  --output pipeline-report.md
```

### Key Metrics

- **Stage Throughput:** Items processed per minute per stage
- **Pipeline Latency:** End-to-end processing time
- **Backpressure:** Queue buildup at stage boundaries
- **Error Rate:** Failures per stage
- **Resource Utilization:** CPU/memory per agent

## Phase 5: Validate Results

### Objective
Validate pipeline outputs and ensure data integrity.

### Scripts

```bash
# Collect pipeline results
npx claude-flow@alpha pipeline results \
  --output pipeline-results.json

# Validate data integrity
npx claude-flow@alpha pipeline validate \
  --results pipeline-results.json \
  --schema validation-schema.json

# Compare with expected output
npx claude-flow@alpha pipeline compare \
  --actual pipeline-results.json \
  --expected expected-output.json

# Generate validation report
npx claude-flow@alpha pipeline report \
  --type validation \
  --output validation-report.md
```

## Success Criteria

- [ ] Pipeline design complete
- [ ] All stages connected
- [ ] Data flow functional
- [ ] Outputs validated
- [ ] Performance acceptable

### Performance Targets
- Stage latency: <30 seconds average
- Pipeline throughput: ≥10 items/minute
- Error rate: <2%
- Data integrity: 100%

## Best Practices

1. **Clear Stage Boundaries:** Each stage has single responsibility
2. **Data Validation:** Validate outputs before passing to next stage
3. **Error Handling:** Implement retry and fallback mechanisms
4. **Backpressure Management:** Prevent queue overflow
5. **Monitoring:** Track metrics continuously
6. **State Management:** Use memory coordination for state
7. **Testing:** Test each stage independently
8. **Documentation:** Document data schemas and flows

## Common Issues & Solutions

### Issue: Pipeline Stalls
**Symptoms:** Stages stop processing
**Solution:** Check for backpressure, increase buffer sizes

### Issue: Data Loss
**Symptoms:** Missing data in outputs
**Solution:** Implement acknowledgment mechanism, use reliable channels

### Issue: High Latency
**Symptoms:** Slow end-to-end processing
**Solution:** Identify bottleneck stage, add parallelism

## Integration Points

- **swarm-orchestration:** For complex multi-pipeline orchestration
- **advanced-swarm:** For optimized agent coordination
- **performance-analysis:** For bottleneck detection

## References

- Pipeline Design Patterns
- Stream Processing Theory
- Data Flow Architectures