

---
name: academic-reading-workflow
version: 2.0
description: |
  Systematic reading methodology for academic papers and complex texts implementing Blue's (OSP) 3-phase approach. Use when reading papers/books that require deep understanding, searchable annotation sy
category: research
tags:
- general
author: system
---

# Academic Reading Workflow

## Purpose

Execute systematic reading of academic papers, books, and complex texts using Blue's (OSP) 3-phase methodology: summary-first reading, active annotation with searchable keyword system, and evidence-based writing.

## When to Use This Skill

**Use this skill when:**
- ✅ Reading academic papers or dense books requiring deep understanding
- ✅ Building searchable knowledge base from readings
- ✅ Need to retain and find information later ("command-F in real life")
- ✅ Preparing to write evidence-based essays/analyses with citations

**Do NOT use for:**
- ❌ Quick skimming (<30 min)
- ❌ Casual reading without note-taking
- ❌ Fiction/entertainment reading
- ❌ Already familiar material (just creating citations)

**Decision Tree**: See `references/decision-tree.md`

## Quick Reference

| Step | Agent | Deliverable | Duration | Quality Gate |
|------|-------|-------------|----------|--------------|
| 0 | researcher | Master keyword list (if multi-source project) | 5-10 min | Keyword vocabulary defined |
| 1 | researcher | Reading roadmap with critical sections identified | 15-30 min | Clear thesis + sections |
| 2 | researcher | 20-50 searchable annotations with keyword tags | 1-4 hours | ≥20 notes, ≥5 keywords |
| 3 | analyst | Validated annotation set + keyword index | 15-30 min | Searchable, <30% quote-paraphrases |

**Optional**: Use `evidence-based-writing` skill separately when ready to write (not part of this workflow)

---

## Agent Coordination Protocol

### Sequential Execution
Each step passes deliverables to next step. Do NOT proceed if Quality Gate fails.

### Agent Roles
- **researcher**: Roadmap creation, reading, annotation (Steps 0, 1, 2)
- **analyst**: Validation, quality checks, keyword standardization (Step 3)

### Annotation Storage Format
All annotations stored as **Markdown with YAML frontmatter**:

```yaml
---
source: "[Title] - [Author] ([Year])"
page: [number]
keywords: [keyword1, keyword2, keyword3]
date_annotated: [YYYY-MM-DD]
project: [research-topic-slug]
annotation_id: [unique-id]
---

**Summary**: [Your paraphrase in own words]

**Quote** (if applicable): "[Exact text]" (p. [X])

**Why This Matters**: [Connection to research question]

**Links**: See also [Page Y], Conflicts with [Source B]
```

### Memory MCP Tags
Store with: `WHO=[agent]`, `WHEN=[timestamp]`, `PROJECT=[topic]`, `WHY=annotation`, `SOURCE=[title]`, `PAGE=[number]`

---

## Blue's Core Principles

This workflow embeds Blue's (OSP) methodology:

| Principle | Implementation |
|-----------|---------------|
| **"Read the Roadmap Before You Get Lost"** | Step 1: Summary-first, create plan BEFORE deep reading |
| **"Annotation is Command-F in Real Life"** | Step 2: Keyword tagging for searchable notes |
| **"Paraphrase > Highlighting"** | Step 2: Force genuine paraphrase, not quote-rewording |
| **"Write Like You Speak"** | (Evidence-based-writing skill): Natural draft, polish later |
| **"Thesis Comes LAST"** | (Evidence-based-writing skill): Let thesis emerge from notes |
| **"Every Claim Needs Source"** | (Evidence-based-writing skill): All assertions cited with pages |

See `references/blue-methodology.md` for full explanation.

---

## Step-by-Step Workflow

### STEP 0: Initialize Master Keyword List (Multi-Source Projects)
**Agent**: researcher
**Goal**: Define consistent keyword vocabulary across all sources in project

**When to Use**:
- ✅ Reading 3+ sources for same research project
- ✅ Building cross-source knowledge base
- ❌ Skip if reading single source

**Procedure**:
1. List main topics/concepts in your research project
2. Define standard keywords for each:
   - Use domain-standard terms when possible
   - Be specific (#methodology, not #method)
   - Use consistent formatting (#snake-case)
3. Create master keyword list:

```markdown
# MASTER KEYWORD LIST: [Project Name]

## Core Concepts
- #[concept-1] - Defini

