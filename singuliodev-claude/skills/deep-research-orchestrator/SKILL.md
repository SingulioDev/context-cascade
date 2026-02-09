

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

## SKILL-SPECIFIC GUIDANCE

### When to Use This Skill
- Complete research lifecycle from literature review to production (Pipelines A-I)
- Multi-month academic projects requiring 3 quality gates
- NeurIPS/ICML/CVPR submissions with reproducibility requirements
- Research requiring systematic methodology (PRISMA, ACM badging)
- Coordinating 9 pipelines with 15+ specialized agents

### When NOT to Use This Skill
- Quick investigations (<1 week, use researcher skill)
- Single-pipeline workflows (use specific skills)
- Industry projects without academic rigor
- Prototyping without publication goals

### Success Criteria
- All 3 Quality Gates passed (Foundations, Development, Production)
- Minimum 50 papers reviewed (Pipeline A)
- Baseline replicated within +/- 1% (Pipeline D)
- Novel method validated (p < 0.05, d >= 0.5)
- Holistic evaluation across 6+ dimensions
- Reproducibility package tested in fresh environments
- Ethics review completed (data bias audit, fairness metrics)

### Edge Cases & Limitations
- Gate 1 failure: incomplete literature review, missing SOTA benchmarks
- Gate 2 failure: insufficient ablations, statistical power too low
- Gate 3 failure: production infrastructure not validated, monitoring gaps
- Multi-modal data: expand holistic evaluation to modality-specific metrics
- Limited compute: prioritize smaller ablation sets, document constraints

### Critical Guardrails
- NEVER skip Quality Gates (use gate-validation for rigorous checks)
- ALWAYS document full pipeline execution (A through I, no shortcuts)
- NEVER claim production readiness without Gate 3 validation
- ALWAYS coordinate ethics review (ethics-agent) before Gate 1
- NEVER bypass reproducibility requirements (archivist agent mandatory)

### Evidence-Based Validation
- Validate Gate 1: verify 50+ papers, SOTA benchmarks, research gaps
- Validate Gate 2: confirm 5+ ablations, p < 0.05, effect size d >= 0.5
- Validate Gate 3: test production deployment, monitoring, rollback strategies
- Cross-validate pipelines: ensure Pipeline D baseline feeds into Pipeline E
- Verify agent coordination: check memory-mcp state, confirm handoffs logged

---
name: deep-research-orchestrator
description: Meta-orchestrator for complete Deep Research SOP lifecycle managing 3
  phases, 9 pipelines (A-I), and 3 quality gates. Use when starting new research projects,
  conducting systematic ML research, or ensuring rigorous scientific methodology from
  literature review through production deployment. Coordinates all SOP skills and
  agents for end-to-end research execution.
version: 1.1.0
category: research
tags:
- research
- analysis
- planning
author: ruv
---

# Deep Research Orchestrator

Master orchestration skill for the complete Deep Research Standard Operating Procedure (SOP), managing the entire research lifecycle from ideation through production deployment with rigorous quality gates.

Bu arastirma gorevi icin her iddia kaynaklandirilmalidir:

**Kaynak Turleri:**
- **DOGRUDAN (-DI)**: Birincil kaynak, dogrudan inceleme
- **CIKARIM (-mIs)**: Ikincil analiz, cikarim yapildi
- **BILDIRILEN (-mIs)**: Ucuncu taraf bildirimi

**English Application:**
- **[

