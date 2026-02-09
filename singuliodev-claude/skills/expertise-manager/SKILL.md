

---
name: expertise-manager
version: 2.1.0
description: |
  Manages domain expertise files for Agent Experts-style learning. Handles expertise creation, validation, pre-action loading, and post-build auto-updates. Enables agents to accumulate persistent domain
category: foundry
tags:
- expertise
- learning
- mental-model
- self-improve
- agent-experts
author: system
---

# Expertise Manager

## Phase 0: Expertise Loading

Before managing expertise:

1. **Detect Domain**: Identify the domain for expertise management
2. **Check Expertise**: Look for `.claude/expertise/meta-expertise.yaml`
3. **Load Context**: If exists, load expertise schema and validation rules
4. **Apply Configuration**: Use meta-expertise for management operations

## Purpose

Enable Agent Experts-style learning in the ruv-sparc three-loop system by managing domain expertise files - persistent mental models that agents read BEFORE acting and auto-update AFTER successful builds.

**Key Innovation**: Agents don't just execute and forget. They execute, learn, and reuse their expertise.

## When to Use This Skill

Activate this skill when:
- Creating a new domain expertise file for a codebase area
- Validating existing expertise against current code
- Loading domain context BEFORE implementation tasks
- Auto-updating expertise AFTER successful Loop 2 builds
- Analyzing expertise accuracy and learning history

**DO NOT** use this skill for:
- Quick one-off tasks (expertise overhead not worth it)
- Non-code tasks (expertise is code-focused)
- Tasks outside defined expertise domains

## MCP Requirements

### Memory MCP (Required)

**Purpose**: Persist expertise across sessions, enable cross-agent knowledge sharing.

**Tools Used**:
- `mcp__memory-mcp__memory_store`: Store expertise state and learning history
- `mcp__memory-mcp__vector_search`: Find relevant expertise for current task

**Activation**:
```bash
claude mcp add memory-mcp npx @modelcontextprotocol/server-memory
```

---

## Core Operations

### Operation 1: Create Expertise File

**Command**: `/expertise-create <domain>`

**SOP**:
```javascript
// PHASE 1: DISCOVERY - Scan codebase for domain
Task("Codebase Scanner",
  `Scan codebase to discover ${domain} domain structure:
   1. Find primary source directory (src/${domain}/, lib/${domain}/, etc.)
   2. Find test directory (tests/${domain}/, __tests__/${domain}/, etc.)
   3. Find config files related to ${domain}
   4. Identify key files (index, main exports, types)

   Output: .claude/.artifacts/expertise-discovery-${domain}.json`,
  "code-analyzer")

// PHASE 2: PATTERN EXTRACTION - Understand how domain works
Task("Pattern Extractor",
  `Extract patterns from ${domain} codebase:
   1. Architecture pattern (MVC, Clean Architecture, etc.)
   2. Data flow patterns (how data moves)
   3. Error handling patterns
   4. Validation patterns
   5. Key entities (classes, functions, types)

   Output: .claude/.artifacts/expertise-patterns-${domain}.json`,
  "analyst")

// PHASE 3: RELATIONSHIP MAPPING - Find dependencies
Task("Dependency Mapper",
  `Map relationships for ${domain}:
   1. What domains does ${domain} depend on?
   2. What domains depend on ${domain}?
   3. What external services does ${domain} use?
   4. What are the coupling strengths?

   Output: .claude/.artifacts/expertise-relationships-${domain}.json`,
  "analyst")

// PHASE 4: SYNTHESIS - Create expertise file
Task("Expertise Synthesizer",
  `Synthesize expertise file for ${domain}:
   1. Load discovery, patterns, relationships from artifacts
   2. Generate .claude/expertise/${domain}.yaml
   3. Create initial validation rules
   4. Set metadata (created_by, timestamps)
   5. Store in Memory MCP: expertise/${domain}

   Output: .claude/expertise/${domain}.yaml`,
  "knowledge-manager")
```

---

### Operation 2: Validate Expertise (Pre-Action)

**Command**: `/expertise-validate <domain>`

**Purpose**: Verify expertise file matches current code reality BEFORE acting.

**SOP**:
```javascript
// PHASE 1: LOAD EXPERTISE
const expertise = loadExpertiseFile(domain);
if (!expertise) {
  console.log("No expertise file found. Run /expertise-create first.");
  return;
}

// PHASE 2: RUN VALIDATION RULES
Task("Validation Runner",
  `Validate expertise for ${domain}:

   For each validation_

