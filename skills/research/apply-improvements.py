#!/usr/bin/env python3
"""
Apply SKILL-SPECIFIC prompt improvements to ALL research SKILL.md files
Inserts after line 40 (after CRITICAL RESEARCH GUARDRAILS, before YAML frontmatter)
"""

import os
import shutil
from datetime import datetime
from pathlib import Path

RESEARCH_DIR = Path("C:/Users/17175/claude-code-plugins/ruv-sparc-three-loop-system/skills/research")
TIMESTAMP = datetime.now().strftime("%Y%m%d-%H%M%S")
BACKUP_DIR = RESEARCH_DIR / f".backup-{TIMESTAMP}"

# Skill-specific improvements
IMPROVEMENTS = {
    "literature-synthesis": {
        "when_to_use": """- Academic research requiring systematic literature review (PRISMA-compliant)
- SOTA analysis for Deep Research SOP Phase 1
- Identifying research gaps and opportunities for novel methods
- Preparing related work sections for academic papers
- Validating novelty claims with 50+ peer-reviewed sources""",
        "when_not_to_use": """- Quick fact-checking or single-paper summaries (use researcher skill instead)
- Non-academic contexts (industry reports, blog posts)
- When <50 papers are sufficient for the research question
- Time-constrained projects requiring <1 week turnaround""",
        "success_criteria": """- Minimum 50 papers reviewed (Quality Gate 1 requirement)
- PRISMA flow diagram generated with screening rationale
- SOTA benchmarks extracted and tabulated
- Research gaps identified with 3+ supporting citations
- BibTeX database created with complete metadata
- All claims cross-referenced with 2+ independent sources""",
        "edge_cases": """- Paywalled papers: Check institutional access, contact authors, use preprints
- Conflicting results: Report both sides, analyze methodology differences
- Rapidly evolving fields (e.g., LLMs): Expand to preprints (arXiv), track citations
- Limited dataset access: Document as limitation, suggest alternatives
- Outdated SOTA: Verify publication dates, check for newer methods""",
        "guardrails": """- NEVER claim research gaps without systematic evidence (show search strategy)
- ALWAYS document inclusion/exclusion criteria before screening
- NEVER cherry-pick papers supporting a hypothesis (report contradictory evidence)
- ALWAYS verify publication venue tier (check h-index, acceptance rates)
- NEVER skip quality assessment (use CASP checklist for qualitative studies)""",
        "evidence_based": """- Validate search strategy reproducibility: Rerun queries, verify result counts match
- Cross-validate SOTA benchmarks: Check Papers with Code, official leaderboards
- Verify citation accuracy: Match title/author/year against original source
- Test research gap validity: Search for contradictory evidence actively
- Confirm PRISMA compliance: Use official checklist, report all 27 items"""
    },
    "baseline-replication": {
        "when_to_use": """- Validating published ML baselines before novel method development (Deep Research SOP Pipeline D)
- Reproducing experiments for NeurIPS/ICML reproducibility challenges
- Verifying SOTA claims before building on prior work
- Creating reproducibility packages for Quality Gate 1
- Debugging performance gaps between published and reproduced results""",
        "when_not_to_use": """- Quick proof-of-concept implementations (use prototyping playbook)
- When exact reproducibility is not critical (e.g., demo projects)
- Papers without published code or detailed methodology
- Industry benchmarks without academic rigor requirements""",
        "success_criteria": """- Results within +/- 1% of published metrics (statistical tolerance)
- 3+ successful reproductions in fresh Docker environments
- All 47+ hyperparameters documented and validated
- Reproducibility package tested by independent party
- Dataset checksums verified (SHA256)
- Random seeds documented and deterministic results achieved""",
        "edge_cases": """- Missing hyperparameters: Check GitHub issues, contact authors, search supplements
- Framework version mismatches: Test PyTorch 1.7 vs 1.13, document numerical differences
- Hardware differences: V100 vs A100 precision, document in reproducibility notes
- Non-deterministic operations: Force torch.use_deterministic_algorithms(True)
- Dataset preprocessing ambiguity: Compare sample outputs, validate checksums""",
        "guardrails": """- NEVER claim reproduction success without statistical validation (t-test, CI)
- ALWAYS document exact framework versions (pip freeze, conda list --export)
- NEVER skip random seed validation (test determinism with 3+ runs)
- ALWAYS verify dataset integrity (SHA256, sample counts, split ratios)
- NEVER assume default hyperparameters (extract all from paper/code explicitly)""",
        "evidence_based": """- Validate determinism: Run 3 times, verify identical results (variance = 0)
- Cross-validate metrics: Recompute from saved outputs, compare to paper
- Test fresh environment: Build Docker from scratch, verify no cached dependencies
- Verify statistical power: Calculate required sample size, check reported N
- Confirm effect size: Compute Cohen's d, verify practical significance"""
    },
    "researcher": {
        "when_to_use": """- Multi-source investigation requiring 3-5+ credible sources (Level 2-3 research)
- Technical documentation analysis with credibility scoring (>85%)
- Cross-referencing claims across industry reports, academic papers, official docs
- Building knowledge bases for unfamiliar technologies or domains
- Systematic information gathering with comprehensive source evaluation""",
        "when_not_to_use": """- Single-source quick lookups (use web search directly)
- Non-technical questions not requiring credibility analysis
- When speed is prioritized over source verification (<5 min deadline)
- Opinion-based topics without objective truth (use judgment, not research)""",
        "success_criteria": """- 90%+ average credibility score across all cited sources
- 3+ independent sources corroborate key claims
- All sources annotated with credibility breakdown (Authority, Accuracy, Objectivity, Currency, Coverage)
- Contradictory evidence reported and analyzed
- Full citations provided (APA/IEEE/ACM format with access dates)""",
        "edge_cases": """- Paywalled sources: Use institutional access, preprints, contact authors
- Conflicting expert opinions: Present both sides, analyze methodology/bias
- Rapidly changing topics (AI, crypto): Prioritize Currency (15%), accept lower coverage
- Niche topics with limited sources: Expand to Tier 3 (expert blogs), disclose limitations
- Biased sources: Flag bias score, require 3+ independent corroborations""",
        "guardrails": """- NEVER cite without credibility scoring (use 0-100% rubric)
- ALWAYS cross-reference claims with 2+ independent Tier 1/2 sources
- NEVER accept <70% credibility sources without explicit disclosure
- ALWAYS distinguish facts (verifiable) from interpretations (opinion)
- NEVER skip source publication date verification (check Currency dimension)""",
        "evidence_based": """- Validate source authority: Check author credentials (H-index, institutional affiliation)
- Cross-validate factual claims: Search for contradictory evidence actively
- Verify objectivity: Check funding sources, conflicts of interest
- Test currency: Compare publication date to topic evolution, flag outdated info
- Confirm coverage: Verify comprehensive treatment vs. surface-level overview"""
    }
}

# Add more skills with same pattern (method-development, deep-research-orchestrator, etc.)
# For brevity, showing 3 complete examples above

def create_improvement_section(skill_name, improvements):
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

def apply_improvements(skill_path, skill_name, improvements):
    """Apply improvements to a single SKILL.md file"""
    # Read original content
    with open(skill_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Backup
    backup_path = BACKUP_DIR / f"{skill_name}-SKILL.md"
    shutil.copy2(skill_path, backup_path)

    # Insert improvement section after line 40
    improvement_text = create_improvement_section(skill_name, improvements)
    new_lines = lines[:40] + [improvement_text] + lines[40:]

    # Write back
    with open(skill_path, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)

    print(f"  [OK] Applied improvements to: {skill_name}")
    return True

def main():
    """Main execution"""
    print("=== RESEARCH SKILL IMPROVEMENT APPLICATOR ===")
    print(f"Backup directory: {BACKUP_DIR}")
    print()

    # Create backup directory
    BACKUP_DIR.mkdir(parents=True, exist_ok=True)

    processed_count = 0

    # Process each skill
    for skill_name, improvements in IMPROVEMENTS.items():
        skill_path = RESEARCH_DIR / skill_name / "SKILL.md"
        if skill_path.exists():
            apply_improvements(skill_path, skill_name, improvements)
            processed_count += 1
        else:
            print(f"  [SKIP] Not found: {skill_name}")

    print()
    print("=== SUMMARY ===")
    print(f"Processed: {processed_count} SKILL.md files")
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
    print("To verify changes, check:")
    print(f"  {BACKUP_DIR}/")

if __name__ == "__main__":
    main()
