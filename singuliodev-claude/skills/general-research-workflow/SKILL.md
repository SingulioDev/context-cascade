

---
name: general-research-workflow
version: 3.0
description: |
  Systematic 6-phase research methodology for history, mythology, and literature implementing Red's (OSP) evidence-based approach. Use when researching topics outside academic ML scope that require prim
category: research
tags:
- general
author: system
---

# General Research Workflow

## Purpose

Execute systematic general-purpose research across history, mythology, literature, and non-ML domains using Red's (OSP) 6-phase evidence-based methodology with rigorous source evaluation and synthesis.

## When to Use This Skill

**Use this skill when:**
- ✅ Researching historical events, mythological topics, or literary analysis
- ✅ Need to evaluate primary vs secondary sources
- ✅ Building evidence-based arguments with citations
- ✅ Topic requires source credibility analysis
- ✅ Have 6+ hours for thorough research

**Do NOT use for:**
- ❌ Academic ML research (use `literature-synthesis` instead)
- ❌ Quick fact-checking (<30 min)
- ❌ Literature reviews for academic papers (use `deep-research-orchestrator`)

**Decision Tree**: See `references/decision-tree.md`

## Quick Reference

| Step | Agent | Deliverable | Duration | Quality Gate |
|------|-------|-------------|----------|--------------|
| 0 | researcher | Wikipedia verification OR fallback plan | 5-10 min | ≥1 viable starting source |
| 1 | researcher | 10+ citations from Wikipedia references | 15-30 min | ≥10 citations, ≥3 categories |
| 2 | researcher | 20+ sources with metadata + relevance scores | 1-2 hours | ≥20 sources, ≥50% accessible |
| 3 | analyst | Classified sources with credibility/bias/priority scores | 30-60 min | ≥5 primaries, ≥80% credibility ≥3 |
| 4 | researcher | Context profiles for 10+ sources, 3+ time periods | 1-2 hours | ≥10 contextualized, ≥3 periods |
| 5 | researcher | 50+ notes, 20+ quotes with pages, 5+ cross-links | 2-3 hours | All quotas met |
| 6 | coordinator | Evidence-based thesis + final report | 1-2 hours | ≥5 sources support thesis, validated |

## Agent Coordination Protocol

### Sequential Execution
Each step passes deliverables to the next step. Do NOT proceed if Quality Gate fails.

### Agent Roles
- **researcher**: Discovery, analysis, note-taking (Steps 0, 1, 2, 4, 5, Phase A-B of Step 6)
- **analyst**: Validation, classification, quality checks (Step 3, Phase C of Step 6)
- **coordinator**: Synthesis orchestration (Phase D of Step 6)

### Memory MCP Tags
ALL stored data must include: `WHO=[agent]`, `WHEN=[timestamp]`, `PROJECT=[research-topic]`, `WHY=[intent]`

## Glossary

See `references/glossary.md` for complete definitions:
- **Primary Source**: Original documents/eyewitness accounts from the time period
- **Secondary Source**: Analysis/interpretation created after the events
- **Credibility Score (1-5)**: Reliability based on expertise, venue, citations
- **Bias Risk Score (1-5)**: Likelihood of systematic distortion
- **WorldCat**: worldcat.org - Global library catalog
- **Google Scholar**: scholar.google.com - Academic publication search

---

## Step-by-Step Workflow

### STEP 0: Pre-Flight Check (Gate 0)
**Agent**: researcher
**Goal**: Verify Wikipedia article exists OR establish fallback plan

**Procedure**:
1. Search Wikipedia for research topic
2. **IF article exists**: ✅ Proceed to Step 1
3. **IF NO article**:
   - Try related/broader topics, alternative spellings
   - **FALLBACK**: Start with Google Scholar search instead
   - Extract ≥10 citations from Scholar results
   - Document: "No Wikipedia article, started with Google Scholar"
4. Check language accessibility:
   - Flag non-English sources for translation assessment
   - Document language limitation if proceeding without translations

**Deliverable**: Confirmation of viable starting point

**Quality Gate 0**: STOP if no viable sources. Escalate to user for topic clarification.

---

### STEP 1: Wikipedia Mining
**Agent**: researcher
**Goal**: Extract reference trail from Wikipedia

**Procedure**:
1. Read Wikipedia article for overview
2. Navigate to "References" section
3. Extract ALL citations with metadata:
   - ✅ Author(s) [REQUIRED]
   - ✅ Title [REQUIRED]
   - ✅ Year [REQUIRED]
   - ⚠️ ISBN/DOI [OPTIONAL]
4. Extract "Further Read

