

---
name: hive-mind-advanced
version: 1.0.0
description: |
  Advanced Hive Mind collective intelligence system for queen-led multi-agent coordination with consensus mechanisms and persistent memory
category: coordination
tags:
- hive-mind
- swarm
- queen-worker
- consensus
- collective-intelligence
author: Claude Flow Team
---

## Orchestration Skill Guidelines

### When to Use This Skill
- **Queen-led coordination** requiring hierarchical multi-agent control
- **Consensus-driven decisions** needing Byzantine fault tolerance
- **Collective intelligence** tasks benefiting from shared memory
- **Strategic planning** with tactical execution delegation
- **Large-scale swarms** with 10+ specialized worker agents

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination requirements
- **Simple workflows** without consensus needs
- **Flat topologies** where hierarchy adds no value
- **Ephemeral tasks** not needing collective memory

### Success Criteria
- *Queen successfully coordinates** all worker agents
- *Consensus achieved** using configured algorithm (majority/weighted/Byzantine)
- *Collective memory shared** across all agents with <10ms access time
- *All workers complete tasks** with 100% assignment success
- *Session state persisted** with checkpoint recovery capability

### Edge Cases to Handle
- **Queen failure** - Implement queen failover and re-election
- **Worker unresponsiveness** - Timeout detection and task reassignment
- **Consensus deadlock** - Fallback to weighted or majority consensus
- **Memory corruption** - Validate memory integrity with checksums
- **Session crash** - Resume from last checkpoint with full state recovery

### Guardrails (NEVER Violate)
- NEVER: lose collective memory** - Persist to SQLite with WAL mode
- ALWAYS: validate queen health** - Monitor queen heartbeat continuously
- ALWAYS: track worker states** - Real-time worker status in shared memory
- NEVER: skip consensus** - Critical decisions require configured consensus
- ALWAYS: checkpoint sessions** - Save state at key milestones

### Evidence-Based Validation
- **Verify queen coordination** - Check queen issued commands to all workers
- **Validate consensus results** - Confirm vote counts meet algorithm threshold
- **Check memory consistency** - Query collective memory, verify no conflicts
- **Measure worker efficiency** - Calculate task completion rate per worker
- **Audit session recovery** - Test checkpoint restore, verify full state

# Hive Mind Advanced Skill

Master the advanced Hive Mind collective intelligence system for sophisticated multi-agent coordination using queen-led architecture, Byzantine consensus, and collective memory.

## Overview

The Hive Mind system represents the pinnacle of multi-agent coordination in Claude Flow, implementing a queen-led hierarchical architecture where a strategic queen coordinator directs specialized worker agents through collective decision-making and shared memory.

## Core Concepts

### Architecture Patterns

**Queen-Led Coordination**
- Strategic queen agents orchestrate high-level objectives
- Tactical queens manage mid-level execution
- Adaptive queens dynamically adjust strategies based on performance

**Worker Specialization**
- Researcher agents: Analysis and investigation
- Coder agents: Implementation and development
- Analyst agents: Data processing and metrics
- Tester agents: Quality assurance and validation
- Architect agents: System design and planning
- Reviewer agents: Code review and improvement
- Optimi

