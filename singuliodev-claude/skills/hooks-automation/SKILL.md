

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for operations workflows
category: operations
tags:
- general
author: system
---

# Hooks Automation

Intelligent automation system that coordinates, validates, and learns from Claude Code operations through hooks integrated with MCP tools and neural pattern training.

## What This Skill Does

This skill provides a comprehensive hook system that automatically manages development operations, coordinates swarm agents, maintains session state, and continuously learns from coding patterns. It enables automated agent assignment, code formatting, performance tracking, and cross-session memory persistence.

**Key Capabilities:**
- **Pre-Operation Hooks**: Validate, prepare, and auto-assign agents before operations
- **Post-Operation Hooks**: Format, analyze, and train patterns after operations
- **Session Management**: Persist state, restore context, generate summaries
- **Memory Coordination**: Synchronize knowledge across swarm agents
- **Git Integration**: Automated commit hooks with quality verification
- **Neural Training**: Continuous learning from successful patterns
- **MCP Integration**: Seamless coordination with swarm tools

## Prerequisites

**Required:**
- Claude Flow CLI installed (`npm install -g claude-flow@alpha`)
- Claude Code with hooks enabled
- `.claude/settings.json` with hook configurations

**Optional:**
- MCP servers configured (claude-flow, ruv-swarm, flow-nexus)
- Git repository for version control
- Testing framework for quality verification

## Quick Start

### Initialize Hooks System

```bash
# Initialize with default hooks configuration
npx claude-flow init --hooks
```

This creates:
- `.claude/settings.json` with pre-configured hooks
- Hook command documentation in `.claude/commands/hooks/`
- Default hook handlers for common operations

### Basic Hook Usage

```bash
# Pre-task hook (auto-spawns agents)
npx claude-flow hook pre-task --description "Implement authentication"

# Post-edit hook (auto-formats and stores in memory)
npx claude-flow hook post-edit --file "src/auth.js" --memory-key "auth/login"

# Session end hook (saves state and metrics)
npx claude-flow hook session-end --session-id "dev-session" --export-metrics
```

---

## Complete Guide

### Available Hooks

#### Pre-Operation Hooks

Hooks that execute BEFORE operations to prepare and validate:

**pre-edit** - Validate and assign agents before file modifications
```bash
npx claude-flow hook pre-edit [options]

Options:
  --file, -f <path>         File path to be edited
  --auto-assign-agent       Automatically assign best agent (default: true)
  --validate-syntax         Pre-validate syntax before edit
  --check-conflicts         Check for merge conflicts
  --backup-file             Create backup before editing

Examples:
  npx claude-flow hook pre-edit --file "src/auth/login.js"
  npx claude-flow hook pre-edit -f "config/db.js" --validate-syntax
  npx claude-flow hook pre-edit -f "production.env" --backup-file --check-conflicts
```

**Features:**
- Auto agent assignment based on file type
- Syntax validation to prevent broken code
- Conflict detection for concurrent edits
- Automatic file backups for safety

**pre-bash** - Check command safety and resource requirements
```bash
npx claude-flow hook pre-bash --command <cmd>

Options:
  --command, -c <cmd>       Command to validate
  --check-safety            Verify command safety (default: true)
  --estimate-resources      Estimate resource usage
  --require-confirmation    Request user confirmation for risky commands

Examples:
  npx claude-flow hook pre-bash -c "rm -rf /tmp/cache"
  npx claude-flow hook pre-bash --command "docker build ." --estimate-resources
```

**Features:**
- Command safety validation
- Resource requirement estimation
- Destructive command confirmation
- Permission checks

**pre-task** - Auto-spawn agents and prepare for complex tasks
```bash
npx claude-flow hook pre-task [options]

Options:
  --description, -d <text>  Task description for context
  --auto-spawn-agent

