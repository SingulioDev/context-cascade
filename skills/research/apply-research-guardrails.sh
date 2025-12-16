#!/bin/bash

# Apply Research-Domain Prompt Improvements to All .md Files
# Uses sed-only approach for Windows compatibility

RESEARCH_DIR="C:/Users/17175/claude-code-plugins/ruv-sparc-three-loop-system/skills/research"
PROCESSED_COUNT=0

# Function to generate role-specific guardrails based on file content
generate_guardrails() {
    local filepath="$1"
    local filename=$(basename "$filepath")
    local dirname=$(basename $(dirname "$filepath"))

    # Detect role from filename/path
    if echo "$filepath" | grep -q "literature-synthesis\|baseline-replication\|method-development"; then
        echo "
## CRITICAL RESEARCH GUARDRAILS (EVIDENCE-BASED)

**NEVER** claim facts without citations. Every claim MUST include:
- Source identification (author, publication, date)
- Direct quote or paraphrased evidence
- Page/section number when applicable
- URL or DOI for digital sources

**ALWAYS** verify source credibility before citing:
- Check author credentials and institutional affiliation
- Verify publication venue (peer-reviewed journal, conference tier)
- Cross-reference with multiple independent sources
- Apply 90%+ credibility threshold for academic work

**NEVER** skip methodology documentation:
- Document search strategy (databases, keywords, date ranges)
- Record inclusion/exclusion criteria explicitly
- Report sample sizes and statistical power
- Include reproducibility details (random seeds, versions)

**ALWAYS** acknowledge limitations:
- Report conflicts of interest or funding sources
- Identify gaps in data or methodology
- Disclose assumptions and their implications
- Note generalization boundaries

**Statistical Rigor Required**:
- Report effect sizes (Cohen's d, eta-squared)
- Include confidence intervals (95% CI)
- Apply multiple comparison corrections (Bonferroni, FDR)
- Verify statistical power (1-beta >= 0.8)

**Reproducibility Standards**:
- Exact hyperparameter specifications
- Random seed documentation
- Framework version pinning
- Hardware specifications
- Dataset checksums (SHA256)
"
    elif echo "$filepath" | grep -q "researcher\|intent-analyzer\|interactive-planner"; then
        echo "
## RESEARCH ANALYSIS GUARDRAILS

**Source Verification Required**:
- NEVER cite sources without verification
- ALWAYS check publication date and relevance
- Verify author credentials and expertise
- Cross-reference claims with multiple sources

**Credibility Scoring**:
- Tier 1 (90-100%): Peer-reviewed, official docs
- Tier 2 (75-89%): Industry reports, credible news
- Tier 3 (60-74%): Expert blogs, technical forums
- Tier 4 (<60%): Unverified, opinion pieces
- REJECT sources below threshold

**Evidence-Based Reasoning**:
- Support claims with concrete evidence
- Distinguish facts from interpretations
- Identify and disclose biases
- Report contradictory evidence when found

**Documentation Standards**:
- Provide full citations (APA, IEEE, or ACM format)
- Include access dates for web sources
- Link to primary sources when available
- Archive sources for reproducibility
"
    elif echo "$filepath" | grep -q "deep-research-orchestrator"; then
        echo "
## DEEP RESEARCH SOP GUARDRAILS

**Quality Gate Compliance**:
- Gate 1: Literature synthesis (50+ papers, PRISMA-compliant)
- Gate 2: Model validation (statistical significance p<0.05)
- Gate 3: Production readiness (reproducibility verified)

**Systematic Review Standards**:
- PRISMA 2020 compliance required
- Document search protocol explicitly
- Report screening at each stage
- Include flow diagram
- Conduct bias assessment

**Experimental Rigor**:
- Pre-register hypotheses before experiments
- Document all deviations from protocol
- Report all outcomes (positive and negative)
- Include failed experiments in methodology
- Apply registered reports framework

**Ethics Review Required**:
- Safety risk assessment
- Fairness and bias evaluation
- Privacy impact analysis
- Dual-use considerations
- Stakeholder impact review

**Archival Standards**:
- Complete reproducibility package
- Dataset documentation (datasheets)
- Model cards for all models
- Code with 100% test coverage
- Docker containerization
"
    elif echo "$filepath" | grep -q "examples\|tests"; then
        echo "
## EXAMPLE/TEST GUARDRAILS

**Realistic Scenarios Required**:
- Use real-world data characteristics
- Avoid trivial toy examples
- Include edge cases and failures
- Document expected vs actual outcomes

**Source Attribution**:
- Cite source of example data
- Acknowledge borrowed code/techniques
- Reference methodology origins
- Credit original authors

**Reproducibility**:
- Provide complete code examples
- Include environment specifications
- Document dependencies
- Add expected output
"
    else
        # Generic research guardrails
        echo "
## RESEARCH METHODOLOGY GUARDRAILS

**Citation Requirements**:
- NEVER make unsupported claims
- ALWAYS cite sources for facts
- Provide complete bibliographic information
- Use consistent citation format

**Source Quality**:
- Verify credibility before citing
- Prefer peer-reviewed sources
- Cross-reference multiple sources
- Report source tier and confidence

**Transparency Standards**:
- Document methodology explicitly
- Acknowledge limitations
- Disclose assumptions
- Report negative results

**Evidence-Based Practice**:
- Support claims with data
- Use statistical validation
- Apply reproducibility standards
- Follow domain-specific SOPs
"
    fi
}

# Process each .md file
find "$RESEARCH_DIR" -type f -name "*.md" ! -name "README.md" | while read -r filepath; do
    echo "Processing: $filepath"

    # Generate guardrails for this file
    guardrails=$(generate_guardrails "$filepath")

    # Create temporary file with guardrails inserted after line 1
    # Use sed to insert after first line (frontmatter header)
    tmpfile="${filepath}.tmp"

    # Read first line
    head -n 1 "$filepath" > "$tmpfile"

    # Append guardrails (escaped for sed)
    echo "$guardrails" >> "$tmpfile"

    # Append rest of file (from line 2 onwards)
    tail -n +2 "$filepath" >> "$tmpfile"

    # Replace original
    mv "$tmpfile" "$filepath"

    ((PROCESSED_COUNT++))
    echo "  -> Guardrails applied"
done

echo ""
echo "======================================"
echo "PROCESSING COMPLETE"
echo "======================================"
echo "Total files processed: $PROCESSED_COUNT"
echo ""
echo "Guardrails applied to all .md files in:"
echo "$RESEARCH_DIR"
