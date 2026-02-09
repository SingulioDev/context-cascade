

---
name: Skill Builder
version: 1.0.0
description: |
  Create new Claude Code Skills with proper YAML frontmatter, progressive disclosure structure, and complete directory organization. Use when you need to build custom skills for specific workflows, gene
category: foundry
tags:
- general
triggers:
  - "when creating skill template"
author: system
---

## Phase 0: Expertise Loading

# Skill Builder

## What This Skill Does

Creates production-ready Claude Code Skills with proper YAML frontmatter, progressive disclosure architecture, and complete file/folder structure. This skill guides you through building skills that Claude can autonomously discover and use across all surfaces (Claude.ai, Claude Code, SDK, API).

## Prerequisites

- Claude Code 2.0+ or Claude.ai with Skills support
- Basic understanding of Markdown and YAML
- Text editor or IDE

## Quick Start

### Creating Your First Skill

```bash
# 1. Create skill directory (MUST be at top level, NOT in subdirectories!)
mkdir -p ~/.claude/skills/my-first-skill

# 2. Create SKILL.md with proper format
cat > ~/.claude/skills/my-first-skill/SKILL.md << 'EOF'
---
name: "My First Skill"
description: "Brief description of what this skill does and when Claude should use it. Maximum 1024 characters."
---

# My First Skill

## What This Skill Does
[Your instructions here]

## Quick Start
[Basic usage]
EOF

# 3. Verify skill is detected
# Restart Claude Code or refresh Claude.ai
```

---

## Complete Specification

### 📋 YAML Frontmatter (REQUIRED)

Every SKILL.md **must** start with YAML frontmatter containing exactly two required fields:

```yaml
---
name: "Skill Name"                    # REQUIRED: Max 64 chars
description: "What this skill does    # REQUIRED: Max 1024 chars
and when Claude should use it."       # Include BOTH what & when
---
```

#### Field Requirements

**`name`** (REQUIRED):
- **Type**: String
- **Max Length**: 64 characters
- **Format**: Human-friendly display name
- **Usage**: Shown in skill lists, UI, and loaded into Claude's system prompt
- **Best Practice**: Use Title Case, be concise and descriptive
- **Examples**:
  - ✅ "API Documentation Generator"
  - ✅ "React Component Builder"
  - ✅ "Database Schema Designer"
  - ❌ "skill-1" (not descriptive)
  - ❌ "This is a very long skill name that exceeds sixty-four characters" (too long)

**`description`** (REQUIRED):
- **Type**: String
- **Max Length**: 1024 characters
- **Format**: Plain text or minimal markdown
- **Content**: MUST include:
  1. **What** the skill does (functionality)
  2. **When** Claude should invoke it (trigger conditions)
- **Usage**: Loaded into Claude's system prompt for autonomous matching
- **Best Practice**: Front-load key trigger words, be specific about use cases
- **Examples**:
  - ✅ "Generate OpenAPI 3.0 documentation from Express.js routes. Use when creating API docs, documenting endpoints, or building API specifications."
  - ✅ "Create React functional components with TypeScript, hooks, and tests. Use when scaffolding new components or converting class components."
  - ❌ "A comprehensive guide to API documentation" (no "when" clause)
  - ❌ "Documentation tool" (too vague)

#### YAML Formatting Rules

```yaml
---
# ✅ CORRECT: Simple string
name: "API Builder"
description: "Creates REST APIs with Express and TypeScript."

# ✅ CORRECT: Multi-line description
name: "Full-Stack Generator"
description: "Generates full-stack applications with React frontend and Node.js backend. Use when starting new projects or scaffolding applications."

# ✅ CORRECT: Special characters quoted
name: "JSON:API Builder"
description: "Creates JSON:API compliant endpoints: pagination, filtering, relationships."

# ❌ WRONG: Missing quotes with special chars
name: API:Builder  # YAML parse error!

# ❌ WRONG: Extra fields (ignored but discouraged)
name: "My Skill"
description: "My description"
version: "1.0.0"       # NOT part of spec
author: "Me"           # NOT part of spec
tags: ["dev", "api"]   # NOT part of spec
---
```

**Critical**: Only `name` and `description` are used by Claude. Additional fields are ignored.

---

### 📂 Directory Structure

#### Minimal Skill (Required)
```
~/.claude/skills/                    # Personal skills location
└── my-skill/

