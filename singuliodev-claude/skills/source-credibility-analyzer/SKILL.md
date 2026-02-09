

---
name: source-credibility-analyzer
version: 2.0
description: |
  Standalone tool for automated source evaluation using program-of-thought scoring rubrics. Outputs credibility (1-5), bias (1-5), and priority (1-5) scores with transparent explanations. Use when evalu
category: research
tags:
- general
author: system
---

# Source Credibility Analyzer

## Purpose

Automate evaluation of research sources using transparent program-of-thought rubrics. Outputs structured JSON with credibility, bias, and priority scores (1-5) plus explanations showing calculation logic. Can be used as standalone tool OR integrated into general-research-workflow Step 3.

## When to Use This Tool

**Use this tool when:**
- ✅ Evaluating research sources for academic projects
- ✅ Automating source classification (general-research-workflow Step 3)
- ✅ Scoring large batches of sources consistently
- ✅ Getting objective second opinion on source quality

**Do NOT use for:**
- ❌ Entertainment content (movies, novels) - not designed for this
- ❌ Source quality already obvious (Nature paper = high, random blog = low)
- ❌ Unique/irreplaceable source (only source on obscure topic) - read anyway

**Decision Tree**: If manual source evaluation takes >10 min → use this tool (saves 15-45 min per source)

## Quick Reference

| Step | Objective | Deliverable | Duration | Quality Gate |
|------|-----------|-------------|----------|--------------|
| 0 | Validate inputs | Confirmed metadata | 30 sec | Required fields present |
| 0.5 | Classify source type | Source category | 1 min | Type assigned |
| 1 | Calculate credibility | Score 1-5 + explanation | 2-5 min | Score justified |
| 2 | Calculate bias | Score 1-5 + explanation | 2-5 min | Score justified |
| 3 | Calculate priority | Score 1-5 + explanation | 1-3 min | Score justified |
| 4 | Resolve conflicts | Final recommendation | 1 min | Logic correct |
| 5 | Generate output | JSON + storage | 1 min | Complete + stored |

---

## Agent Coordination Protocol

### Single Agent Execution
- **Agent**: analyst
- **Role**: Evaluate source using program-of-thought rubrics
- **Workflow**: Sequential steps 0 → 0.5 → 1 → 2 → 3 → 4 → 5

### Input Format
```json
{
  "title": "[Required]",
  "author": "[Required]",
  "year": [Required, 1500-2025],
  "venue": "[Required]",
  "type": "[Required]",
  "citations": [Optional],
  "doi": "[Optional]",
  "url": "[Optional]",
  "institution": "[Optional]",
  "credentials": "[Optional]"
}
```

### Output Format
```json
{
  "source": { ... },
  "scores": {
    "credibility": {"score": [1-5], "explanation": "..."},
    "bias": {"score": [1-5], "explanation": "..."},
    "priority": {"score": [1-5], "explanation": "..."}
  },
  "recommendation": {
    "action": "[READ_FIRST | READ_LATER | VERIFY_CLAIMS | SKIP]",
    "reason": "...",
    "conflicts": "..."
  },
  "metadata": { ... }
}
```

### Memory MCP Tags
Store with: `WHO=analyst`, `WHEN=[timestamp]`, `PROJECT=[topic]`, `WHY=source-scoring`, `CREDIBILITY=[score]`, `BIAS=[score]`, `PRIORITY=[score]`, `RECOMMENDATION=[action]`

---

## Step-by-Step Workflow

### STEP 0: Validate Input Metadata
**Agent**: analyst
**Objective**: Ensure required metadata is present and valid

**Procedure**:
1. Check for ✅ **required** fields:
   - `title` (string, non-empty)
   - `author` (string, non-empty)
   - `year` (integer, 1500-2025)
   - `venue` (string, non-empty)
   - `type` (string, non-empty)

2. Note ⚠️ **optional** fields if present:
   - `citations` (improves credibility scoring)
   - `doi` (improves credibility scoring)
   - `institution` (improves credibility scoring)
   - `credentials` (improves credibility scoring)
   - `url` (for reference)

3. Validate data types and ranges:
   - Year must be integer 1500-2025
   - All required strings non-empty

4. If validation fails → Return error with missing/invalid field name

**Deliverable**: Validated metadata object

**Quality Gate 0**:
- **GO**: All required fields present, year valid (1500-2025)
- **NO-GO**: Missing/invalid field → Return error to user

---

### STEP 0.5: Classify Source Type (Edge Case Handling)
**Agent**: analyst
**Objective**: Assign source to appropriate category for rubric baseline

**Edge Case Decision Tree**:

