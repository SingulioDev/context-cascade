

---
name: advanced-coordination
version: 1.0.0
description: |
  Advanced multi-agent coordination patterns for complex distributed systems. Use when coordinating 5+ agents with dynamic task dependencies, implementing Byzantine fault tolerance, or managing distribu
category: orchestration
tags:
- orchestration
- coordination
- swarm
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

# Advanced Coordination - Distributed Agent Management

Sophisticated coordination protocols for large-scale multi-agent systems with fault tolerance and consensus requirements.

## When to Use This Skill

Use when coordinating complex multi-agent workflows with 5+ concurrent agents, implementing fault-tolerant distributed systems, managing dynamic task dependencies across agents, or requiring consensus protocols (RAFT, Byzantine, Gossip).

## Coordination Strategies

### RAFT Consensus
- Leader election among agents
- Replicated log consistency
- Fault tolerance for N/2+1 failures
- Strong consistency guarantees

### Gossip Protocol
- Peer-to-peer agent communication
- Eventually consistent state sharing
- Highly scalable (100+ agents)
- Network partition resilient

### Byzantine Fault Tolerance
- Malicious or faulty agent detection
- 3F+1 redundancy for F failures
- Cryptographic verification
- Critical system integrity

## Process

1. **Analyze coordination requirements**
   - Determine number of agents needed
   - Identify fault tolerance needs
   - Assess consistency requirem

