

---
name: coordination
version: 2.0.0
description: |
  Advanced multi-agent coordination patterns including mesh, hierarchical, and adaptive topologies with state synchronization, consensus mechanisms, and distributed task execution. Use when orchestratin
category: orchestration
tags:
- coordination
- multi-agent
- orchestration
- topology
- consensus
author: ruv
---

## Orchestration Skill Guidelines

### When to Use This Skill
- **Multi-agent coordination** requiring topology-aware task distribution
- **Cloud-based orchestration** with Flow Nexus platform integration
- **Event-driven workflows** needing message-based coordination
- **Distributed systems** spanning multiple execution environments
- **Scalable swarms** with adaptive topology management

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination overhead
- **Local-only execution** not using cloud features
- **Simple sequential work** without event-driven needs
- **Static topologies** not requiring adaptive scaling

### Success Criteria
- *Coordination topology established** (mesh/hierarchical/star)
- *All agents registered** in coordination namespace
- *Event routing functional** with <50ms message latency
- *No coordination deadlocks** - All agents progressing
- *Scalability validated** - Handles target agent count

### Edge Cases to Handle
- **Network partitions** - Implement partition tolerance with eventual consistency
- **Message loss** - Add message acknowledgment and retry logic
- **Agent disconnection** - Detect disconnects, redistribute work
- **Topology reconfiguration** - Support live topology changes without restart
- **Rate limiting** - Handle cloud API rate limits with backoff

### Guardrails (NEVER Violate)
- NEVER: lose coordination state** - Persist topology and agent registry
- ALWAYS: validate topology** - Check for cycles, orphaned nodes
- ALWAYS: monitor message queues** - Prevent queue overflow
- NEVER: skip health checks** - Continuous agent liveness monitoring
- ALWAYS: handle failures gracefully** - No cascading failures

### Evidence-Based Validation
- **Verify topology structure** - Validate graph properties (connected, acyclic if needed)
- **Check message delivery** - Confirm all messages reached targets
- **Measure coordination overhead** - Calculate % time spent on coordination vs work
- **Validate agent reachability** - Ping all agents, verify responses
- **Audit scalability** - Test with max agent count, measure performance

# Agent Coordination Skill

## Overview

Advanced multi-agent coordination system implementing sophisticated topologies (mesh, hierarchical, ring, star), consensus mechanisms (Byzantine, Raft, gossip), and distributed task execution patterns. This skill enables orchestration of complex workflows requiring multiple agents to collaborate, synchronize state, reach consensus, and execute tasks in a coordinated manner.

## When to Use This Skill

Activate this skill when:
- **Complex Multi-Agent Workflows**: Need to coordinate 3+ agents with interdependencies
- **Distributed Decision-Making**: Require consensus among multiple agents
- **Sophisticated Topologies**: Need mesh, hierarchical, or adaptive network structures
- **State Synchronization**: Agents must share and synchronize state
- **Fault-Tolerant Execution**: Require Byzantine fault tolerance or graceful degradation
- **Dynamic Scaling**: Agent count or topology changes during execution
- **Performance Optimization**: Need optimal agent allocation and load balancing

## Core Coordination Patterns

### 1. Topology Patterns

###

