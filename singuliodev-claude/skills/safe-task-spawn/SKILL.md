

---
name: SKILL
version: 1.0.0
description: |
  Validated wrapper around Task() calls that enforces agent registry compliance, prevents invalid spawns, and logs all spawn attempts for audit trails
category: orchestration
tags:
- orchestration
- validation
- safety
- task-spawning
- audit
author: system
---

# Safe Task Spawn - Registry-Validated Task Spawning

**Version**: 1.0.0 (Gold Tier)
**Purpose**: Prevent invalid agent spawns through registry validation, skill requirement matching, and comprehensive audit logging

## Overview

Safe Task Spawn is a validated wrapper around Task() calls that acts as a security gate for agent spawning. Instead of directly calling Task() with potentially invalid agent types, this skill validates against the canonical agent registry at `claude-code-plugins/ruv-sparc-three-loop-system/agents/`, ensures spawned agents match skill requirements, and logs all attempts to Memory MCP for audit trails.

**The Problem**:
- Skills spawn agents with Task() using arbitrary agent_type strings
- No validation that agent_type exists in the registry (211 valid agents)
- No verification that spawned agent matches what the skill needs
- No audit trail of spawn attempts (success or failure)
- Silent failures when invalid agents are requested

**The Solution**:
- Validate agent_type against canonical registry before spawning
- Match agent capabilities to skill requirements
- Provide clear error messages with suggestions from registry
- Log all spawn attempts to Memory MCP with WHO/WHEN/PROJECT/WHY tags
- Return validated Task() call or actionable error

## When to Use This Skill

Use **safe-task-spawn** when:
- Any skill needs to spawn agents via Task() calls
- Orchestration workflows coordinate multiple agents
- You need audit trails of agent spawn attempts
- You want to prevent invalid agent spawns at runtime
- Skills require specific agent capabilities/categories
- Debugging why Task() calls are failing silently

**Auto-triggers on keywords**: "spawn agent", "Task()", "delegate to agent", "create task", "agent spawning"

## When NOT to Use This Skill

Skip **safe-task-spawn** when:
- Using hardcoded agents known to be valid (coder, researcher, tester, reviewer)
- Direct Task() call is required for performance (already validated)
- Working in development mode where failures are acceptable
- Agent registry is unavailable (fallback to direct Task())

## Core Principles

### 1. Fail Fast with Actionable Errors
Invalid agent spawns should fail immediately with clear suggestions from the registry, not spawn generic agents or fail silently.

**Example**:
```
ERROR: Agent type 'backend-developer' not found in registry

Did you mean one of these?
- backend-dev (delivery/development/backend/dev-backend-api.md)
- backend-api-enhanced (delivery/development/backend/dev-backend-api-enhanced.md)
- golang-backend-specialist (delivery/development/golang/golang-backend-specialist.md)

Registry path: claude-code-plugins/ruv-sparc-three-loop-system/agents/
```

### 2. Skill-Agent Compatibility Validation
When a skill provides context about required agent capabilities, validate the requested agent matches those requirements.

**Example**:
```javascript
// Skill requires backend API development
skill_context = {
  required_capabilities: ["api-design", "database-integration", "authentication"],
  category: "delivery",
  phase: "development"
}

// Validates agent has required capabilities
safe_task_spawn("backend-dev", "Build REST API...", skill_context)
// ✅ PASS: backend-dev has all required capabilities

safe_task_spawn("frontend-dev", "Build REST API...", skill_context)
// ❌ FAIL: frontend-dev missing "api-design", "database-integration"
```

### 3. Comprehensive Audit Logging
Every spawn attempt (success or failure) is logged to Memory MCP for debugging, compliance, and pattern analysis.

**Example**:
```javascript
// Logged to Memory MCP
{
  "namespace": "orchestration/safe-task-spawn/{project}/{timestamp}",
  "agent_type": "backend-dev",
  "description": "Implement authentication endpoints",
  "status": "success",
  "skill_context": {...},
  "validation_results": {
    "registry_found": true,
    "capabilities_match": true,
    "category_match": tr

