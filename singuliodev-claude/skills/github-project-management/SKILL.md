

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for operations workflows
category: operations
tags:
- general
triggers:
  - "when managing github projects"
author: system
---

# GitHub Project Management

## Overview

A comprehensive skill for managing GitHub projects using AI swarm coordination. This skill combines intelligent issue management, automated project board synchronization, and swarm-based coordination for efficient project delivery.

## Quick Start

### Basic Issue Creation with Swarm Coordination

```bash
# Create a coordinated issue
gh issue create \
  --title "Feature: Advanced Authentication" \
  --body "Implement OAuth2 with social login..." \
  --label "enhancement,swarm-ready"

# Initialize swarm for issue
npx claude-flow@alpha hooks pre-task --description "Feature implementation"
```

### Project Board Quick Setup

```bash
# Get project ID
PROJECT_ID=$(gh project list --owner @me --format json | \
  jq -r '.projects[0].id')

# Initialize board sync
npx ruv-swarm github board-init \
  --project-id "$PROJECT_ID" \
  --sync-mode "bidirectional"
```

---

## Core Capabilities

### 1. Issue Management & Triage

<details>
<summary><strong>Automated Issue Triage</strong></summary>

#### Auto-Label Based on Content

```javascript
// .github/swarm-labels.json
{
  "rules": [

