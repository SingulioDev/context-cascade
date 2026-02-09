

---
name: slash-command-encoder
version: 2.0.0
description: |
  Creates ergonomic slash commands (/command) that provide fast, unambiguous access to micro-skills, cascades, and agents. Enhanced with auto-discovery, intelligent routing, parameter validation, and co
category: orchestration
tags:
- commands
- interface
- ergonomics
- auto-discovery
- composition
triggers:
  - "when creating slash commands"
author: ruv
---

## Orchestration Skill Guidelines

### When to Use This Skill
- **Multi-stage workflows** requiring sequential, parallel, or conditional execution
- **Complex pipelines** coordinating multiple micro-skills or agents
- **Iterative processes** with Codex sandbox testing and auto-fix loops
- **Multi-model routing** requiring intelligent AI selection per stage
- **Production workflows** needing GitHub integration and memory persistence

### When NOT to Use This Skill
- **Single-agent tasks** with no coordination requirements
- **Simple sequential work** that doesn't need stage management
- **Trivial operations** completing in <5 minutes
- **Pure research** without implementation stages

### Success Criteria
- *All stages complete** with 100% success rate
- *Dependency resolution** with no circular dependencies
- *Model routing optimal** for each stage (Gemini/Codex/Claude)
- *Memory persistence** maintained across all stages
- *No orphaned stages** - all stages tracked and completed

### Edge Cases to Handle
- **Stage failure mid-cascade** - Implement retry with exponential backoff
- **Circular dependencies** - Validate DAG structure before execution
- **Model unavailability** - Have fallback model selection per stage
- **Memory overflow** - Implement stage result compression
- **Timeout on long stages** - Configure per-stage timeout limits

### Guardrails (NEVER Violate)
- NEVER: lose stage state** - Persist after each stage completion
- ALWAYS: validate dependencies** - Check DAG acyclic before execution
- ALWAYS: track cascade progress** - Update memory with real-time status
- NEVER: skip error handling** - Every stage needs try/catch with fallback
- ALWAYS: cleanup on failure** - Release resources, clear temp state

### Evidence-Based Validation
- **Verify stage outputs** - Check actual results vs expected schema
- **Validate data flow** - Confirm outputs passed correctly to next stage
- **Check model routing** - Verify correct AI used per stage requirements
- **Measure cascade performance** - Track execution time vs estimates
- **Audit memory usage** - Ensure no memory leaks across stages

# Slash Command Encoder (Enhanced)

## Overview
Creates fast, scriptable `/command` interfaces for micro-skills, cascades, and agents. This enhanced version includes automatic skill discovery, intelligent command generation, parameter validation, multi-model routing, and command chaining patterns.

## Philosophy: Expert Efficiency

**Command Line UX for AI**: Expert users benefit from fast, precise, scriptable interfaces over natural language when performing repeated operations.

**Enhanced Capabilities**:
- **Auto-Discovery**: Scans and catalogs all installed skills automatically
- **Intelligent Routing**: Commands invoke optimal AI/agent for task
- **Parameter Validation**: Type-checked, auto-completed parameters
- **Command Chaining**: Compose commands into pipelines
- **Multi-Model Integration**: Direct access to Gemini/Codex via commands

**Key Principles**:
1. Fast and unambiguous invocation
2. Self-documenting through naming
3. Composable and scriptable
4. Type-safe parameter handling
5. Muscle memory for power users

## When to Create Slash Commands

✅ **Per

