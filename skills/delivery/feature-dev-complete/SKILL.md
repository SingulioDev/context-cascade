---
name: feature-dev-complete
description: Complete feature development lifecycle from research to deployment. Uses
  Gemini Search for best practices, architecture design, Codex prototyping, comprehensive
  testing, and documentation generation. Full 12-stage workflow.
tags:
- feature
- development
- lifecycle
- multi-model
- essential
- tier-1
version: 1.0.0
category: delivery
author: ruv
---

# Feature Development Complete


## When to Use This Skill

- **Full Feature Development**: Complete end-to-end feature implementation
- **Greenfield Features**: Building new functionality from scratch
- **Research Required**: Features needing best practice research
- **Multi-Layer Changes**: Features spanning frontend, backend, database
- **Production Deployment**: Features requiring full testing and documentation
- **Architecture Design**: Features needing upfront design decisions

## When NOT to Use This Skill

- **Bug Fixes**: Use debugging or smart-bug-fix skills instead
- **Quick Prototypes**: Exploratory coding without production requirements
- **Refactoring**: Code restructuring without new features
- **Documentation Only**: Pure documentation tasks

## Success Criteria

- [ ] Feature fully implemented across all layers
- [ ] Unit tests passing with >80% coverage
- [ ] Integration tests passing
- [ ] E2E tests passing (if applicable)
- [ ] Code reviewed and approved
- [ ] Documentation complete (API docs, user guides)
- [ ] Performance benchmarks met
- [ ] Security review passed
- [ ] Deployed to staging and validated

## Edge Cases to Handle

- **Legacy Integration**: Interfacing with old code or deprecated APIs
- **Breaking Changes**: Features requiring API versioning or migrations
- **Feature Flags**: Gradual rollout or A/B testing requirements
- **Data Migration**: Schema changes requiring backfill scripts
- **Third-Party Dependencies**: External API rate limits or availability
- **Browser Compatibility**: Cross-browser testing requirements

## Guardrails

- **NEVER** skip testing phases to ship faster
- **ALWAYS** research best practices before implementing
- **NEVER** commit directly to main - use feature branches
- **ALWAYS** write tests before or during implementation (TDD)
- **NEVER** hardcode configuration - use environment variables
- **ALWAYS** document architectural decisions (ADRs)
- **NEVER** deploy without staging validation

## Evidence-Based Validation

- [ ] All automated tests passing (npm test / pytest)
- [ ] Code coverage reports reviewed
- [ ] Lighthouse score meets thresholds (if web)
- [ ] Load testing validates performance targets
- [ ] Security scan shows no critical vulnerabilities
- [ ] Accessibility audit passes (axe, WAVE)
- [ ] Manual testing on target devices/browsers

## Purpose

Execute complete feature development lifecycle using multi-model AI orchestration.

## Specialist Agent

I am a full-stack development coordinator using multi-model orchestration.

**Methodology** (Complete Lifecycle Pattern):
1. Research best practices (Gemini Search)
2. Analyze existing patterns (Gemini MegaContext)
3. Design architecture (Claude Architect)
4. Generate diagrams (Gemini Media)
5. Rapid prototype (Codex Auto)
6. Comprehensive testing (Codex Iteration)
7. Style polish (Claude)
8. Documentation (Multi-model)
9. Performance optimization
10. Security review
11. Create PR with comprehensive report
12. Deploy readiness check

**Models Used**:
- **Gemini Search**: Latest best practices, framework updates
- **Gemini MegaContext**: Large codebase pattern analysis
- **Gemini Media**: Architecture diagrams, flow charts
- **Claude**: Architecture design, testing strategy
- **Codex**: Rapid prototyping, auto-fixing
- **All models**: Documentation generation

## Input Contract

```yaml
input:
  feature_spec: string (feature description, required)
  target_directory: string (default: src/)
  create_pr: boolean (default: true)
  deploy_after: boolean (default: false)
```

## Output Contract

```yaml
output:
  artifacts:
    research: markdown (best practices)
    architecture: markdown (design doc)
    diagrams: array[image] (visual docs)
    implementation: directory (code)
    tests: directory (test suite)
    documentation: markdown (usage docs)
  quality:
    test_coverage: number (percentage)
    quality_score: number (0-100)
    security_issues: number
  pr_url: string (if create_pr: true)
  deployment_ready: boolean
```

## Execution Flow

```bash
#!/bin/bash
set -e

FEATURE_SPEC="$1"
TARGET_DIR="${2:-src/}"
OUTPUT_DIR="feature-$(date +%s)"

mkdir -p "$OUTPUT_DIR"

echo "================================================================"
echo "Complete Feature Development: $FEATURE_SPEC"
echo "================================================================"

# STAGE 1: Research Best Practices
echo "[1/12] Researching latest best practices..."
gemini "Latest 2025 best practices for: $FEATURE_SPEC" \
  --grounding google-search \
  --output "$OUTPUT_DIR/research.md"

# STAGE 2: Analyze Existing Codebase Patterns
echo "[2/12] Analyzing existing codebase patterns..."
LOC=$(find "$TARGET_DIR" -type f \( -name "*.js" -o -name "*.ts" \) | xargs wc -l | tail -1 | awk '{print $1}' || echo "0")

if [ "$LOC" -gt 5000 ]; then
  gemini "Analyze architecture patterns for: $FEATURE_SPEC" \
    --files "$TARGET_DIR" \
    --model gemini-2.0-flash \
    --output "$OUTPUT_DIR/codebase-analysis.md"
else
  echo "Small codebase - skipping mega-context analysis"
fi

# STAGE 3: Initialize Development Swarm
echo "[3/12] Initializing development swarm..."
npx claude-flow coordination swarm-init \
  --topology hierarchical \
  --max-agents 6 \
  --strategy balanced

# STAGE 4: Architecture Design
echo "[4/12] Designing architecture..."
# This would invoke SPARC architect in Claude Code
# For now, we document the pattern
cat > "$OUTPUT_DIR/architecture-design.md" <<EOF
# Architecture Design: $FEATURE_SPEC

## Research Findings
$(cat "$OUTPUT_DIR/research.md")

## Existing Patterns
$(cat "$OUTPUT_DIR/codebase-analysis.md" 2>/dev/null || echo "N/A")

## Proposed Architecture
[Generated by Claude Architect Agent]

## Design Decisions
[Key decisions with rationale]
EOF

# STAGE 5: Generate Architecture Diagrams
echo "[5/12] Generating architecture diagrams..."
gemini "Generate system architecture diagram for: $FEATURE_SPEC" \
  --type image \
  --output "$OUTPUT_DIR/architecture-diagram.png" \
  --style technical

gemini "Generate data flow diagram for: $FEATURE_SPEC" \
  --type image \
  --output "$OUTPUT_DIR/data-flow.png" \
  --style diagram

# STAGE 6: Rapid Prototyping
echo "[6/12] Rapid prototyping with Codex..."
codex --full-auto "Implement $FEATURE_SPEC following architecture design" \
  --context "$OUTPUT_DIR/architecture-design.md" \
  --context "$OUTPUT_DIR/research.md" \
  --sandbox true \
  --output "$OUTPUT_DIR/implementation/"

# STAGE 7: Theater Detection
echo "[7/12] Detecting placeholder code..."
npx claude-flow theater-detect "$OUTPUT_DIR/implementation/" \
  --output "$OUTPUT_DIR/theater-report.json"

THEATER_COUNT=$(cat "$OUTPUT_DIR/theater-report.json" | jq '.issues | length')
if [ "$THEATER_COUNT" -gt 0 ]; then
  echo "⚠️ Found $THEATER_COUNT placeholder items - fixing..."
  # Auto-complete theater items
  codex --full-auto "Complete all TODO and placeholder implementations" \
    --context "$OUTPUT_DIR/theater-report.json" \
    --context "$OUTPUT_DIR/implementation/" \
    --sandbox true
fi

# STAGE 8: Comprehensive Testing with Codex Iteration
echo "[8/12] Testing with Codex auto-fix..."
npx claude-flow functionality-audit "$OUTPUT_DIR/implementation/" \
  --model codex-auto \
  --max-iterations 5 \
  --sandbox true \
  --output "$OUTPUT_DIR/test-results.json"

# STAGE 9: Style Audit & Polish
echo "[9/12] Polishing code quality..."
npx claude-flow style-audit "$OUTPUT_DIR/implementation/" \
  --fix true \
  --output "$OUTPUT_DIR/style-report.json"

# STAGE 10: Security Review
echo "[10/12] Security review..."
npx claude-flow security-scan "$OUTPUT_DIR/implementation/" \
  --deep true \
  --output "$OUTPUT_DIR/security-report.json"

SECURITY_CRITICAL=$(cat "$OUTPUT_DIR/security-report.json" | jq '.critical_issues')
if [ "$SECURITY_CRITICAL" -gt 0 ]; then
  echo "🚨 Critical security issues found!"
  cat "$OUTPUT_DIR/security-report.json" | jq '.critical_issues[]'
  exit 1
fi

# STAGE 11: Documentation Generation
echo "[11/12] Generating documentation..."
cat > "$OUTPUT_DIR/FEATURE-DOCUMENTATION.md" <<EOF
# Feature Documentation: $FEATURE_SPEC

## Overview
$(cat "$OUTPUT_DIR/research.md" | head -10)

## Architecture
![Architecture Diagram](architecture-diagram.png)

## Implementation
[Code location and structure]

## Usage
[Usage examples]

## Testing
- Test Coverage: $(cat "$OUTPUT_DIR/test-results.json" | jq '.coverage_percent')%
- Tests Passing: $(cat "$OUTPUT_DIR/test-results.json" | jq '.all_passed')

## Quality Metrics
- Quality Score: $(cat "$OUTPUT_DIR/style-report.json" | jq '.quality_score')/100
- Security Issues: 0 critical

---
🤖 Generated with Claude Code Complete Feature Development
EOF

# STAGE 12: Production Readiness Check
echo "[12/12] Final production readiness check..."
TESTS_PASSED=$(cat "$OUTPUT_DIR/test-results.json" | jq '.all_passed')
QUALITY_SCORE=$(cat "$OUTPUT_DIR/style-report.json" | jq '.quality_score')
SECURITY_OK=$([ "$SECURITY_CRITICAL" -eq 0 ] && echo "true" || echo "false")

if [ "$TESTS_PASSED" = "true" ] && [ "$QUALITY_SCORE" -ge 85 ] && [ "$SECURITY_OK" = "true" ]; then
  echo "✅ Production ready!"

  # Create PR if requested
  if [ "${CREATE_PR:-true}" = "true" ]; then
    echo "Creating pull request..."
    # Copy implementation to target directory
    cp -r "$OUTPUT_DIR/implementation/"* "$TARGET_DIR/"

    # Git operations
    git add .
    git commit -m "feat: $FEATURE_SPEC

🤖 Generated with Claude Code Complete Feature Development

## Quality Metrics
- ✅ All tests passing
- ✅ Code quality: $QUALITY_SCORE/100
- ✅ Security: No critical issues
- ✅ Test coverage: $(cat "$OUTPUT_DIR/test-results.json" | jq '.coverage_percent')%

## Documentation
See $OUTPUT_DIR/FEATURE-DOCUMENTATION.md

Co-Authored-By: Claude <noreply@anthropic.com>"

    # Create PR
    gh pr create --title "feat: $FEATURE_SPEC" \
      --body-file "$OUTPUT_DIR/FEATURE-DOCUMENTATION.md"
  fi
else
  echo "⚠️ Not production ready - review issues"
  exit 1
fi

echo ""
echo "================================================================"
echo "Feature Development Complete!"
echo "================================================================"
echo ""
echo "Artifacts in: $OUTPUT_DIR/"
echo "- Research: research.md"
echo "- Architecture: architecture-design.md"
echo "- Diagrams: *.png"
echo "- Implementation: implementation/"
echo "- Tests: test-results.json"
echo "- Documentation: FEATURE-DOCUMENTATION.md"
echo ""
```

## Integration Points

### Cascades
- Standalone complete workflow
- Can be part of `/sprint-automation` cascade
- Used by `/feature-request-handler` cascade

### Commands
- Uses: `/gemini-search`, `/gemini-megacontext`, `/gemini-media`
- Uses: `/codex-auto`, `/functionality-audit`, `/style-audit`
- Uses: `/theater-detect`, `/security-scan`
- Uses: `/swarm-init`, `/auto-agent`

### Other Skills
- Invokes: `quick-quality-check`, `smart-bug-fix` (if issues found)
- Output to: `code-review-assistant`, `documentation-generator`

## Usage Example

```bash
# Develop complete feature
feature-dev-complete "User authentication with JWT and refresh tokens"

# Feature with custom target
feature-dev-complete "Payment processing integration" src/payments/

# Feature without PR
feature-dev-complete "Dark mode toggle" --create-pr false
```

## Failure Modes

- **Research insufficient**: Escalate to user for more context
- **Tests fail after iterations**: Manual intervention required
- **Security issues critical**: Block deployment, escalate
- **Quality score too low**: Run additional polish iterations
- **Architecture unclear**: Request user input on design decisions

## Core Principles

Feature Development Complete operates on 3 fundamental principles:

### Principle 1: Research-Driven Development
Begin every feature by researching current best practices and analyzing existing codebase patterns before writing code. Knowledge gathered upfront prevents costly refactoring later.

In practice:
- Use Gemini Search for latest 2025 best practices and framework updates
- Analyze existing codebase patterns with MegaContext for consistency
- Document architectural decisions in ADRs before implementation

### Principle 2: Multi-Model Orchestration
Leverage specialized AI models for their strengths - Gemini for research and diagrams, Codex for rapid prototyping, Claude for architecture and testing strategy. The right tool for each phase maximizes quality.

In practice:
- Gemini Search/MegaContext for research and large codebase analysis
- Codex Auto for rapid prototyping with auto-fixing iterations
- Claude for architecture design, testing strategy, and style polish

### Principle 3: Quality Gates Before Deployment
Features must pass comprehensive testing, security review, and quality checks before reaching production. No shortcuts - automated gates ensure production readiness.

In practice:
- Theater detection eliminates placeholder code before testing
- Codex iteration loops until all tests pass (max 5 iterations)
- Security scan blocks deployment on critical issues (zero tolerance)

## Common Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| **Skipping Research Phase** | Implementing outdated patterns or reinventing existing solutions | Always run Gemini Search for latest best practices before coding |
| **Manual Quality Checks** | Inconsistent reviews, missed security issues, subjective quality assessment | Automate theater detection, security scanning, and quality scoring |
| **Sequential Workflow** | Slow delivery from blocking dependencies (research -> design -> code -> test) | Parallelize independent phases (diagrams + prototyping, testing + security review) |
| **Hardcoded Configuration** | Brittle code requiring redeployment for config changes | Use environment variables, feature flags, and external config files |
| **Theater Code in Production** | Placeholder TODOs and incomplete implementations shipped to users | Run theater detection before testing phase and auto-complete all placeholders |
| **Skipping Staging Validation** | Production bugs from untested deployments | Always deploy to staging first and validate before production release |

## Conclusion

Feature Development Complete embodies the philosophy that production-ready code requires systematic orchestration, not ad-hoc scripting. By combining multi-model AI research, automated quality gates, and comprehensive testing, this skill delivers features that are not just functional, but maintainable, secure, and performant from day one.

Use this skill when building features that matter - greenfield functionality, multi-layer changes, or anything requiring production deployment. The 12-stage workflow ensures nothing is missed, from research to documentation, while theater detection and security scanning prevent the technical debt that plagues rushed implementations.

The result is a consistent, repeatable process that transforms vague feature requests into production-ready code with >80% test coverage, comprehensive documentation, and zero critical security issues. When quality cannot be compromised, Feature Development Complete is the systematic approach that delivers.
