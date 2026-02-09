

---
name: flow-nexus-swarm
version: 1.0.0
description: |
  Cloud-based AI swarm deployment and event-driven workflow automation with Flow Nexus platform
category: orchestration
tags:
- swarm
- workflow
- cloud
- agents
- automation
triggers:
  - "when deploying cloud swarm"
  - "when deploying cloud swarm"
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

# Flow Nexus Swarm & Workflow Orchestration

Deploy and manage cloud-based AI agent swarms with event-driven workflow automation, message queue processing, and intelligent agent coordination.

## 📋 Table of Contents

1. [Overview](#overview)
2. [Swarm Management](#swarm-management)
3. [Workflow Automation](#workflow-automation)
4. [Agent Orchestration](#agent-orchestration)
5. [Templates & Patterns](#templates--patterns)
6. [Advanced Features](#advanced-features)
7. [Best Practices](#best-practices)

## Overview

Flow Nexus provides cloud-based orchestration for AI agent swarms with:

- **Multi-topology Support**: Hierarchical, mesh, ring, and star architectures
- **Event-driven Workflows**: Message queue processing with async execution
- **Template Library**: Pre-built swarm configurations for common use cases
- **Intelligent Agent Assignment**: Vector similarity matching for optimal agent selection
- **Real-time Monitoring**: Comprehensive metrics and audit trails
- **Scalable Infrastructure**: Cloud-based execution with auto-scaling

## Swarm Management

### Initialize Swarm

Create a new swarm

