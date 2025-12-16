#!/usr/bin/env python3
"""
Apply SKILL-SPECIFIC prompt improvements to ALL research SKILL.md files
Dynamically finds YAML frontmatter start (name: field) and inserts before it
"""

import os
import re
import shutil
from datetime import datetime
from pathlib import Path

RESEARCH_DIR = Path("C:/Users/17175/claude-code-plugins/ruv-sparc-three-loop-system/skills/research")
TIMESTAMP = datetime.now().strftime("%Y%m%d-%H%M%S")
BACKUP_DIR = RESEARCH_DIR / f".backup-complete-{TIMESTAMP}"

# ALL 14 research skills with customized improvements
IMPROVEMENTS = {
    "literature-synthesis": {
        "when_to_use": "- Academic research requiring systematic literature review (PRISMA-compliant)\n- SOTA analysis for Deep Research SOP Phase 1\n- Identifying research gaps and opportunities for novel methods\n- Preparing related work sections for academic papers\n- Validating novelty claims with 50+ peer-reviewed sources",
        "when_not_to_use": "- Quick fact-checking or single-paper summaries (use researcher skill)\n- Non-academic contexts (industry reports, blog posts)\n- When <50 papers are sufficient\n- Time-constrained projects (<1 week turnaround)",
        "success_criteria": "- Minimum 50 papers reviewed (Quality Gate 1)\n- PRISMA flow diagram generated\n- SOTA benchmarks extracted and tabulated\n- Research gaps identified with 3+ citations\n- BibTeX database with complete metadata\n- All claims cross-referenced with 2+ independent sources",
        "edge_cases": "- Paywalled papers: institutional access, contact authors, preprints\n- Conflicting results: report both sides, analyze methodology\n- Rapidly evolving fields: expand to arXiv, track citations\n- Limited dataset access: document limitation, suggest alternatives\n- Outdated SOTA: verify publication dates, check newer methods",
        "guardrails": "- NEVER claim research gaps without systematic evidence (show search strategy)\n- ALWAYS document inclusion/exclusion criteria before screening\n- NEVER cherry-pick papers (report contradictory evidence)\n- ALWAYS verify publication venue tier (h-index, acceptance rates)\n- NEVER skip quality assessment (CASP checklist)",
        "evidence_based": "- Validate search reproducibility: rerun queries, verify counts\n- Cross-validate SOTA benchmarks: Papers with Code, leaderboards\n- Verify citation accuracy: match title/author/year\n- Test research gap validity: search for contradictory evidence\n- Confirm PRISMA compliance: official checklist, 27 items"
    },
    "baseline-replication": {
        "when_to_use": "- Validating ML baselines before novel methods (Deep Research SOP Pipeline D)\n- Reproducing experiments for NeurIPS/ICML challenges\n- Verifying SOTA claims before building on prior work\n- Creating reproducibility packages for Quality Gate 1\n- Debugging performance gaps between published and reproduced results",
        "when_not_to_use": "- Quick proof-of-concept implementations (use prototyping)\n- When exact reproducibility not critical (demo projects)\n- Papers without code or detailed methodology\n- Industry benchmarks without academic rigor",
        "success_criteria": "- Results within +/- 1% of published metrics\n- 3+ successful reproductions in fresh Docker\n- All 47+ hyperparameters documented\n- Reproducibility package tested independently\n- Dataset checksums verified (SHA256)\n- Random seeds documented, deterministic results",
        "edge_cases": "- Missing hyperparameters: GitHub issues, contact authors, supplements\n- Framework version mismatches: test PyTorch 1.7 vs 1.13, document differences\n- Hardware differences: V100 vs A100 precision, document in notes\n- Non-deterministic operations: force torch.use_deterministic_algorithms(True)\n- Dataset preprocessing: compare sample outputs, validate checksums",
        "guardrails": "- NEVER claim reproduction without statistical validation (t-test, CI)\n- ALWAYS document exact framework versions (pip freeze, conda export)\n- NEVER skip random seed validation (test 3+ runs)\n- ALWAYS verify dataset integrity (SHA256, sample counts, splits)\n- NEVER assume default hyperparameters (extract from paper/code)",
        "evidence_based": "- Validate determinism: run 3x, verify identical results (variance = 0)\n- Cross-validate metrics: recompute from saved outputs\n- Test fresh environment: Docker from scratch, no cached deps\n- Verify statistical power: calculate required N, check reported N\n- Confirm effect size: compute Cohen's d, verify significance"
    },
    "researcher": {
        "when_to_use": "- Multi-source investigation requiring 3-5+ credible sources (Level 2-3)\n- Technical documentation analysis with credibility scoring (>85%)\n- Cross-referencing claims across reports, papers, official docs\n- Building knowledge bases for unfamiliar domains\n- Systematic information gathering with source evaluation",
        "when_not_to_use": "- Single-source quick lookups (use web search)\n- Non-technical questions without credibility analysis\n- Speed prioritized over verification (<5 min deadline)\n- Opinion-based topics without objective truth",
        "success_criteria": "- 90%+ average credibility score across sources\n- 3+ independent sources corroborate key claims\n- All sources annotated with credibility breakdown\n- Contradictory evidence reported and analyzed\n- Full citations (APA/IEEE/ACM with access dates)",
        "edge_cases": "- Paywalled sources: institutional access, preprints, contact authors\n- Conflicting experts: present both sides, analyze methodology/bias\n- Rapidly changing topics: prioritize Currency (15%), accept lower coverage\n- Niche topics: expand to Tier 3 (expert blogs), disclose limitations\n- Biased sources: flag bias score, require 3+ independent corroborations",
        "guardrails": "- NEVER cite without credibility scoring (use 0-100% rubric)\n- ALWAYS cross-reference with 2+ independent Tier 1/2 sources\n- NEVER accept <70% credibility without disclosure\n- ALWAYS distinguish facts (verifiable) from interpretations (opinion)\n- NEVER skip publication date verification (Currency dimension)",
        "evidence_based": "- Validate authority: check credentials (H-index, institutional affiliation)\n- Cross-validate claims: search for contradictory evidence actively\n- Verify objectivity: check funding sources, conflicts of interest\n- Test currency: compare pub date to topic evolution, flag outdated\n- Confirm coverage: verify comprehensive treatment vs. surface-level"
    },
    "method-development": {
        "when_to_use": "- Developing novel ML methods after baseline replication (Deep Research SOP Pipeline D)\n- Conducting ablation studies (5+ ablations for Quality Gate 2)\n- Hyperparameter optimization with statistical validation\n- Proposing architectural innovations with rigorous experimental validation\n- Publishing research requiring reproducibility and statistical rigor",
        "when_not_to_use": "- Before baseline replication complete (Quality Gate 1 required)\n- Quick prototyping without rigorous validation\n- When ablation studies not feasible (<5 components)\n- Industry projects without academic-level rigor",
        "success_criteria": "- Novel method outperforms baseline (p < 0.05)\n- 5+ ablation studies isolate component contributions\n- Effect sizes reported (Cohen's d >= 0.5)\n- 95% confidence intervals for all metrics\n- Multiple comparison corrections (Bonferroni, FDR)\n- Statistical power verified (1-beta >= 0.8)",
        "edge_cases": "- Small datasets: use bootstrapping (1000+ samples) for robust CI\n- High variance: increase runs (10+ seeds), report full distribution\n- Multiple metrics: apply Bonferroni correction (alpha = 0.05 / k)\n- Negative results: report faithfully, analyze failure modes\n- Computational limits: use smaller ablation sets, document constraints",
        "guardrails": "- NEVER claim novelty without ablation studies isolating contributions\n- ALWAYS report effect sizes (not just p-values, avoid p-hacking)\n- NEVER cherry-pick best results (report all runs, use median/mean appropriately)\n- ALWAYS apply multiple comparison corrections (k > 1 hypotheses)\n- NEVER skip statistical power analysis (verify sufficient N)",
        "evidence_based": "- Validate significance: recompute p-values, verify assumptions (normality, homoscedasticity)\n- Cross-validate ablations: ensure component removal changes behavior\n- Test generalization: validate on held-out datasets, check distribution shift\n- Verify effect size: compute Cohen's d, confirm practical significance (d >= 0.5)\n- Confirm reproducibility: rerun with different seeds, verify consistency"
    },
    "deep-research-orchestrator": {
        "when_to_use": "- Complete research lifecycle from literature review to production (Pipelines A-I)\n- Multi-month academic projects requiring 3 quality gates\n- NeurIPS/ICML/CVPR submissions with reproducibility requirements\n- Research requiring systematic methodology (PRISMA, ACM badging)\n- Coordinating 9 pipelines with 15+ specialized agents",
        "when_not_to_use": "- Quick investigations (<1 week, use researcher skill)\n- Single-pipeline workflows (use specific skills)\n- Industry projects without academic rigor\n- Prototyping without publication goals",
        "success_criteria": "- All 3 Quality Gates passed (Foundations, Development, Production)\n- Minimum 50 papers reviewed (Pipeline A)\n- Baseline replicated within +/- 1% (Pipeline D)\n- Novel method validated (p < 0.05, d >= 0.5)\n- Holistic evaluation across 6+ dimensions\n- Reproducibility package tested in fresh environments\n- Ethics review completed (data bias audit, fairness metrics)",
        "edge_cases": "- Gate 1 failure: incomplete literature review, missing SOTA benchmarks\n- Gate 2 failure: insufficient ablations, statistical power too low\n- Gate 3 failure: production infrastructure not validated, monitoring gaps\n- Multi-modal data: expand holistic evaluation to modality-specific metrics\n- Limited compute: prioritize smaller ablation sets, document constraints",
        "guardrails": "- NEVER skip Quality Gates (use gate-validation for rigorous checks)\n- ALWAYS document full pipeline execution (A through I, no shortcuts)\n- NEVER claim production readiness without Gate 3 validation\n- ALWAYS coordinate ethics review (ethics-agent) before Gate 1\n- NEVER bypass reproducibility requirements (archivist agent mandatory)",
        "evidence_based": "- Validate Gate 1: verify 50+ papers, SOTA benchmarks, research gaps\n- Validate Gate 2: confirm 5+ ablations, p < 0.05, effect size d >= 0.5\n- Validate Gate 3: test production deployment, monitoring, rollback strategies\n- Cross-validate pipelines: ensure Pipeline D baseline feeds into Pipeline E\n- Verify agent coordination: check memory-mcp state, confirm handoffs logged"
    },
    "intent-analyzer": {
        "when_to_use": "- Vague or ambiguous user requests requiring clarification\n- Multi-step workflows where underlying intent is unclear\n- First principles decomposition of complex requests\n- Socratic questioning to uncover hidden constraints\n- Probabilistic intent mapping with <80% confidence requiring clarification",
        "when_not_to_use": "- Clear, actionable requests with explicit requirements (>90% confidence)\n- Simple single-step tasks with no ambiguity\n- When speed is prioritized over thorough understanding\n- Follow-up questions where context already established",
        "success_criteria": "- Understood intent with 85%+ confidence score\n- Explicit and implicit constraints identified\n- Ambiguities resolved through Socratic clarification\n- User confirms optimized request matches true intent\n- First principles decomposition reveals underlying goals",
        "edge_cases": "- User says 'just do it': flag low confidence, proceed with caveats\n- Contradictory requirements: surface conflict, request prioritization\n- Unstated assumptions: probe with questions, validate inferences\n- Multiple valid interpretations: present options, ask user to choose\n- Domain-specific jargon: verify technical terms match user's mental model",
        "guardrails": "- NEVER proceed with <80% confidence without clarification\n- ALWAYS distinguish explicit constraints (stated) from implicit (inferred)\n- NEVER assume user's technical level (ask if terminology unclear)\n- ALWAYS present optimized request for user confirmation\n- NEVER skip first principles decomposition for complex requests",
        "evidence_based": "- Validate confidence score: recompute from constraint clarity, goal specificity\n- Cross-check assumptions: ask follow-up targeting low-confidence areas\n- Test optimized request: does it capture all explicit + implicit constraints?\n- Verify first principles: can you explain WHY each requirement exists?\n- Confirm user alignment: show decomposition, get explicit approval"
    },
    "interactive-planner": {
        "when_to_use": "- Gathering comprehensive requirements through structured multi-select questions\n- Architecture decisions requiring user input on frameworks, databases, deployment\n- Feature planning when user preferences unknown (auth methods, UI libraries)\n- Reducing assumption-based planning by collecting explicit choices upfront\n- When playbook routing requires clarification of technical stack",
        "when_not_to_use": "- Requirements already well-defined (skip to planner skill)\n- Single-choice decisions (not multi-select scenarios)\n- When speed prioritized over comprehensive gathering\n- Follow-up planning where context established",
        "success_criteria": "- User answers 5-10 multi-select questions covering key decisions\n- All critical choices captured (framework, database, auth, deployment, testing)\n- Plan generated reflects user selections (no misaligned assumptions)\n- User confirms plan matches intent before execution\n- Requirements document exported with all selections",
        "edge_cases": "- User unsure of options: provide explanations, suggest defaults\n- Too many questions: group related choices, prioritize critical decisions\n- Contradictory selections: flag conflicts, ask for resolution\n- Missing options: allow custom user input for unlisted choices\n- Technical jargon: simplify language, provide examples",
        "guardrails": "- NEVER assume technical choices without asking (framework, database, cloud provider)\n- ALWAYS provide option explanations for non-experts\n- NEVER overwhelm with >15 questions (prioritize top 5-10)\n- ALWAYS export requirements document after gathering\n- NEVER proceed to planning without user confirmation of selections",
        "evidence_based": "- Validate coverage: did questions capture all critical decisions?\n- Cross-check consistency: are selections compatible (e.g., React + Express)?\n- Test plan alignment: does generated plan use selected options?\n- Verify user understanding: were explanations clear, choices informed?\n- Confirm completeness: are there unstated requirements still missing?"
    },
    "research-driven-planning": {
        "when_to_use": "- Complex features requiring research before implementation (Three-Loop System Loop 1)\n- High-risk projects needing pre-mortem analysis (5x cycles)\n- Multi-agent consensus planning with >97% accuracy requirements\n- When best practices research is needed before committing to architecture\n- Strategic planning requiring Gemini Search for SOTA investigation",
        "when_not_to_use": "- Simple features with known solutions (use simple-feature-implementation)\n- When speed prioritized over rigorous planning (<4 hour deadline)\n- Well-understood domains with established patterns (skip research phase)\n- Prototyping without production requirements",
        "success_criteria": "- Research phase complete with 3-5+ credible sources analyzed\n- 5 pre-mortem cycles executed, failure modes identified\n- Multi-agent consensus achieved (3+ agents agree on plan)\n- Plan accuracy >97% (validated against similar past projects)\n- Best practices documented with citations\n- Dependencies and parallelization strategy clearly defined",
        "edge_cases": "- Limited research sources: expand to Tier 3 (expert blogs), flag limitations\n- Pre-mortem reveals insurmountable risks: escalate to user, suggest alternatives\n- Agent consensus fails: use voting mechanism, document dissent\n- Rapidly changing best practices: prioritize recent sources (2023+), flag currency\n- Complex dependencies: use dependency graph visualization, verify no cycles",
        "guardrails": "- NEVER skip research phase for unfamiliar technologies\n- ALWAYS execute 5 pre-mortem cycles (identify failure modes proactively)\n- NEVER proceed without multi-agent consensus (minimum 3 agents)\n- ALWAYS validate plan accuracy against historical data (>95% threshold)\n- NEVER assume best practices without citations (use Gemini Search)",
        "evidence_based": "- Validate research completeness: did you cover all critical aspects (security, performance, scalability)?\n- Cross-check pre-mortem coverage: were all major failure modes addressed?\n- Test consensus validity: do agents agree on root assumptions, not just surface plan?\n- Verify plan accuracy: compare to similar projects, check historical success rate\n- Confirm source recency: are best practices current (published within 2 years)?"
    },
    "rapid-idea-generator": {
        "when_to_use": "- Brainstorming research directions after literature synthesis\n- Generating 10+ novel hypotheses from identified research gaps\n- Rapid ideation for grant proposals or project pitches\n- Exploring alternative approaches when initial methods fail\n- Creative divergent thinking for problem-solving",
        "when_not_to_use": "- When rigorous validation required immediately (use method-development)\n- Single-idea deep dives (use researcher skill for focused investigation)\n- Production code generation (use feature-dev-complete)\n- When novelty is not the primary goal",
        "success_criteria": "- 10+ distinct ideas generated per session\n- Ideas directly address identified research gaps\n- Each idea includes testable hypothesis and expected outcome\n- Feasibility assessment provided (quick vs long-term)\n- Citations to supporting literature included",
        "edge_cases": "- No research gaps identified: broaden literature search, explore adjacent fields\n- Ideas too similar: apply forced constraints (different modalities, opposite assumptions)\n- Infeasible ideas: flag as long-term, suggest simpler variants\n- Low novelty: cross-check against SOTA, ensure true gap exists\n- Over-ambitious scope: break into sub-ideas, prioritize quick wins",
        "guardrails": "- NEVER generate ideas without grounding in research gaps\n- ALWAYS provide testable hypotheses (falsifiable predictions)\n- NEVER claim novelty without literature verification\n- ALWAYS assess feasibility (computational cost, data requirements)\n- NEVER skip expected outcome specification",
        "evidence_based": "- Validate novelty: search for similar ideas in literature (Semantic Scholar)\n- Test hypothesis clarity: can it be tested experimentally with clear success criteria?\n- Verify gap alignment: does idea directly address documented research gap?\n- Check feasibility: are required resources (data, compute, time) realistic?\n- Confirm testability: can hypothesis be falsified with available methods?"
    },
    "rapid-manuscript-drafter": {
        "when_to_use": "- Drafting academic papers for NeurIPS/ICML/CVPR submission\n- Generating research papers from completed Deep Research SOP pipelines\n- Creating reproducibility reports with ACM artifact badging\n- Writing technical reports with comprehensive methodology documentation\n- Preparing grant proposals requiring academic rigor",
        "when_not_to_use": "- Blog posts or non-academic writing (use documentation skills)\n- When full Deep Research SOP has not been completed\n- Informal technical documentation (use comprehensive-documentation)\n- When peer review is not the target venue",
        "success_criteria": "- Complete manuscript with standard sections (Abstract, Intro, Related Work, Methods, Results, Discussion, Conclusion)\n- All claims cited with proper references (BibTeX generated)\n- Figures and tables properly formatted (captions, labels)\n- Reproducibility section included (code, data, hyperparameters)\n- Word count matches venue requirements (8 pages NeurIPS, 12 CVPR)\n- LaTeX source compiles without errors",
        "edge_cases": "- Over page limit: prioritize core contributions, move details to appendix\n- Missing experimental results: flag incomplete sections, suggest placeholder data\n- Weak related work: expand literature synthesis, add 10+ recent papers\n- Unclear methodology: add algorithmic pseudocode, detailed architecture diagrams\n- Insufficient ablations: document need for additional experiments",
        "guardrails": "- NEVER submit drafts with uncited claims (verify all assertions have references)\n- ALWAYS include reproducibility section (code, data, hyperparameters, seeds)\n- NEVER fabricate experimental results (use real data from method-development)\n- ALWAYS verify venue formatting guidelines (check template, page limits)\n- NEVER skip statistical validation (p-values, CIs, effect sizes)",
        "evidence_based": "- Validate citation completeness: search for all claims, verify references exist\n- Cross-check reproducibility: can experiments be rerun from manuscript alone?\n- Test figure quality: are plots high-resolution (300+ DPI), axes labeled, legends clear?\n- Verify statistical rigor: are all p-values, CIs, effect sizes reported?\n- Confirm template compliance: does LaTeX compile, match venue style exactly?"
    },
    "research-gap-visualizer": {
        "when_to_use": "- Visualizing research gaps identified from literature synthesis\n- Creating 2D/3D plots of method vs. dataset coverage\n- Generating heatmaps showing unexplored method combinations\n- Producing publication-ready figures for grant proposals\n- Analyzing trends in research focus over time",
        "when_not_to_use": "- When raw text descriptions are sufficient (no visualization needed)\n- Single-dimensional gaps (simple list format works)\n- When time constrained (<30 min, skip visualization)\n- Non-academic audiences unfamiliar with research visualizations",
        "success_criteria": "- High-resolution publication-ready figures (300+ DPI)\n- Clear axis labels, legends, and titles\n- Color scheme accessible (colorblind-friendly)\n- Gap areas clearly highlighted (red for unexplored, green for saturated)\n- Source data included (CSV/JSON for reproducibility)",
        "edge_cases": "- Too many dimensions: use PCA/t-SNE for dimensionality reduction\n- Sparse data: adjust visualization type (scatter plot vs heatmap)\n- Unclear gaps: add annotations explaining why areas unexplored\n- Complex taxonomy: simplify groupings, use hierarchical clustering\n- Overlapping labels: increase figure size, rotate text, use abbreviations",
        "guardrails": "- NEVER use misleading visualizations (cherry-picked axes, truncated scales)\n- ALWAYS include colorblind-friendly palettes (viridis, not rainbow)\n- NEVER omit axis labels, units, or legends\n- ALWAYS provide source data for reproducibility\n- NEVER use 3D when 2D suffices (avoid chart junk)",
        "evidence_based": "- Validate data accuracy: cross-check plotted values against source tables\n- Test colorblind accessibility: use simulators (Coblis, Color Oracle)\n- Verify label clarity: are all abbreviations explained in caption?\n- Check resolution: export at 300+ DPI, zoom to verify sharpness\n- Confirm reproducibility: can figure be regenerated from provided source data?"
    },
    "research-publication": {
        "when_to_use": "- Submitting papers to NeurIPS/ICML/CVPR/ICCV/ECCV conferences\n- Managing peer review process (responding to reviewers)\n- Preparing camera-ready versions with final formatting\n- Publishing reproducibility packages (ACM artifact badging)\n- Archiving research artifacts for long-term availability",
        "when_not_to_use": "- Preprint-only publications (use arXiv upload directly)\n- Industry blog posts (use documentation skills)\n- Internal technical reports (use rapid-manuscript-drafter)\n- When full peer review not required",
        "success_criteria": "- Paper submitted to target venue with all required files (PDF, source, supplementary)\n- Reproducibility package published (GitHub, Zenodo, ACM DL)\n- Reviewer responses drafted addressing all comments\n- Camera-ready version uploaded meeting all formatting requirements\n- Artifacts archived with permanent DOIs (Zenodo, FigShare)",
        "edge_cases": "- Desk rejection: verify venue fit, check submission guidelines, resubmit elsewhere\n- Major revisions: address all reviewer concerns, add requested experiments\n- Missing reproducibility materials: package code, data, hyperparameters retroactively\n- Formatting errors: use venue template exactly, validate with LaTeXdiff\n- License conflicts: clarify data licensing, use permissive licenses (MIT, Apache 2.0)",
        "guardrails": "- NEVER ignore reviewer comments (address every point explicitly)\n- ALWAYS publish reproducibility packages (code, data, pre-trained models)\n- NEVER violate venue anonymity requirements (blind submissions, no self-citations)\n- ALWAYS archive with permanent identifiers (DOI, arXiv ID)\n- NEVER use proprietary data without clearance (verify licensing)",
        "evidence_based": "- Validate submission completeness: checklist includes PDF, source, supplementary, metadata\n- Cross-check reviewer responses: did you address all comments point-by-point?\n- Test reproducibility package: can independent party rerun experiments from package alone?\n- Verify camera-ready formatting: does LaTeX compile, match template exactly?\n- Confirm archival: are DOIs permanent, artifacts publicly accessible?"
    },
    "visual-asset-generator": {
        "when_to_use": "- Creating publication-ready figures for academic papers\n- Generating architecture diagrams for neural network models\n- Producing workflow visualizations for methodology sections\n- Designing infographics for grant proposals or presentations\n- Creating high-resolution plots for experimental results",
        "when_not_to_use": "- Quick sketches or whiteboard diagrams (use manual drawing)\n- When existing templates suffice (use standard matplotlib/seaborn)\n- Non-academic visualizations (use general design tools)\n- When time constrained (<1 hour, use pre-made assets)",
        "success_criteria": "- High-resolution publication-ready assets (300+ DPI, vector formats)\n- Clear labels, legends, and captions\n- Colorblind-friendly palettes (viridis, cividis)\n- Consistent style across all figures (fonts, colors, line widths)\n- Source files included (SVG, PDF, Python/R scripts)",
        "edge_cases": "- Complex architectures: use hierarchical layouts, group related components\n- Too much detail: simplify non-critical elements, use zoomed insets\n- Unclear flow: add arrows, numbers, or annotations guiding reader\n- Overlapping elements: adjust spacing, use semi-transparency\n- Inconsistent styling: create style guide, apply globally",
        "guardrails": "- NEVER use raster formats for diagrams (use SVG, PDF, not PNG/JPG)\n- ALWAYS include captions explaining what figure shows\n- NEVER use default matplotlib colors (not colorblind-friendly)\n- ALWAYS provide source code for reproducibility (Python, R, TikZ)\n- NEVER omit scale bars, axis units, or legends",
        "evidence_based": "- Validate resolution: export at 300+ DPI, zoom to verify sharpness\n- Test colorblind accessibility: use simulators (Coblis, Color Oracle)\n- Verify label clarity: are all abbreviations explained in caption?\n- Check consistency: do all figures use same fonts, colors, styles?\n- Confirm reproducibility: can figure be regenerated from provided source code?"
    },
    "when-gathering-requirements-use-interactive-planner": {
        "when_to_use": "- Triggering interactive-planner skill when gathering requirements detected\n- Auto-invoking structured multi-select questions for architecture decisions\n- Ensuring comprehensive requirements collection before planning\n- Reducing assumption-based design by collecting explicit user choices\n- Specialized tool wrapper for requirements gathering scenarios",
        "when_not_to_use": "- Requirements already defined (skip to planner)\n- Single-choice decisions (not multi-select)\n- When interactive-planner already invoked directly\n- Follow-up scenarios where context exists",
        "success_criteria": "- Interactive-planner skill successfully invoked\n- User presented with 5-10 multi-select questions\n- All critical choices captured before planning proceeds\n- Requirements document exported\n- Plan reflects user selections accurately",
        "edge_cases": "- User bypasses questions: respect preference, document assumptions made\n- Skill invocation fails: fallback to manual requirements gathering\n- Too many nested tool calls: simplify to direct interactive-planner invocation\n- Contradictory selections: flag for resolution before proceeding\n- Missing context: gather minimal required info before invoking",
        "guardrails": "- NEVER invoke if interactive-planner already active (avoid recursion)\n- ALWAYS verify requirements gathering truly needed\n- NEVER force questions if user has clear requirements\n- ALWAYS respect user preference to skip\n- NEVER proceed to planning without confirmation",
        "evidence_based": "- Validate invocation appropriateness: is requirements gathering truly needed?\n- Cross-check skill availability: is interactive-planner accessible?\n- Test user intent: does user want structured questions or prefer freeform?\n- Verify context: is this right moment to invoke (not mid-execution)?\n- Confirm fallback: if invocation fails, can manual gathering proceed?"
    }
}

def create_improvement_section(improvements):
    """Generate the improvement section text"""
    return f"""
## SKILL-SPECIFIC GUIDANCE

### When to Use This Skill
{improvements['when_to_use']}

### When NOT to Use This Skill
{improvements['when_not_to_use']}

### Success Criteria
{improvements['success_criteria']}

### Edge Cases & Limitations
{improvements['edge_cases']}

### Critical Guardrails
{improvements['guardrails']}

### Evidence-Based Validation
{improvements['evidence_based']}

---
"""

def find_yaml_start(lines):
    """Find line number where YAML frontmatter starts (name: field)"""
    for i, line in enumerate(lines):
        if re.match(r'^name:\s+', line):
            return i
    return None

def apply_improvements(skill_path, skill_name, improvements):
    """Apply improvements to a single SKILL.md file"""
    try:
        # Read original content
        with open(skill_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        # Backup
        backup_path = BACKUP_DIR / f"{skill_name}-SKILL.md"
        shutil.copy2(skill_path, backup_path)

        # Find YAML frontmatter start
        yaml_start = find_yaml_start(lines)
        if yaml_start is None:
            print(f"  [SKIP] Could not find YAML frontmatter in: {skill_name}")
            return False

        # Insert improvement section before YAML frontmatter
        improvement_text = create_improvement_section(improvements)
        new_lines = lines[:yaml_start] + [improvement_text] + lines[yaml_start:]

        # Write back
        with open(skill_path, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)

        print(f"  [OK] Applied improvements to: {skill_name}")
        return True
    except Exception as e:
        print(f"  [ERROR] Failed to process {skill_name}: {str(e)}")
        return False

def main():
    """Main execution"""
    print("=== RESEARCH SKILL IMPROVEMENT APPLICATOR (ALL 14 SKILLS) ===")
    print(f"Backup directory: {BACKUP_DIR}")
    print()

    # Create backup directory
    BACKUP_DIR.mkdir(parents=True, exist_ok=True)

    processed_count = 0
    success_count = 0

    # Process each skill
    for skill_name, improvements in IMPROVEMENTS.items():
        # Handle nested path for specialized-tools
        if skill_name == "when-gathering-requirements-use-interactive-planner":
            skill_path = RESEARCH_DIR / "specialized-tools" / skill_name / "SKILL.md"
        else:
            skill_path = RESEARCH_DIR / skill_name / "SKILL.md"

        if skill_path.exists():
            processed_count += 1
            if apply_improvements(skill_path, skill_name, improvements):
                success_count += 1
        else:
            print(f"  [SKIP] Not found: {skill_name}")

    print()
    print("=== SUMMARY ===")
    print(f"Processed: {success_count}/{processed_count} SKILL.md files successfully")
    print(f"Backup location: {BACKUP_DIR}")
    print()
    print("Changes applied:")
    print("  - When to Use section (research-specific triggers)")
    print("  - When NOT to Use section (anti-patterns, exclusions)")
    print("  - Success Criteria (measurable outcomes)")
    print("  - Edge Cases & Limitations (failure modes, constraints)")
    print("  - Critical Guardrails (research ethics, methodology)")
    print("  - Evidence-Based Validation (verification techniques)")
    print()
    print(f"Total skills updated: {success_count}/14")
    print()
    print("To verify changes:")
    print(f"  diff {BACKUP_DIR}/literature-synthesis-SKILL.md \\")
    print(f"       {RESEARCH_DIR}/literature-synthesis/SKILL.md")

if __name__ == "__main__":
    main()
