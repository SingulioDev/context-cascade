

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for operations workflows
category: operations
tags:
- general
triggers:
  - "when releasing software"
author: system
---

# GitHub Release Management Skill

Intelligent release automation and orchestration using AI swarms for comprehensive software releases - from changelog generation to multi-platform deployment with rollback capabilities.

## Quick Start

### Simple Release Flow
```bash
# Plan and create a release
gh release create v2.0.0 \
  --draft \
  --generate-notes \
  --title "Release v2.0.0"

# Orchestrate with swarm
npx claude-flow github release-create \
  --version "2.0.0" \
  --build-artifacts \
  --deploy-targets "npm,docker,github"
```

### Full Automated Release
```bash
# Initialize release swarm
npx claude-flow swarm init --topology hierarchical

# Execute complete release pipeline
npx claude-flow sparc pipeline "Release v2.0.0 with full validation"
```

---

## Core Capabilities

### 1. Release Planning & Version Management
- Semantic version analysis and suggestion
- Breaking change detection from commits
- Release timeline generation
- Multi-package version coordination

### 2. Automated Testing & Validation
- Multi-stage test orchestration
- Cross-platform compatibility testing
- Performance regression detection
- Security vulnerability scanning

### 3. Build & Deployment Orchestration
- Multi-platform build coordination
- Parallel artifact generation
- Progressive deployment strategies
- Automated rollback mechanisms

### 4. Documentation & Communication
- Automated changelog generation
- Release notes with categorization
- Migration guide creation
- Stakeholder notification

---

## Progressive Disclosure: Level 1 - Basic Usage

### Essential Release Commands

#### Create Release Draft
```bash
# Get last release tag
LAST_TAG=$(gh release list --limit 1 --json tagName -q '.[0].tagName')

# Generate changelog from commits
CHANGELOG=$(gh api repos/:owner/:repo/compare/${LAST_TAG}...HEAD \
  --jq '.commits[].commit.message')

# Create draft release
gh release create v2.0.0 \
  --draft \
  --title "Release v2.0.0" \
  --notes "$CHANGELOG" \
  --target main
```

#### Basic Version Bump
```bash
# Update package.json version
npm version patch  # or minor, major

# Push version tag
git push --follow-tags
```

#### Simple Deployment
```bash
# Build and publish npm package
npm run build
npm publish

# Create GitHub release
gh release create $(npm pkg get version) \
  --generate-notes
```

### Quick Integration Example
```javascript
// Simple release preparation in Claude Code
[Single Message]:
  // Update version files
  Edit("package.json", { old: '"version": "1.0.0"', new: '"version": "2.0.0"' })

  // Generate changelog
  Bash("gh api repos/:owner/:repo/compare/v1.0.0...HEAD --jq '.commits[].commit.message' > CHANGELOG.md")

  // Create release branch
  Bash("git checkout -b release/v2.0.0")
  Bash("git add -A && git commit -m 'release: Prepare v2.0.0'")

  // Create PR
  Bash("gh pr create --title 'Release v2.0.0' --body 'Automated release preparation'")
```

---

## Progressive Disclosure: Level 2 - Swarm Coordination

### AI Swarm Release Orchestration

#### Initialize Release Swarm
```javascript
// Set up coordinated release team
[Single Message - Swarm Initialization]:
  mcp__claude-flow__swarm_init {
    topology: "hierarchical",
    maxAgents: 6,
    strategy: "balanced"
  }

  // Spawn specialized agents
  mcp__claude-flow__agent_spawn { type: "coordinator", name: "Release Director" }
  mcp__claude-flow__agent_spawn { type: "coder", name: "Version Manager" }
  mcp__claude-flow__agent_spawn { type: "tester", name: "QA Engineer" }
  mcp__claude-flow__agent_spawn { type: "reviewer", name: "Release Reviewer" }
  mcp__claude-flow__agent_spawn { type: "analyst", name: "Deployment Analyst" }
  mcp__claude-flow__agent_spawn { type: "researcher", name: "Compatibility Checker" }
```

#### Coordinated Release Workflow
```javascript
[Single Message - Full Release Coordination]:
  // Create release branch
  Bash("gh api repos/:owner/:repo/git/refs --metho

