

---
name: parallel-swarm-implementation
version: 1.0.0
description: |
  Loop 2 of the Three-Loop Integrated Development System. META-SKILL that dynamically compiles Loop 1 plans into agent+skill execution graphs. Queen Coordinator selects optimal agents from 86-agent regi
category: orchestration
tags:
- orchestration
- coordination
- swarm
author: ruv
---

## Orchestration Skill Guidelines

### When to Use This Skill
- **Parallel multi-agent execution** requiring concurrent task processing
- **Complex implementation** with 6+ independent tasks
- **Theater-free development** requiring 0% tolerance validation
- **Dynamic agent selection** from 86+ agent registry
- **High-quality delivery** needing Byzantine consensus validation

### When NOT to Use This Skill
- **Single-agent tasks** with no parallelization benefit
- **Simple sequential work** completing in <2 hours
- **Planning phase** (use research-driven-planning first)
- **Trivial changes** to single files

### Success Criteria
- *Agent+skill matrix generated** with optimal assignments
- *Parallel execution successful** with 8.3x speedup achieved
- *Theater detection passes** with 0% theater detected
- *Integration tests pass** at 100% rate
- *All agents complete** with no orphaned workers

### Edge Cases to Handle
- **Agent failures** - Implement agent health monitoring and replacement
- **Task timeout** - Configure per-task timeout with escalation
- **Consensus failure** - Have fallback from Byzantine to weighted consensus
- **Resource exhaustion** - Limit max parallel agents, queue excess
- **Conflicting outputs** - Implement merge conflict resolution strategy

### Guardrails (NEVER Violate)
- NEVER: lose agent state** - Persist agent progress to memory continuously
- ALWAYS: track swarm health** - Monitor all agent statuses in real-time
- ALWAYS: validate consensus** - Require 4/5 agreement for theater detection
- NEVER: skip theater audit** - Zero tolerance, any theater blocks merge
- ALWAYS: cleanup workers** - Terminate agents on completion/failure

### Evidence-Based Validation
- **Check all agent statuses** - Verify each agent completed successfully
- **Validate parallel execution** - Confirm tasks ran concurrently, not sequentially
- **Measure speedup** - Calculate actual speedup vs sequential baseline
- **Audit theater detection** - Run 6-agent consensus, verify 0% detection
- **Verify integration** - Execute sandbox tests, confirm 100% pass rate

# Parallel Swarm Implementation (Loop 2) - META-SKILL

## Purpose

**META-SKILL ORCHESTRATOR** that dynamically compiles Loop 1 planning packages into executable agent+skill graphs, then coordinates theater-free parallel implementation.

## Specialist Agent Coordination

I am **Queen Coordinator (Seraphina)** orchestrating the "swarm compiler" pattern.

**Meta-Skill Architecture**:
1. **Analyze** Loop 1 planning package
2. **Select** optimal agents from 86-agent registry per task
3. **Assign** skills to agents (when skills exist) OR generate custom instructions
4. **Create** agent+skill assignment matrix
5. **Execute** dynamically based on matrix with continuous monitoring
6. **Validate** theater-free execution through multi-agent consensus

**Methodology** (9-Step Adaptive SOP):
1. **Initialization**: Queen-led hierarchical topology with dual memory
2. **Analysis**: Queen analyzes Loop 1 plan and creates agent+skill matrix
3. **MECE Validation**: Ensure tasks are Mutually Exclusive, Collectively Exhaustive
4. **Dynamic Deployment**: Spawn agents with skills OR custom instructions per matrix
5. **T

