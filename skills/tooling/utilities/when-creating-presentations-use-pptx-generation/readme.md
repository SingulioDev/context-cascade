

## When to Use This Skill

- **Tool Usage**: When you need to execute specific tools, lookup reference materials, or run automation pipelines
- **Reference Lookup**: When you need to access documented patterns, best practices, or technical specifications
- **Automation Needs**: When you need to run standardized workflows or pipeline processes

## When NOT to Use This Skill

- **Manual Processes**: Avoid when manual intervention is more appropriate than automated tools
- **Non-Standard Tools**: Do not use when tools are deprecated, unsupported, or outside standard toolkit

## Success Criteria

- **Tool Executed Correctly**: Verify tool runs without errors and produces expected output
- **Reference Accurate**: Confirm reference material is current and applicable
- **Pipeline Complete**: Ensure automation pipeline completes all stages successfully

## Edge Cases

- **Tool Unavailable**: Handle scenarios where required tool is not installed or accessible
- **Outdated References**: Detect when reference material is obsolete or superseded
- **Pipeline Failures**: Recover gracefully from mid-pipeline failures with clear error messages

## Guardrails

- **NEVER use deprecated tools**: Always verify tool versions and support status before execution
- **ALWAYS verify outputs**: Validate tool outputs match expected format and content
- **ALWAYS check health**: Run tool health checks before critical operations

## Evidence-Based Validation

- **Tool Health Checks**: Execute diagnostic commands to verify tool functionality before use
- **Output Validation**: Compare actual outputs against expected schemas or patterns
- **Pipeline Monitoring**: Track pipeline execution metrics and success rates

# PPTX Generation - Quick Start
You are analyzing completed work and extracting learnings. Identify patterns, anti-patterns, and reusable insights. Quantify outcomes with concrete metrics. Document deviations from plan and their rationale. Synthesize actionable recommendations for future iterations.
You are analyzing completed work and extracting learnings. Identify patterns, anti-patterns, and reusable insights. Quantify outcomes with concrete metrics. Document deviations from plan and their rationale. Synthesize actionable recommendations for future iterations.

## Purpose
Enterprise-grade PowerPoint generation with accessibility compliance (WCAG 2.1 AA) and constraint-based design.

## When to Use
- Board presentations
- Business reviews
- Technical reports
- Client proposals

## Quick Start

```bash
npx claude-flow@alpha skill-run pptx-generation \
  --content "content-outline.json" \
  --output "presentation.pptx"
```

## 5-Phase Process

1. **Research** (8 min) - Gather content and structure
2. **Design** (7 min) - Create layouts and design system
3. **Generate** (12 min) - Build slides with visualizations
4. **Validate** (8 min) - Accessibility and quality checks
5. **Export** (5 min) - Final PPTX with documentation

## Features

- WCAG 2.1 AA compliance
- Consistent design system
- Data visualizations (charts, tables)
- Speaker notes
- Alt text for accessibility
- 30+ slide support

## Output

- **presentation.pptx**: PowerPoint file
- **accessibility-report.json**: Compliance scan
- **documentation.md**: Generation details

For detailed documentation, see SKILL.md
