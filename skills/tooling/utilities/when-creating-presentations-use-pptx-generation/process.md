

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

# PPTX Generation - Detailed Workflow
You are executing a multi-stage workflow with defined phase gates. Follow the prescribed sequence rigorously. Validate completion criteria at each stage before advancing. Maintain state consistency across phases. Document decision points and branching logic clearly.
You are executing a multi-stage workflow with defined phase gates. Follow the prescribed sequence rigorously. Validate completion criteria at each stage before advancing. Maintain state consistency across phases. Document decision points and branching logic clearly.

## Process Overview

Enterprise PowerPoint generation with design consistency, accessibility compliance, and data visualization.

## Phase Breakdown

### Phase 1: Research Content (8 min)
**Agent**: Researcher
- Gather presentation content
- Structure outline
- Extract data points
- Identify visualization opportunities

### Phase 2: Design Layout (7 min)
**Agent**: Coder
- Define design system (colors, fonts, spacing)
- Create slide layouts (title, content, two-column, chart)
- Apply accessibility constraints (WCAG 2.1 AA)
- Set color contrast ratios (≥4.5:1)

### Phase 3: Generate Slides (12 min)
**Agent**: Coder
- Initialize presentation with pptxgenjs
- Generate slides from outline
- Add data visualizations (charts, tables)
- Include alt text for accessibility

### Phase 4: Validate Quality (8 min)
**Agent**: Coder
- Scan accessibility (contrast, alt text, reading order)
- Check design consistency
- Validate data integrity
- Ensure file size < 50MB

### Phase 5: Export Final (5 min)
**Agent**: Coder
- Generate PPTX file
- Create accessibility report
- Write documentation
- Package speaker notes

## Design System

```javascript
{
  colors: { primary, secondary, accent, text, background },
  fonts: { heading: 32pt, subheading: 24pt, body: 18pt },
  layout: { margins: 0.5", spacing: 0.3" },
  accessibility: { contrast: 4.5:1, altText: true }
}
```

## Slide Layouts

- **Title**: Large heading + subtitle
- **Content**: Title + bullet points
- **Two-Column**: Split content
- **Data Visualization**: Charts with legends

## Accessibility Standards

- WCAG 2.1 Level AA
- Color contrast ≥4.5:1
- Alt text for all images
- Proper reading order
- Screen reader compatible

For implementation details, see SKILL.md
