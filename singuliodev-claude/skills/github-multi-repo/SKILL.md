

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for operations workflows
category: operations
tags:
- general
triggers:
  - "when managing multiple repos"
author: system
---

# GitHub Multi-Repository Coordination Skill

## Overview

Advanced multi-repository coordination system that combines swarm intelligence, package synchronization, and repository architecture optimization. This skill enables organization-wide automation, cross-project collaboration, and scalable repository management.

## Core Capabilities

### 🔄 Multi-Repository Swarm Coordination
Cross-repository AI swarm orchestration for distributed development workflows.

### 📦 Package Synchronization
Intelligent dependency resolution and version alignment across multiple packages.

### 🏗️ Repository Architecture
Structure optimization and template management for scalable projects.

### 🔗 Integration Management
Cross-package integration testing and deployment coordination.

## Quick Start

### Initialize Multi-Repo Coordination
```bash
# Basic swarm initialization
npx claude-flow skill run github-multi-repo init \
  --repos "org/frontend,org/backend,org/shared" \
  --topology hierarchical

# Advanced initialization with synchronization
npx claude-flow skill run github-multi-repo init \
  --repos "org/frontend,org/backend,org/shared" \
  --topology mesh \
  --shared-memory \
  --sync-strategy eventual
```

### Synchronize Packages
```bash
# Synchronize package versions and dependencies
npx claude-flow skill run github-multi-repo sync \
  --packages "claude-code-flow,ruv-swarm" \
  --align-versions \
  --update-docs
```

### Optimize Architecture
```bash
# Analyze and optimize repository structure
npx claude-flow skill run github-multi-repo optimize \
  --analyze-structure \
  --suggest-improvements \
  --create-templates
```

## Features

### 1. Cross-Repository Swarm Orchestration

#### Repository Discovery
```javascript
// Auto-discover related repositories with gh CLI
const REPOS = Bash(`gh repo list my-organization --limit 100 \
  --json name,description,languages,topics \
  --jq '.[] | select(.languages | keys | contains(["TypeScript"]))'`)

// Analyze repository dependencies
const DEPS = Bash(`gh repo list my-organization --json name | \
  jq -r '.[].name' | while read -r repo; do
    gh api repos/my-organization/$repo/contents/package.json \
      --jq '.content' 2>/dev/null | base64 -d | jq '{name, dependencies}'
  done | jq -s '.'`)

// Initialize swarm with discovered repositories
mcp__claude-flow__swarm_init({
  topology: "hierarchical",
  maxAgents: 8,
  metadata: { repos: REPOS, dependencies: DEPS }
})
```

#### Synchronized Operations
```javascript
// Execute synchronized changes across repositories
[Parallel Multi-Repo Operations]:
  // Spawn coordination agents
  Task("Repository Coordinator", "Coordinate changes across all repositories", "coordinator")
  Task("Dependency Analyzer", "Analyze cross-repo dependencies", "analyst")
  Task("Integration Tester", "Validate cross-repo changes", "tester")

  // Get matching repositories
  Bash(`gh repo list org --limit 100 --json name \
    --jq '.[] | select(.name | test("-service$")) | .name' > /tmp/repos.txt`)

  // Execute task across repositories
  Bash(`cat /tmp/repos.txt | while read -r repo; do
    gh repo clone org/$repo /tmp/$repo -- --depth=1
    cd /tmp/$repo

    # Apply changes
    npm update
    npm test

    # Create PR if successful
    if [ $? -eq 0 ]; then
      git checkout -b update-dependencies-$(date +%Y%m%d)
      git add -A
      git commit -m "chore: Update dependencies"
      git push origin HEAD
      gh pr create --title "Update dependencies" --body "Automated update" --label "dependencies"
    fi
  done`)

  // Track all operations
  TodoWrite { todos: [
    { id: "discover", content: "Discover all service repositories", status: "completed" },
    { id: "update", content: "Update dependencies", status: "completed" },
    { id: "test", content: "Run integration tests", status: "in_progress" },
    { id: "pr", content: "Create pull requests", status: "pending" }
  ]}
```

##

