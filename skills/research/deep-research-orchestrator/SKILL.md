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
version: 1.0.0
category: research
tags:
- research
- analysis
- planning
author: ruv
---

# Deep Research Orchestrator

Master orchestration skill for the complete Deep Research Standard Operating Procedure (SOP), managing the entire research lifecycle from ideation through production deployment with rigorous quality gates.

## Overview

**Purpose**: Orchestrate complete research lifecycle following Deep Research SOP methodology

**When to Use**:
- Starting new machine learning research projects
- Conducting systematic scientific research with reproducibility requirements
- Academic paper submission with artifact evaluation
- Production ML deployment requiring ethics, fairness, and safety validation
- Research requiring regulatory compliance (FDA, EU AI Act)
- Multi-month research projects with team coordination

**Quality Gates**: Manages ALL 3 quality gates (Data & Methods, Model & Evaluation, Production & Artifacts)

**Prerequisites**:
- Research question formulated
- Resources allocated (compute, datasets, team)
- Institutional approvals (IRB if needed)
- Memory MCP configured for cross-session persistence

**Outputs**:
- Complete research artifact package
- Published paper with reproducibility artifacts
- Production-ready model with ethics validation
- All quality gate checklists (3 gates APPROVED)
- Comprehensive documentation (datasheets, model cards, method cards)
- DOI-assigned artifacts (Zenodo, HuggingFace)

**Time Estimate**: 2-6 months (full research lifecycle)
- Phase 1 (Foundations): 2-4 weeks
- Phase 2 (Development): 6-12 weeks
- Phase 3 (Production): 2-4 weeks

**Skills Orchestrated**: baseline-replication, method-development, holistic-evaluation, literature-synthesis, reproducibility-audit, deployment-readiness, research-publication, gate-validation

**Agents Used**: ALL 4 P0 agents (data-steward, ethics-agent, archivist, evaluator) + system-architect, coder, tester, reviewer, researcher

---

## Quick Start

### 1. Initialize Research Project
```bash
# Initialize Deep Research SOP project
npx claude-flow@alpha hooks pre-task \
  --description "Deep Research SOP: [Project Name]"

# Create project structure
mkdir -p deep-research-project/{phase1-foundations,phase2-development,phase3-production,gates,docs}

# Store research question in memory
npx claude-flow@alpha memory store \
  --key "sop/project/research-question" \
  --value "How does multi-scale attention improve long-range dependency modeling in vision transformers?"
```

### 2. Run Phase 1 (Foundations) - Quality Gate 1
```bash
# Literature synthesis
claude-code invoke-skill literature-synthesis

# Dataset validation
npx claude-flow@alpha sparc run data-steward "/init-datasheet"

# Baseline replication
claude-code invoke-skill baseline-replication

# Ethics review (initial)
npx claude-flow@alpha sparc run ethics-agent "/assess-risks --component dataset --gate 1"

# Gate 1 validation
claude-code invoke-skill gate-validation --gate 1
```

### 3. Run Phase 2 (Development) - Quality Gate 2
```bash
# Method development
claude-code invoke-skill method-development

# Holistic evaluation
claude-code invoke-skill holistic-evaluation

# Ethics review (model)
npx claude-flow@alpha sparc run ethics-agent "/assess-risks --component model --gate 2"

# Gate 2 validation
claude-code invoke-skill gate-validation --gate 2
```

### 4. Run Phase 3 (Production) - Quality Gate 3
```bash
# Reproducibility audit
claude-code invoke-skill reproducibility-audit

# Deployment readiness
claude-code invoke-skill deployment-readiness

# Archival
npx claude-flow@alpha sparc run archivist "/init-model-card"

# Gate 3 validation
claude-code invoke-skill gate-validation --gate 3
```

### 5. Publication
```bash
# Research publication
claude-code invoke-skill research-publication
```

---

## Detailed Instructions

### PHASE 1: FOUNDATIONS (2-4 weeks)

#### Pipeline A: Literature Synthesis
**Objective**: Systematic literature review identifying SOTA methods, gaps, opportunities

**Execution**:
```bash
claude-code invoke-skill literature-synthesis \
  --query "vision transformers attention mechanisms" \
  --databases "arxiv,semantic-scholar,papers-with-code" \
  --output phase1-foundations/literature/
```

**Deliverables**:
- Literature review document (50-100 papers)
- SOTA performance benchmarks
- Research gap analysis
- Hypothesis formulation

**Agent**: researcher

---

#### Pipeline B: Data & Ethics Foundation
**Objective**: Dataset validation, bias audit, ethics clearance

**Execution**:
```bash
# Data steward: Create datasheet
npx claude-flow@alpha sparc run data-steward \
  "/init-datasheet --dataset ImageNet --output phase1-foundations/datasheet.md"

# Data steward: Bias audit
npx claude-flow@alpha sparc run data-steward \
  "Run bias audit on ImageNet dataset following Gebru et al. 2021"

# Ethics agent: Risk assessment
npx claude-flow@alpha sparc run ethics-agent \
  "/assess-risks --component dataset --gate 1"
```

**Deliverables**:
- Datasheet (Form F-P1)
- Bias audit report
- Ethics review (Gate 1)
- IRB approval (if human subjects)

**Agents**: data-steward, ethics-agent

---

#### Pipeline C: PRISMA Protocol (if systematic review)
**Objective**: PRISMA-compliant systematic literature review

**Execution**:
```bash
npx claude-flow@alpha sparc run researcher \
  "/prisma-init --topic 'attention mechanisms in vision transformers'"
```

**Deliverables**:
- PRISMA protocol document
- Search strategy
- Inclusion/exclusion criteria
- Quality assessment framework

**Agent**: researcher

---

#### Pipeline D: Baseline Replication
**Objective**: Reproduce published baseline with ±1% tolerance

**Execution**:
```bash
claude-code invoke-skill baseline-replication \
  --paper "Attention is All You Need" \
  --dataset ImageNet \
  --tolerance 0.01
```

**Deliverables**:
- Baseline implementation (100% test coverage)
- Statistical comparison (±1% tolerance)
- Reproducibility package (Docker)
- Baseline evaluation report

**Agents**: researcher, data-steward, coder, tester, archivist, evaluator

---

#### Quality Gate 1 Validation
**Objective**: GO/NO-GO decision for method development

**Execution**:
```bash
claude-code invoke-skill gate-validation --gate 1
```

**Gate 1 Requirements**:
- [ ] Literature review complete (≥50 papers)
- [ ] Datasheet complete (Form F-P1, ≥90% filled)
- [ ] Ethics review APPROVED (data-steward + ethics-agent)
- [ ] Baseline replication ±1% tolerance
- [ ] Reproducibility package tested (3/3 runs successful)
- [ ] Dataset validated (bias audit complete)

**Decision**:
- **APPROVED**: Proceed to Phase 2 (Method Development)
- **CONDITIONAL**: Minor fixes required, proceed with restrictions
- **REJECTED**: Critical issues, return to Phase 1

**Agent**: evaluator

---

### PHASE 2: DEVELOPMENT (6-12 weeks)

#### Pipeline D: Method Development (continued)
**Objective**: Develop novel method with ablation studies

**Execution**:
```bash
claude-code invoke-skill method-development \
  --baseline-checkpoint phase1-foundations/baseline/checkpoint.pth \
  --novel-components "multi-scale-attention,prenorm-residual"
```

**Deliverables**:
- Novel method implementation
- Ablation study results (≥5 components)
- Hyperparameter optimization results
- Performance comparison vs. baseline
- Method card (Mitchell et al. 2019 template)

**Agents**: system-architect, coder, tester, reviewer

---

#### Pipeline E: Holistic Evaluation
**Objective**: Comprehensive evaluation across 6+ dimensions

**Execution**:
```bash
claude-code invoke-skill holistic-evaluation \
  --model phase2-development/novel-method/checkpoint.pth \
  --dimensions "accuracy,fairness,robustness,efficiency,interpretability,safety"
```

**Deliverables**:
- Holistic evaluation report
- Fairness metrics (demographic parity, equalized odds)
- Robustness analysis (adversarial, OOD)
- Efficiency profiling (latency, memory, energy)
- Interpretability analysis (SHAP, attention viz)
- Safety evaluation (harmful outputs, bias, privacy)

**Agents**: tester, ethics-agent

---

#### Pipeline F: Ethics & Safety Review
**Objective**: Ethics validation for model deployment

**Execution**:
```bash
npx claude-flow@alpha sparc run ethics-agent \
  "/assess-risks --component model --gate 2"

npx claude-flow@alpha sparc run ethics-agent \
  "/safety-eval --model phase2-development/novel-method/checkpoint.pth"
```

**Deliverables**:
- Ethics review form (F-F1)
- Risk assessment across 6 domains
- Safety evaluation report
- Fairness audit
- Privacy audit (membership inference)

**Agent**: ethics-agent

---

#### Quality Gate 2 Validation
**Objective**: GO/NO-GO decision for production deployment

**Execution**:
```bash
claude-code invoke-skill gate-validation --gate 2
```

**Gate 2 Requirements**:
- [ ] Novel method outperforms baseline (statistically significant)
- [ ] Ablation studies complete (≥5 components)
- [ ] Holistic evaluation complete (6+ dimensions)
- [ ] Ethics review APPROVED (ethics-agent)
- [ ] Method card complete (≥90% filled)
- [ ] Reproducibility tested (3/3 runs successful)

**Decision**:
- **APPROVED**: Proceed to Phase 3 (Production)
- **CONDITIONAL**: Mitigation plan required
- **REJECTED**: Critical issues, return to Phase 2

**Agent**: evaluator

---

### PHASE 3: PRODUCTION (2-4 weeks)

#### Pipeline G: Reproducibility & Archival
**Objective**: Create production-ready reproducibility package

**Execution**:
```bash
# Reproducibility audit
claude-code invoke-skill reproducibility-audit \
  --package phase2-development/novel-method/

# Archival
npx claude-flow@alpha sparc run archivist \
  "/init-model-card --method novel-method --include-metrics"

npx claude-flow@alpha sparc run archivist \
  "Create reproducibility package with Docker, assign DOIs (Zenodo)"
```

**Deliverables**:
- Model card (Form F-G2, ≥90% filled)
- Reproducibility package (code + data + environment)
- DOIs assigned (dataset, model, code)
- Registry URLs (HuggingFace, Zenodo)
- Archive (.tar.gz with manifest)

**Agent**: archivist

---

#### Pipeline H: Deployment Readiness
**Objective**: Production deployment validation

**Execution**:
```bash
claude-code invoke-skill deployment-readiness \
  --model phase3-production/final-checkpoint.pth \
  --environment production
```

**Deliverables**:
- Deployment checklist
- Infrastructure requirements
- Monitoring plan
- Incident response plan
- Rollback strategy
- Performance benchmarks (production environment)

**Agents**: tester, archivist

---

#### Pipeline I: Publication
**Objective**: Academic paper with reproducibility artifacts

**Execution**:
```bash
claude-code invoke-skill research-publication \
  --results phase1-foundations/ phase2-development/ phase3-production/ \
  --venue "NeurIPS" \
  --artifact-track true
```

**Deliverables**:
- Research paper draft
- Reproducibility checklist (NeurIPS, ICML)
- Supplementary materials
- Artifact submission (ACM badges)
- Code release (GitHub)

**Agents**: researcher, archivist

---

#### Quality Gate 3 Validation
**Objective**: Final GO/NO-GO for production deployment and publication

**Execution**:
```bash
claude-code invoke-skill gate-validation --gate 3
```

**Gate 3 Requirements**:
- [ ] Model card complete (≥90% filled)
- [ ] Reproducibility package tested (3/3 runs)
- [ ] DOIs assigned (dataset, model, code)
- [ ] Code public (GitHub release)
- [ ] Ethics review APPROVED (deployment)
- [ ] Deployment plan validated
- [ ] Publication artifacts ready

**Decision**:
- **APPROVED**: Deploy to production, submit publication
- **CONDITIONAL**: Minor documentation fixes
- **REJECTED**: Critical reproducibility or ethics issues

**Agent**: evaluator

---

## Deep Research SOP Architecture

### 3 Phases
```
Phase 1: FOUNDATIONS (2-4 weeks)
├── Literature Synthesis (Pipeline A)
├── Data & Ethics Foundation (Pipeline B)
├── PRISMA Protocol (Pipeline C, optional)
├── Baseline Replication (Pipeline D)
└── Quality Gate 1 → GO/NO-GO

Phase 2: DEVELOPMENT (6-12 weeks)
├── Method Development (Pipeline D continued)
├── Holistic Evaluation (Pipeline E)
├── Ethics & Safety Review (Pipeline F)
└── Quality Gate 2 → GO/NO-GO

Phase 3: PRODUCTION (2-4 weeks)
├── Reproducibility & Archival (Pipeline G)
├── Deployment Readiness (Pipeline H)
├── Publication (Pipeline I)
└── Quality Gate 3 → GO/NO-GO → DEPLOY
```

### 9 Pipelines (A-I)
- **Pipeline A**: Literature Synthesis
- **Pipeline B**: Data & Ethics Foundation
- **Pipeline C**: PRISMA Protocol (systematic reviews)
- **Pipeline D**: Baseline Replication → Method Development
- **Pipeline E**: Holistic Evaluation
- **Pipeline F**: Ethics & Safety Review
- **Pipeline G**: Reproducibility & Archival
- **Pipeline H**: Deployment Readiness
- **Pipeline I**: Publication

### 3 Quality Gates
- **Gate 1**: Data & Methods Validation (end of Phase 1)
- **Gate 2**: Model & Evaluation Validation (end of Phase 2)
- **Gate 3**: Production & Artifacts Validation (end of Phase 3)

---

## Agent Coordination Matrix

| Phase | Pipeline | Lead Agent | Supporting Agents |
|-------|----------|------------|-------------------|
| 1 | A (Literature) | researcher | - |
| 1 | B (Data & Ethics) | data-steward | ethics-agent |
| 1 | C (PRISMA) | researcher | - |
| 1 | D (Baseline) | coder | researcher, tester, archivist |
| 1 | Gate 1 | evaluator | ALL agents review |
| 2 | D (Method Dev) | system-architect | coder, tester, reviewer |
| 2 | E (Holistic Eval) | tester | ethics-agent |
| 2 | F (Ethics) | ethics-agent | - |
| 2 | Gate 2 | evaluator | ethics-agent reviews |
| 3 | G (Archival) | archivist | - |
| 3 | H (Deployment) | tester | archivist |
| 3 | I (Publication) | researcher | archivist |
| 3 | Gate 3 | evaluator | archivist reviews |

---

## Memory Coordination

### Session Persistence
All project state stored in Memory MCP for cross-session coordination:

```bash
# Store phase progress
npx claude-flow@alpha memory store \
  --key "sop/project/phase1/status" \
  --value "COMPLETE" \
  --metadata '{"gate1": "APPROVED", "date": "2025-11-01"}'

# Retrieve previous work
npx claude-flow@alpha memory retrieve \
  --key "sop/project/phase1/baseline-results"

# Agent coordination via memory
npx claude-flow@alpha memory store \
  --key "sop/coordination/ethics-agent/status" \
  --value "Awaiting Gate 2 validation" \
  --metadata '{"blocking": ["evaluator"]}'
```

### Cross-Agent Memory Sharing
```bash
# data-steward stores bias audit results
npx claude-flow@alpha memory store \
  --key "sop/gate1/bias-audit" \
  --value "$(cat phase1-foundations/bias-audit.json)"

# ethics-agent retrieves for risk assessment
npx claude-flow@alpha memory retrieve \
  --key "sop/gate1/bias-audit"
```

---

## Troubleshooting

### Issue: Quality Gate 1 rejected
**Symptoms**: evaluator returns REJECTED status for Gate 1
**Common Causes**:
- Baseline replication outside ±1% tolerance
- Incomplete datasheet (<90% filled)
- Ethics review flagged critical data risks
- Reproducibility tests failed

**Solutions**:
```bash
# Check Gate 1 requirements
claude-code invoke-skill gate-validation --gate 1 --verbose

# Re-run baseline replication with debugging
claude-code invoke-skill baseline-replication --debug

# Complete datasheet gaps
npx claude-flow@alpha sparc run data-steward \
  "/init-datasheet --fill-missing-sections"
```

### Issue: Quality Gate 2 rejected
**Symptoms**: Novel method fails holistic evaluation or ethics review
**Solutions**:
```bash
# Review holistic evaluation failures
claude-code invoke-skill holistic-evaluation --dimensions "fairness,safety" --verbose

# Address ethics concerns
npx claude-flow@alpha sparc run ethics-agent \
  "/assess-risks --component model --gate 2 --mitigation-plan"

# Re-run method development with improvements
claude-code invoke-skill method-development --incorporate-feedback
```

### Issue: Quality Gate 3 rejected
**Symptoms**: Reproducibility package fails or deployment validation issues
**Solutions**:
```bash
# Audit reproducibility package
claude-code invoke-skill reproducibility-audit --strict

# Fix deployment issues
claude-code invoke-skill deployment-readiness --fix-issues

# Complete model card
npx claude-flow@alpha sparc run archivist \
  "/init-model-card --complete-missing-sections"
```

### Issue: Phase transitions blocked
**Symptoms**: Cannot proceed to next phase due to pending validations
**Solutions**:
```bash
# Check all gate requirements
npx claude-flow@alpha memory retrieve --key "sop/gates/status"

# Identify blocking agents
npx claude-flow@alpha memory retrieve --key "sop/coordination/*/status"

# Resolve blocking tasks
# (Address specific agent requirements)
```

---

## Integration with Deep Research SOP

### Comprehensive Workflow
This orchestrator implements the complete Deep Research SOP as specified in:
- Gap analysis document (identifying missing components)
- 4 P0 commands (/init-datasheet, /prisma-init, /assess-risks, /init-model-card)
- 4 P0 agents (data-steward, ethics-agent, archivist, evaluator)
- 8 GraphViz process diagrams

### Quality Assurance
- **3 Quality Gates** ensure rigor at each phase transition
- **9 Pipelines** provide systematic coverage of research lifecycle
- **4 P0 Agents** enforce standards (data, ethics, archival, evaluation)
- **Memory MCP** enables cross-session coordination and reproducibility

---

## Related Skills and Commands

### Phase 1 Skills
- `literature-synthesis` - Systematic literature review
- `baseline-replication` - Reproduce published baselines

### Phase 2 Skills
- `method-development` - Develop novel methods
- `holistic-evaluation` - Comprehensive evaluation

### Phase 3 Skills
- `reproducibility-audit` - Audit reproducibility
- `deployment-readiness` - Production deployment validation
- `research-publication` - Academic publication

### Cross-Phase Skills
- `gate-validation` - Quality gate validation (all 3 gates)

### Related Commands
- `/init-datasheet` - Create dataset documentation
- `/prisma-init` - Initialize systematic review
- `/assess-risks` - Ethics and safety assessment
- `/init-model-card` - Create model card
- `/validate-gate-{1,2,3}` - Gate validation

---

## References

### Deep Research SOP Documentation
- Deep Research SOP Gap Analysis (docs/deep-research-sop-gap-analysis.md)
- 8 GraphViz Process Diagrams (docs/12fa/graphviz/)
- P0 Commands Specification (.claude/commands/research/)
- P0 Agents Specification (agents/research/)

### Academic Standards
- Gebru et al. (2021): Datasheets for Datasets
- Mitchell et al. (2019): Model Cards for Model Reporting
- Page et al. (2021): PRISMA 2020 Statement
- ACM Artifact Evaluation Badging
- NeurIPS Reproducibility Checklist

### Ethics Frameworks
- IEEE 7010: Well-being Metrics for Ethical AI
- NIST AI Risk Management Framework
- EU AI Act Compliance
- FDA Guidance on AI/ML Medical Devices

---

## Appendix

### Example Deep Research SOP Timeline

```
Week 1-2: Phase 1 Start
  - Literature synthesis (50+ papers)
  - Datasheet creation
  - Bias audit

Week 3-4: Phase 1 Complete
  - Baseline replication
  - Ethics review (Gate 1)
  - Gate 1 validation → APPROVED

Week 5-8: Phase 2 Development
  - Novel method implementation
  - Ablation studies
  - Hyperparameter optimization

Week 9-12: Phase 2 Evaluation
  - Holistic evaluation (6 dimensions)
  - Ethics review (Gate 2)
  - Gate 2 validation → APPROVED

Week 13-14: Phase 3 Archival
  - Reproducibility package creation
  - Model card, DOI assignment
  - Registry publishing

Week 15-16: Phase 3 Deployment & Publication
  - Deployment readiness validation
  - Paper writing
  - Gate 3 validation → APPROVED → DEPLOY

Total: 16 weeks (4 months) for complete research lifecycle
```

### Quality Gate Decision Matrix

| Gate | APPROVED | CONDITIONAL | REJECTED |
|------|----------|-------------|----------|
| Gate 1 | All requirements met, proceed to Phase 2 | Minor datasheet gaps, proceed with restrictions | Baseline >±1% or critical ethics issues |
| Gate 2 | All requirements met, proceed to Phase 3 | Mitigation plan for fairness/robustness gaps | Performance regression or critical safety risks |
| Gate 3 | All requirements met, DEPLOY to production | Minor documentation fixes required | Reproducibility failures or ethics violations |
---

## Core Principles

Deep Research Orchestrator operates on 3 fundamental principles:

### Principle 1: Systematic Rigor Over Expedience
Research quality cannot be compromised for speed. Every phase and pipeline follows evidence-based methodology (PRISMA, ACM badging, NeurIPS reproducibility standards) ensuring publishable results.

In practice:
- Quality Gates enforce GO/NO-GO decisions with statistical validation
- Minimum thresholds prevent premature progression (50+ papers, ±1% baseline tolerance, 3/3 reproducibility)
- Ethics reviews (data-steward + ethics-agent) occur at every gate, not just final submission

### Principle 2: Reproducibility as First-Class Requirement
Reproducibility is not an afterthought but a continuous validation requirement from Phase 1 through Phase 3. Every artifact must be independently verifiable.

In practice:
- Baseline replication (±1% tolerance) validates computational environment before novel method development
- Reproducibility packages tested in fresh Docker containers with zero cached dependencies
- All code, data, hyperparameters archived with permanent DOIs (Zenodo, HuggingFace) before Gate 3

### Principle 3: Multi-Agent Coordination for Comprehensive Coverage
No single agent possesses complete expertise. Deep Research requires 9+ agents working in coordinated phases to ensure data integrity, methodological soundness, and production readiness.

In practice:
- data-steward validates datasets and bias before researcher conducts literature review
- ethics-agent assesses risks at Gates 1, 2, 3 with independent reviews
- archivist creates model cards and reproducibility packages while evaluator validates gate requirements

---

## Common Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| **Gate Skipping** | Proceeding to Phase 2 without Gate 1 APPROVED leads to invalid foundations (incomplete literature review, unvalidated datasets, failed baseline replication) | NEVER bypass gate-validation skill. If Gate 1 returns CONDITIONAL/REJECTED, address deficiencies before Phase 2. Use gate-validation --verbose to identify specific gaps |
| **Single-Run Validation** | Testing reproducibility once (1/1 runs) masks non-deterministic behavior, framework bugs, or environment-specific issues | ALWAYS run 3+ reproductions in fresh Docker containers. Calculate variance (must be near-zero). Use different random seeds to validate determinism |
| **Ethics Review as Checkbox** | Treating ethics-agent as formality rather than substantive risk assessment leads to Gate 2/3 rejection for bias, fairness, or safety violations | Integrate ethics-agent at EVERY gate (data bias in Gate 1, model fairness in Gate 2, deployment safety in Gate 3). Address flagged risks with mitigation plans, not dismissals |

---

## Conclusion

The Deep Research Orchestrator is the definitive workflow for conducting rigorous, reproducible, and ethically sound machine learning research from ideation to production deployment. By enforcing 3 quality gates across 9 pipelines (A-I), this orchestrator ensures that research meets the standards required for top-tier academic publication (NeurIPS, ICML, CVPR) and production deployment.

This skill is essential when research quality cannot be compromised: systematic literature reviews with 50+ papers, baseline replication within ±1% tolerance, holistic evaluation across 6+ dimensions (accuracy, fairness, robustness, efficiency, interpretability, safety), and reproducibility packages tested in independent environments. The 2-6 month timeline reflects the complexity of comprehensive research, but the result is publication-ready artifacts with ACM Artifact Evaluation badges and permanent DOIs.

Use this orchestrator when starting new ML research projects, preparing academic submissions with artifact tracks, or ensuring regulatory compliance (FDA, EU AI Act). The coordinated multi-agent approach (researcher, data-steward, ethics-agent, archivist, coder, tester, evaluator) ensures no dimension is overlooked, and the quality gate system prevents premature progression. The investment in systematic methodology yields research that not only passes peer review but advances the state of the art with confidence in its validity and reproducibility.
