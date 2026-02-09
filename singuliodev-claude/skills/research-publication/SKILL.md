

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

name: research-publication
description: Academic publication preparation for Deep Research SOP Pipeline I including
  paper writing, reproducibility artifacts, and venue submission. Use when preparing
  research for publication after Gate 3 APPROVED, submitting to conferences (NeurIPS,
  ICML, CVPR), or creating ACM artifact submissions. Ensures reproducibility checklists
  complete, supplementary materials prepared, and all artifacts publicly accessible.
version: 1.0.0
category: research
tags:
- research
- analysis
- planning
author: ruv
---

# Research Publication

Prepare research for academic publication with comprehensive reproducibility artifacts, ensuring compliance with venue requirements and ACM Artifact Evaluation standards.

## Overview

**Purpose**: Prepare and submit research for academic publication

**When to Use**:
- Quality Gate 3 APPROVED (production-ready model with artifacts)
- Submitting to academic venues (NeurIPS, ICML, CVPR, ACL, etc.)
- Creating ACM artifact submissions
- Publishing reproducibility artifacts
- Preparing supplementary materials

**Quality Gate**: Follows Gate 3 APPROVED status

**Prerequisites**:
- Research complete (Phases 1-3 of Deep Research SOP)
- Quality Gate 3 APPROVED
- Reproducibility package validated
- All artifacts archived and public

**Outputs**:
- Research paper draft (LaTeX)
- Reproducibility checklist (NeurIPS, ICML, etc.)
- Supplementary materials
- ACM artifact submission package
- Code release (GitHub with Zenodo DOI)
- Presentation slides

**Time Estimate**: 2-4 weeks
- Paper writing: 1-2 weeks
- Reproducibility checklist: 1-2 days
- Supplementary materials: 2-3 days
- Artifact submission: 2-3 days
- Revisions: 3-5 days

**Agents Used**: researcher, archivist

---

## Quick Start

### 1. Initialize Publication Project
```bash
# Create publication structure
mkdir -p publication/{paper,supplementary,code,slides}

# Initialize LaTeX project
cd publication/paper/
git init
cp ~/templates/neurips_2024.tex main.tex
```

### 2. Generate Paper Sections
```bash
# Auto-generate sections from research artifacts
python scripts/generate_paper_sections.py \
  --literature-review ../phase1-foundations/literature_review.md \
  --method-description ../phase2-development/method_card.md \
  --evaluation-results ../phase2-development/holistic_evaluation/report.md \
  --output paper/auto_generated/
```

### 3. Reproducibility Checklist
```bash
# Generate NeurIPS reproducibility checklist
python scripts/generate_reproducibility_checklist.py \
  --venue neurips \
  --artifacts ../phase3-production/ \
  --output paper/reproducibility_checklist.pdf
```

### 4. Supplementary Materials
```bash
# Package supplementary materials
python scripts/package_supplementary.py \
  --ablation-results ../phase2-development/ablations/ \
  --hyperparameters ../phase2-development/hparams/ \
  --additional-experiments ../phase2-development/experiments/ \
  --output supplementary/supplementary.pdf
```

### 5. Artifact Submission
```bash
# Prepare ACM artifact submission
python scripts/prepare_acm_artifact.py \
  --reproducibility-package ../phase3-production/reproducibility-package/ \
  --badge-level "Reproduced+Reusable" \
  --output publication/acm_artifact/
```

---

## Detailed Instructions

### Phase 1: Paper Writing (1-2 weeks)

**Objective**: Write comprehensive research paper

**Steps**:

#### 1.1 Paper Structure (Standard ML Conference)
```latex
% main.tex

\documentclass{article}
\usepackage{neurips_2024}

\title{Multi-Scale Attention for Improved Vision Transformers}

\author{
  Your Name \\
  Your Institution \\
  \texttt{email@institution.edu}
}

\begin{document}

\maketitle

\begin{abstract}
% 150-200 words summarizing:
% - Problem and motivation
% - Proposed method
% - Key results
% - Contributions
\end{abstract}

\section{Introduction}
% - Motivation (why is this problem important?)
% - Limitations of existing work

