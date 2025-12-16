#!/bin/bash

# Apply SKILL-SPECIFIC prompt improvements to ALL research SKILL.md files
# Inserts after the CRITICAL RESEARCH GUARDRAILS section (after line 40)

set -e

RESEARCH_DIR="C:/Users/17175/claude-code-plugins/ruv-sparc-three-loop-system/skills/research"
BACKUP_DIR="${RESEARCH_DIR}/.backup-$(date +%Y%m%d-%H%M%S)"
PROCESSED_COUNT=0

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "=== RESEARCH SKILL IMPROVEMENT APPLICATOR ==="
echo "Backup directory: $BACKUP_DIR"
echo ""

# Function to insert skill-specific improvements
apply_improvements() {
  local file="$1"
  local skill_name="$2"
  local when_to_use="$3"
  local when_not_to_use="$4"
  local success_criteria="$5"
  local edge_cases="$6"
  local guardrails="$7"
  local evidence_based="$8"

  # Backup original
  local backup_path="${BACKUP_DIR}/$(basename $(dirname $file))-SKILL.md"
  cp "$file" "$backup_path"

  # Create improvement section
  cat > /tmp/skill_improvement_$$.txt <<EOF

## SKILL-SPECIFIC GUIDANCE

### When to Use This Skill
$when_to_use

### When NOT to Use This Skill
$when_not_to_use

### Success Criteria
$success_criteria

### Edge Cases & Limitations
$edge_cases

### Critical Guardrails
$guardrails

### Evidence-Based Validation
$evidence_based

---
EOF

  # Insert after line 40 (after guardrails, before name: in YAML)
  # Use sed to insert at line 41 (after line 40)
  sed -i '40r /tmp/skill_improvement_'$$'.txt' "$file"

  rm -f /tmp/skill_improvement_$$.txt

  echo "  [OK] Applied improvements to: $skill_name"
  ((PROCESSED_COUNT++))
}

# === LITERATURE SYNTHESIS ===
if [ -f "$RESEARCH_DIR/literature-synthesis/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/literature-synthesis/SKILL.md" \
    "literature-synthesis" \
    "- Academic research requiring systematic literature review (PRISMA-compliant)
- SOTA analysis for Deep Research SOP Phase 1
- Identifying research gaps and opportunities for novel methods
- Preparing related work sections for academic papers
- Validating novelty claims with 50+ peer-reviewed sources" \
    "- Quick fact-checking or single-paper summaries (use researcher skill instead)
- Non-academic contexts (industry reports, blog posts)
- When <50 papers are sufficient for the research question
- Time-constrained projects requiring <1 week turnaround" \
    "- Minimum 50 papers reviewed (Quality Gate 1 requirement)
- PRISMA flow diagram generated with screening rationale
- SOTA benchmarks extracted and tabulated
- Research gaps identified with 3+ supporting citations
- BibTeX database created with complete metadata
- All claims cross-referenced with 2+ independent sources" \
    "- Paywalled papers: Check institutional access, contact authors, use preprints
- Conflicting results: Report both sides, analyze methodology differences
- Rapidly evolving fields (e.g., LLMs): Expand to preprints (arXiv), track citations
- Limited dataset access: Document as limitation, suggest alternatives
- Outdated SOTA: Verify publication dates, check for newer methods" \
    "- NEVER claim research gaps without systematic evidence (show search strategy)
- ALWAYS document inclusion/exclusion criteria before screening
- NEVER cherry-pick papers supporting a hypothesis (report contradictory evidence)
- ALWAYS verify publication venue tier (check h-index, acceptance rates)
- NEVER skip quality assessment (use CASP checklist for qualitative studies)" \
    "- Validate search strategy reproducibility: Rerun queries, verify result counts match
- Cross-validate SOTA benchmarks: Check Papers with Code, official leaderboards
- Verify citation accuracy: Match title/author/year against original source
- Test research gap validity: Search for contradictory evidence actively
- Confirm PRISMA compliance: Use official checklist, report all 27 items"
fi

# === BASELINE REPLICATION ===
if [ -f "$RESEARCH_DIR/baseline-replication/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/baseline-replication/SKILL.md" \
    "baseline-replication" \
    "- Validating published ML baselines before novel method development (Deep Research SOP Pipeline D)
- Reproducing experiments for NeurIPS/ICML reproducibility challenges
- Verifying SOTA claims before building on prior work
- Creating reproducibility packages for Quality Gate 1
- Debugging performance gaps between published and reproduced results" \
    "- Quick proof-of-concept implementations (use prototyping playbook)
- When exact reproducibility is not critical (e.g., demo projects)
- Papers without published code or detailed methodology
- Industry benchmarks without academic rigor requirements" \
    "- Results within +/- 1% of published metrics (statistical tolerance)
- 3+ successful reproductions in fresh Docker environments
- All 47+ hyperparameters documented and validated
- Reproducibility package tested by independent party
- Dataset checksums verified (SHA256)
- Random seeds documented and deterministic results achieved" \
    "- Missing hyperparameters: Check GitHub issues, contact authors, search supplements
- Framework version mismatches: Test PyTorch 1.7 vs 1.13, document numerical differences
- Hardware differences: V100 vs A100 precision, document in reproducibility notes
- Non-deterministic operations: Force torch.use_deterministic_algorithms(True)
- Dataset preprocessing ambiguity: Compare sample outputs, validate checksums" \
    "- NEVER claim reproduction success without statistical validation (t-test, CI)
- ALWAYS document exact framework versions (pip freeze, conda list --export)
- NEVER skip random seed validation (test determinism with 3+ runs)
- ALWAYS verify dataset integrity (SHA256, sample counts, split ratios)
- NEVER assume default hyperparameters (extract all from paper/code explicitly)" \
    "- Validate determinism: Run 3 times, verify identical results (variance = 0)
- Cross-validate metrics: Recompute from saved outputs, compare to paper
- Test fresh environment: Build Docker from scratch, verify no cached dependencies
- Verify statistical power: Calculate required sample size, check reported N
- Confirm effect size: Compute Cohen's d, verify practical significance"
fi

# === RESEARCHER ===
if [ -f "$RESEARCH_DIR/researcher/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/researcher/SKILL.md" \
    "researcher" \
    "- Multi-source investigation requiring 3-5+ credible sources (Level 2-3 research)
- Technical documentation analysis with credibility scoring (>85%)
- Cross-referencing claims across industry reports, academic papers, official docs
- Building knowledge bases for unfamiliar technologies or domains
- Systematic information gathering with comprehensive source evaluation" \
    "- Single-source quick lookups (use web search directly)
- Non-technical questions not requiring credibility analysis
- When speed is prioritized over source verification (<5 min deadline)
- Opinion-based topics without objective truth (use judgment, not research)" \
    "- 90%+ average credibility score across all cited sources
- 3+ independent sources corroborate key claims
- All sources annotated with credibility breakdown (Authority, Accuracy, Objectivity, Currency, Coverage)
- Contradictory evidence reported and analyzed
- Full citations provided (APA/IEEE/ACM format with access dates)" \
    "- Paywalled sources: Use institutional access, preprints, contact authors
- Conflicting expert opinions: Present both sides, analyze methodology/bias
- Rapidly changing topics (AI, crypto): Prioritize Currency (15%), accept lower coverage
- Niche topics with limited sources: Expand to Tier 3 (expert blogs), disclose limitations
- Biased sources: Flag bias score, require 3+ independent corroborations" \
    "- NEVER cite without credibility scoring (use 0-100% rubric)
- ALWAYS cross-reference claims with 2+ independent Tier 1/2 sources
- NEVER accept <70% credibility sources without explicit disclosure
- ALWAYS distinguish facts (verifiable) from interpretations (opinion)
- NEVER skip source publication date verification (check Currency dimension)" \
    "- Validate source authority: Check author credentials (H-index, institutional affiliation)
- Cross-validate factual claims: Search for contradictory evidence actively
- Verify objectivity: Check funding sources, conflicts of interest
- Test currency: Compare publication date to topic evolution, flag outdated info
- Confirm coverage: Verify comprehensive treatment vs. surface-level overview"
fi

# === METHOD DEVELOPMENT ===
if [ -f "$RESEARCH_DIR/method-development/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/method-development/SKILL.md" \
    "method-development" \
    "- Developing novel ML methods after baseline replication (Deep Research SOP Pipeline D)
- Conducting ablation studies (5+ ablations required for Quality Gate 2)
- Hyperparameter optimization with statistical validation
- Proposing architectural innovations with rigorous experimental validation
- Publishing research requiring reproducibility and statistical rigor" \
    "- Before baseline replication is complete (Quality Gate 1 required first)
- Quick prototyping without rigorous validation
- When ablation studies are not feasible (<5 components to ablate)
- Industry projects not requiring academic-level statistical rigor" \
    "- Novel method outperforms baseline with p < 0.05 statistical significance
- 5+ ablation studies isolate component contributions
- Effect sizes reported (Cohen's d >= 0.5 for medium effect)
- 95% confidence intervals calculated for all metrics
- Multiple comparison corrections applied (Bonferroni, FDR)
- Statistical power verified (1-beta >= 0.8)" \
    "- Small datasets: Use bootstrapping (1000+ samples) for robust CI estimation
- High variance results: Increase runs (10+ seeds), report full distribution
- Multiple metrics: Apply Bonferroni correction (alpha = 0.05 / k metrics)
- Negative results: Report faithfully, analyze failure modes
- Computational limits: Use smaller ablation sets, document constraints" \
    "- NEVER claim novelty without ablation studies isolating contributions
- ALWAYS report effect sizes (not just p-values, avoid p-hacking)
- NEVER cherry-pick best results (report all runs, use median/mean appropriately)
- ALWAYS apply multiple comparison corrections when testing k > 1 hypotheses
- NEVER skip statistical power analysis (verify sufficient sample size)" \
    "- Validate statistical significance: Recompute p-values, verify assumptions (normality, homoscedasticity)
- Cross-validate ablations: Ensure component removal actually changes behavior
- Test generalization: Validate on held-out datasets, check distribution shift
- Verify effect size: Compute Cohen's d, confirm practical significance (d >= 0.5)
- Confirm reproducibility: Rerun experiments with different seeds, verify consistency"
fi

# === DEEP RESEARCH ORCHESTRATOR ===
if [ -f "$RESEARCH_DIR/deep-research-orchestrator/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/deep-research-orchestrator/SKILL.md" \
    "deep-research-orchestrator" \
    "- Complete research lifecycle from literature review to production deployment (Pipelines A-I)
- Multi-month academic projects requiring 3 quality gates
- NeurIPS/ICML/CVPR submissions with reproducibility requirements
- Research requiring systematic methodology (PRISMA, ACM badging)
- Coordinating 9 pipelines with 15+ specialized agents" \
    "- Quick investigations (<1 week, use researcher skill)
- Single-pipeline workflows (use specific skills: literature-synthesis, baseline-replication)
- Industry projects without academic rigor requirements
- Prototyping without publication goals" \
    "- All 3 Quality Gates passed (Gate 1: Foundations, Gate 2: Development, Gate 3: Production)
- Minimum 50 papers reviewed (Pipeline A)
- Baseline replicated within +/- 1% (Pipeline D)
- Novel method validated with p < 0.05, effect size d >= 0.5
- Holistic evaluation across 6+ dimensions (accuracy, fairness, robustness, efficiency, interpretability, safety)
- Reproducibility package tested in fresh environments
- Ethics review completed (data bias audit, fairness metrics)" \
    "- Gate 1 failure: Incomplete literature review, missing SOTA benchmarks
- Gate 2 failure: Ablation studies insufficient, statistical power too low
- Gate 3 failure: Production infrastructure not validated, monitoring gaps
- Multi-modal data: Expand holistic evaluation to include modality-specific metrics
- Limited compute: Prioritize smaller ablation sets, document constraints" \
    "- NEVER skip Quality Gates (use gate-validation skill for rigorous checks)
- ALWAYS document full pipeline execution (A through I, no shortcuts)
- NEVER claim production readiness without Gate 3 validation
- ALWAYS coordinate ethics review (ethics-agent) before Gate 1
- NEVER bypass reproducibility requirements (archivist agent mandatory)" \
    "- Validate Gate 1: Verify 50+ papers, SOTA benchmarks, research gaps documented
- Validate Gate 2: Confirm 5+ ablations, p < 0.05, effect size d >= 0.5
- Validate Gate 3: Test production deployment, verify monitoring, rollback strategies
- Cross-validate pipelines: Ensure Pipeline D baseline feeds into Pipeline E holistic eval
- Verify agent coordination: Check memory-mcp state, confirm handoffs logged"
fi

# === INTENT ANALYZER ===
if [ -f "$RESEARCH_DIR/intent-analyzer/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/intent-analyzer/SKILL.md" \
    "intent-analyzer" \
    "- Vague or ambiguous user requests requiring clarification
- Multi-step workflows where underlying intent is unclear
- First principles decomposition of complex requests
- Socratic questioning to uncover hidden constraints
- Probabilistic intent mapping with <80% confidence requiring clarification" \
    "- Clear, actionable requests with explicit requirements (>90% confidence)
- Simple single-step tasks with no ambiguity
- When speed is prioritized over thorough understanding
- Follow-up questions where context is already established" \
    "- Understood intent with 85%+ confidence score
- Explicit and implicit constraints identified
- Ambiguities resolved through Socratic clarification
- User confirms optimized request matches true intent
- First principles decomposition reveals underlying goals" \
    "- User says just do it: Flag low confidence, proceed with caveats
- Contradictory requirements: Surface conflict, request prioritization
- Unstated assumptions: Probe with questions, validate inferences
- Multiple valid interpretations: Present options, ask user to choose
- Domain-specific jargon: Verify technical terms match user's mental model" \
    "- NEVER proceed with <80% confidence without clarification
- ALWAYS distinguish explicit constraints (stated) from implicit (inferred)
- NEVER assume user's technical level (ask if terminology is unclear)
- ALWAYS present optimized request for user confirmation
- NEVER skip first principles decomposition for complex requests" \
    "- Validate confidence score: Recompute from constraint clarity, goal specificity
- Cross-check assumptions: Ask follow-up questions targeting low-confidence areas
- Test optimized request: Does it capture all explicit + implicit constraints?
- Verify first principles: Can you explain WHY each requirement exists?
- Confirm user alignment: Show decomposition, get explicit approval"
fi

# === INTERACTIVE PLANNER ===
if [ -f "$RESEARCH_DIR/interactive-planner/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/interactive-planner/SKILL.md" \
    "interactive-planner" \
    "- Gathering comprehensive requirements through structured multi-select questions
- Architecture decisions requiring user input on frameworks, databases, deployment
- Feature planning when user preferences are unknown (auth methods, UI libraries)
- Reducing assumption-based planning by collecting explicit choices upfront
- When playbook routing requires clarification of technical stack" \
    "- Requirements are already well-defined (skip to planner skill)
- Single-choice decisions (not multi-select scenarios)
- When speed is prioritized over comprehensive gathering
- Follow-up planning where context is established" \
    "- User answers 5-10 multi-select questions covering key decisions
- All critical choices captured (framework, database, auth, deployment, testing)
- Plan generated reflects user selections (no misaligned assumptions)
- User confirms plan matches intent before execution
- Requirements document exported with all selections" \
    "- User unsure of options: Provide brief explanations, suggest defaults
- Too many questions: Group related choices, prioritize critical decisions first
- Contradictory selections: Flag conflicts, ask for resolution
- Missing options: Allow custom user input for unlisted choices
- Technical jargon: Simplify language, provide examples" \
    "- NEVER assume technical choices without asking (framework, database, cloud provider)
- ALWAYS provide option explanations for non-experts
- NEVER overwhelm with >15 questions (prioritize top 5-10)
- ALWAYS export requirements document after gathering
- NEVER proceed to planning without user confirmation of selections" \
    "- Validate coverage: Did questions capture all critical decisions?
- Cross-check consistency: Are selections compatible (e.g., React + Express)?
- Test plan alignment: Does generated plan use selected options?
- Verify user understanding: Were explanations clear, choices informed?
- Confirm completeness: Are there unstated requirements still missing?"
fi

# === RESEARCH-DRIVEN PLANNING ===
if [ -f "$RESEARCH_DIR/research-driven-planning/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/research-driven-planning/SKILL.md" \
    "research-driven-planning" \
    "- Complex features requiring research before implementation (Three-Loop System Loop 1)
- High-risk projects needing pre-mortem analysis (5x cycles)
- Multi-agent consensus planning with >97% accuracy requirements
- When best practices research is needed before committing to architecture
- Strategic planning requiring Gemini Search for SOTA investigation" \
    "- Simple features with known solutions (use simple-feature-implementation)
- When speed is prioritized over rigorous planning (<4 hour deadline)
- Well-understood domains with established patterns (skip research phase)
- Prototyping without production requirements" \
    "- Research phase complete with 3-5+ credible sources analyzed
- 5 pre-mortem cycles executed, failure modes identified
- Multi-agent consensus achieved (3+ agents agree on plan)
- Plan accuracy >97% (validated against similar past projects)
- Best practices documented with citations
- Dependencies and parallelization strategy clearly defined" \
    "- Limited research sources: Expand to Tier 3 (expert blogs), flag limitations
- Pre-mortem reveals insurmountable risks: Escalate to user, suggest alternatives
- Agent consensus fails: Use voting mechanism, document dissent
- Rapidly changing best practices: Prioritize recent sources (2023+), flag currency
- Complex dependencies: Use dependency graph visualization, verify no cycles" \
    "- NEVER skip research phase for unfamiliar technologies
- ALWAYS execute 5 pre-mortem cycles (identify failure modes proactively)
- NEVER proceed without multi-agent consensus (minimum 3 agents)
- ALWAYS validate plan accuracy against historical data (>95% threshold)
- NEVER assume best practices without citations (use Gemini Search)" \
    "- Validate research completeness: Did you cover all critical aspects (security, performance, scalability)?
- Cross-check pre-mortem coverage: Were all major failure modes addressed?
- Test consensus validity: Do agents agree on root assumptions, not just surface plan?
- Verify plan accuracy: Compare to similar projects, check historical success rate
- Confirm source recency: Are best practices current (published within 2 years)?"
fi

# === RAPID IDEA GENERATOR ===
if [ -f "$RESEARCH_DIR/rapid-idea-generator/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/rapid-idea-generator/SKILL.md" \
    "rapid-idea-generator" \
    "- Brainstorming research directions after literature synthesis
- Generating 10+ novel hypotheses from identified research gaps
- Rapid ideation for grant proposals or project pitches
- Exploring alternative approaches when initial methods fail
- Creative divergent thinking for problem-solving" \
    "- When rigorous validation is required immediately (use method-development)
- Single-idea deep dives (use researcher skill for focused investigation)
- Production code generation (use feature-dev-complete)
- When novelty is not the primary goal" \
    "- 10+ distinct ideas generated per session
- Ideas directly address identified research gaps
- Each idea includes testable hypothesis and expected outcome
- Feasibility assessment provided (quick vs long-term)
- Citations to supporting literature included" \
    "- No research gaps identified: Broaden literature search, explore adjacent fields
- Ideas too similar: Apply forced constraints (different modalities, opposite assumptions)
- Infeasible ideas: Flag as long-term, suggest simpler variants
- Low novelty: Cross-check against SOTA, ensure true gap exists
- Over-ambitious scope: Break into sub-ideas, prioritize quick wins" \
    "- NEVER generate ideas without grounding in research gaps
- ALWAYS provide testable hypotheses (falsifiable predictions)
- NEVER claim novelty without literature verification
- ALWAYS assess feasibility (computational cost, data requirements)
- NEVER skip expected outcome specification" \
    "- Validate novelty: Search for similar ideas in literature (use Semantic Scholar)
- Test hypothesis clarity: Can it be tested experimentally with clear success criteria?
- Verify gap alignment: Does idea directly address documented research gap?
- Check feasibility: Are required resources (data, compute, time) realistic?
- Confirm testability: Can hypothesis be falsified with available methods?"
fi

# === RAPID MANUSCRIPT DRAFTER ===
if [ -f "$RESEARCH_DIR/rapid-manuscript-drafter/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/rapid-manuscript-drafter/SKILL.md" \
    "rapid-manuscript-drafter" \
    "- Drafting academic papers for NeurIPS/ICML/CVPR submission
- Generating research papers from completed Deep Research SOP pipelines
- Creating reproducibility reports with ACM artifact badging
- Writing technical reports with comprehensive methodology documentation
- Preparing grant proposals requiring academic rigor" \
    "- Blog posts or non-academic writing (use documentation skills)
- When full Deep Research SOP has not been completed
- Informal technical documentation (use comprehensive-documentation)
- When peer review is not the target venue" \
    "- Complete manuscript with all standard sections (Abstract, Intro, Related Work, Methods, Results, Discussion, Conclusion)
- All claims cited with proper references (BibTeX generated)
- Figures and tables properly formatted (captions, labels)
- Reproducibility section included (code, data, hyperparameters)
- Word count matches venue requirements (8 pages for NeurIPS, 12 for CVPR)
- LaTeX source compiles without errors" \
    "- Over page limit: Prioritize core contributions, move details to appendix
- Missing experimental results: Flag incomplete sections, suggest placeholder data
- Weak related work: Expand literature synthesis, add 10+ recent papers
- Unclear methodology: Add algorithmic pseudocode, detailed architecture diagrams
- Insufficient ablations: Document need for additional experiments" \
    "- NEVER submit drafts with uncited claims (verify all assertions have references)
- ALWAYS include reproducibility section (code, data, hyperparameters, seeds)
- NEVER fabricate experimental results (use real data from method-development)
- ALWAYS verify venue formatting guidelines (check template, page limits)
- NEVER skip statistical validation (p-values, CIs, effect sizes)" \
    "- Validate citation completeness: Search for all claims, verify references exist
- Cross-check reproducibility: Can experiments be rerun from manuscript alone?
- Test figure quality: Are plots high-resolution (300+ DPI), axes labeled, legends clear?
- Verify statistical rigor: Are all p-values, CIs, effect sizes reported?
- Confirm template compliance: Does LaTeX compile, match venue style exactly?"
fi

# === RESEARCH GAP VISUALIZER ===
if [ -f "$RESEARCH_DIR/research-gap-visualizer/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/research-gap-visualizer/SKILL.md" \
    "research-gap-visualizer" \
    "- Visualizing research gaps identified from literature synthesis
- Creating 2D/3D plots of method vs. dataset coverage
- Generating heatmaps showing unexplored method combinations
- Producing publication-ready figures for grant proposals
- Analyzing trends in research focus over time" \
    "- When raw text descriptions are sufficient (no visualization needed)
- Single-dimensional gaps (simple list format works)
- When time is constrained (<30 min, skip visualization)
- Non-academic audiences unfamiliar with research visualizations" \
    "- High-resolution publication-ready figures (300+ DPI)
- Clear axis labels, legends, and titles
- Color scheme accessible (colorblind-friendly)
- Gap areas clearly highlighted (red for unexplored, green for saturated)
- Source data included (CSV/JSON for reproducibility)" \
    "- Too many dimensions: Use PCA/t-SNE for dimensionality reduction
- Sparse data: Adjust visualization type (scatter plot vs heatmap)
- Unclear gaps: Add annotations explaining why areas are unexplored
- Complex taxonomy: Simplify groupings, use hierarchical clustering
- Overlapping labels: Increase figure size, rotate text, use abbreviations" \
    "- NEVER use misleading visualizations (cherry-picked axes, truncated scales)
- ALWAYS include colorblind-friendly palettes (use viridis, not rainbow)
- NEVER omit axis labels, units, or legends
- ALWAYS provide source data for reproducibility
- NEVER use 3D when 2D suffices (avoid chart junk)" \
    "- Validate data accuracy: Cross-check plotted values against source tables
- Test colorblind accessibility: Use simulators (Coblis, Color Oracle)
- Verify label clarity: Are all abbreviations explained in caption?
- Check resolution: Export at 300+ DPI, zoom to verify sharpness
- Confirm reproducibility: Can figure be regenerated from provided source data?"
fi

# === RESEARCH PUBLICATION ===
if [ -f "$RESEARCH_DIR/research-publication/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/research-publication/SKILL.md" \
    "research-publication" \
    "- Submitting papers to NeurIPS/ICML/CVPR/ICCV/ECCV conferences
- Managing peer review process (responding to reviewers)
- Preparing camera-ready versions with final formatting
- Publishing reproducibility packages (ACM artifact badging)
- Archiving research artifacts for long-term availability" \
    "- Preprint-only publications (use arXiv upload directly)
- Industry blog posts (use documentation skills)
- Internal technical reports (use rapid-manuscript-drafter)
- When full peer review is not required" \
    "- Paper submitted to target venue with all required files (PDF, source, supplementary)
- Reproducibility package published (GitHub, Zenodo, ACM DL)
- Reviewer responses drafted addressing all comments
- Camera-ready version uploaded meeting all formatting requirements
- Artifacts archived with permanent DOIs (Zenodo, FigShare)" \
    "- Desk rejection: Verify venue fit, check submission guidelines, resubmit elsewhere
- Major revisions: Address all reviewer concerns, add requested experiments
- Missing reproducibility materials: Package code, data, hyperparameters retroactively
- Formatting errors: Use venue template exactly, validate with LaTeXdiff
- License conflicts: Clarify data licensing, use permissive licenses (MIT, Apache 2.0)" \
    "- NEVER ignore reviewer comments (address every point explicitly)
- ALWAYS publish reproducibility packages (code, data, pre-trained models)
- NEVER violate venue anonymity requirements (blind submissions, no self-citations)
- ALWAYS archive with permanent identifiers (DOI, arXiv ID)
- NEVER use proprietary data without clearance (verify licensing)" \
    "- Validate submission completeness: Checklist includes PDF, source, supplementary, metadata
- Cross-check reviewer responses: Did you address all comments point-by-point?
- Test reproducibility package: Can independent party rerun experiments from package alone?
- Verify camera-ready formatting: Does LaTeX compile, match template exactly?
- Confirm archival: Are DOIs permanent, artifacts publicly accessible?"
fi

# === VISUAL ASSET GENERATOR ===
if [ -f "$RESEARCH_DIR/visual-asset-generator/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/visual-asset-generator/SKILL.md" \
    "visual-asset-generator" \
    "- Creating publication-ready figures for academic papers
- Generating architecture diagrams for neural network models
- Producing workflow visualizations for methodology sections
- Designing infographics for grant proposals or presentations
- Creating high-resolution plots for experimental results" \
    "- Quick sketches or whiteboard diagrams (use manual drawing)
- When existing templates suffice (use standard matplotlib/seaborn)
- Non-academic visualizations (use general design tools)
- When time is constrained (<1 hour, use pre-made assets)" \
    "- High-resolution publication-ready assets (300+ DPI, vector formats)
- Clear labels, legends, and captions
- Colorblind-friendly palettes (viridis, cividis)
- Consistent style across all figures (fonts, colors, line widths)
- Source files included (SVG, PDF, Python/R scripts)" \
    "- Complex architectures: Use hierarchical layouts, group related components
- Too much detail: Simplify non-critical elements, use zoomed insets
- Unclear flow: Add arrows, numbers, or annotations guiding reader
- Overlapping elements: Adjust spacing, use semi-transparency
- Inconsistent styling: Create style guide, apply globally" \
    "- NEVER use raster formats for diagrams (use SVG, PDF, not PNG/JPG)
- ALWAYS include captions explaining what figure shows
- NEVER use default matplotlib colors (not colorblind-friendly)
- ALWAYS provide source code for reproducibility (Python, R, TikZ)
- NEVER omit scale bars, axis units, or legends" \
    "- Validate resolution: Export at 300+ DPI, zoom to verify sharpness
- Test colorblind accessibility: Use simulators (Coblis, Color Oracle)
- Verify label clarity: Are all abbreviations explained in caption?
- Check consistency: Do all figures use same fonts, colors, styles?
- Confirm reproducibility: Can figure be regenerated from provided source code?"
fi

# === SPECIALIZED TOOL: INTERACTIVE PLANNER ===
if [ -f "$RESEARCH_DIR/specialized-tools/when-gathering-requirements-use-interactive-planner/SKILL.md" ]; then
  apply_improvements \
    "$RESEARCH_DIR/specialized-tools/when-gathering-requirements-use-interactive-planner/SKILL.md" \
    "when-gathering-requirements-use-interactive-planner" \
    "- Triggering interactive-planner skill when gathering requirements is detected
- Auto-invoking structured multi-select questions for architecture decisions
- Ensuring comprehensive requirements collection before planning
- Reducing assumption-based design by collecting explicit user choices
- Specialized tool wrapper for requirements gathering scenarios" \
    "- Requirements already defined (skip to planner)
- Single-choice decisions (not multi-select)
- When interactive-planner is already invoked directly
- Follow-up scenarios where context exists" \
    "- Interactive-planner skill successfully invoked
- User presented with 5-10 multi-select questions
- All critical choices captured before planning proceeds
- Requirements document exported
- Plan reflects user selections accurately" \
    "- User bypasses questions: Respect preference, document assumptions made
- Skill invocation fails: Fallback to manual requirements gathering
- Too many nested tool calls: Simplify to direct interactive-planner invocation
- Contradictory selections: Flag for resolution before proceeding
- Missing context: Gather minimal required info before invoking" \
    "- NEVER invoke if interactive-planner already active (avoid recursion)
- ALWAYS verify requirements gathering is truly needed
- NEVER force questions if user has clear requirements
- ALWAYS respect user preference to skip
- NEVER proceed to planning without confirmation" \
    "- Validate invocation appropriateness: Is requirements gathering truly needed?
- Cross-check skill availability: Is interactive-planner accessible?
- Test user intent: Does user want structured questions or prefer freeform?
- Verify context: Is this the right moment to invoke (not mid-execution)?
- Confirm fallback: If invocation fails, can manual gathering proceed?"
fi

echo ""
echo "=== SUMMARY ==="
echo "Processed: $PROCESSED_COUNT SKILL.md files"
echo "Backup location: $BACKUP_DIR"
echo ""
echo "Changes applied:"
echo "  - When to Use section (research-specific triggers)"
echo "  - When NOT to Use section (anti-patterns, exclusions)"
echo "  - Success Criteria (measurable outcomes)"
echo "  - Edge Cases & Limitations (failure modes, constraints)"
echo "  - Critical Guardrails (research ethics, methodology)"
echo "  - Evidence-Based Validation (verification techniques)"
echo ""
echo "To verify changes, run:"
echo "  diff $BACKUP_DIR/literature-synthesis-SKILL.md $RESEARCH_DIR/literature-synthesis/SKILL.md"
echo ""
echo "To rollback, run:"
echo "  cp -r $BACKUP_DIR/* $RESEARCH_DIR/*/SKILL.md"
