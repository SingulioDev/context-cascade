

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for research workflows
category: research
tags:
- general
author: system
---

name: literature-synthesis
description: Systematic literature review and synthesis for Deep Research SOP Pipeline
  A. Use when starting research projects, conducting SOTA analysis, identifying research
  gaps, or preparing academic papers. Implements PRISMA-compliant systematic review
  methodology with automated search, screening, and synthesis across ArXiv, Semantic
  Scholar, and Papers with Code.
version: 1.0.0
category: research
tags:
- research
- analysis
- planning
author: ruv
---

# Literature Synthesis

Conduct systematic literature reviews following PRISMA guidelines, synthesizing state-of-the-art research to identify gaps and opportunities for Deep Research SOP Phase 1.

## Overview

**Purpose**: Systematic literature review identifying SOTA methods, research gaps, and opportunities

**When to Use**:
- Starting new research projects (Phase 1 of Deep Research SOP)
- Conducting state-of-the-art (SOTA) analysis
- Identifying research gaps and opportunities
- Preparing related work sections for papers
- Validating novelty claims for proposed methods
- Quality Gate 1 requirement

**Quality Gate**: Required for Quality Gate 1 (minimum 50 papers)

**Prerequisites**:
- Research question formulated
- Search databases accessible (ArXiv, Semantic Scholar, Papers with Code)
- Reference management tool available (Zotero, Mendeley, BibTeX)

**Outputs**:
- Literature review document (50-100+ papers)
- SOTA performance benchmarks table
- Research gap analysis
- Hypothesis formulation
- Citation database (BibTeX)
- PRISMA flow diagram (if systematic review)

**Time Estimate**: 1-2 weeks
- Database search: 2-4 hours
- Screening: 1-2 days
- Full-text review: 3-5 days
- Synthesis: 2-3 days
- Writing: 1-2 days

**Agents Used**: researcher

---

## Quick Start

### 1. Define Search Query
```bash
# Store research question in memory
npx claude-flow@alpha memory store \
  --key "sop/literature-review/research-question" \
  --value "How does multi-scale attention improve long-range dependency modeling in vision transformers?"

# Define search terms
search_terms="(multi-scale OR hierarchical) AND (attention OR transformer) AND (vision OR image)"
```

### 2. Database Search
```bash
# Search ArXiv
python scripts/search_arxiv.py \
  --query "$search_terms" \
  --start-date "2020-01-01" \
  --max-results 500 \
  --output literature/arxiv_results.json

# Search Semantic Scholar
python scripts/search_semantic_scholar.py \
  --query "$search_terms" \
  --fields "title,abstract,authors,year,citationCount,venue" \
  --min-citations 10 \
  --output literature/semantic_scholar_results.json

# Search Papers with Code
python scripts/search_papers_with_code.py \
  --task "image-classification" \
  --method "transformer" \
  --output literature/pwc_results.json
```

### 3. Screening and Selection
```bash
# Title/abstract screening
python scripts/screen_papers.py \
  --input literature/*_results.json \
  --inclusion-criteria literature/inclusion_criteria.yaml \
  --output literature/screened_papers.json

# Full-text review
python scripts/full_text_review.py \
  --input literature/screened_papers.json \
  --download-dir literature/pdfs/ \
  --output literature/selected_papers.json
```

### 4. Synthesis
```bash
# Extract SOTA benchmarks
python scripts/extract_sota_benchmarks.py \
  --papers literature/selected_papers.json \
  --datasets "ImageNet,CIFAR-10,CIFAR-100" \
  --output literature/sota_benchmarks.csv

# Identify research gaps
python scripts/identify_gaps.py \
  --papers literature/selected_papers.json \
  --output literature/research_gaps.md
```

### 5. Generate Literature Review
```bash
# Generate review document
python scripts/generate_literature_review.py \
  --papers literature/selected_papers.json \
  --benchmarks literature/sota_benchmarks.csv \
  --gaps literature/research_gaps.md \
  --template templates/literature_review_template.md \
  --output docs/literature

