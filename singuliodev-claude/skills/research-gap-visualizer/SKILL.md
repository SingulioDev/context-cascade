

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

name: research-gap-visualizer
description: Create visual maps of research gaps from literature analysis, showing
  what has been studied, what is missing, and where opportunities exist. Generates
  gap matrices, research landscape diagrams, and opportunity maps. Use after literature
  synthesis to visualize the state of research and identify promising directions.
version: 1.0.0
category: research
tags:
- research
- gaps
- visualization
- literature
- analysis
author: ruv
mcp_servers:
  required: [memory-mcp]
  optional: [sequential-thinking]
  auto_enable: true
---

# Research Gap Visualizer

## Purpose

Transform literature analysis into visual gap maps that clearly show what has been studied, what is missing, and where research opportunities exist. Provides visual evidence for research motivation in proposals and manuscripts.

## When to Use This Skill

Activate this skill when:
- Completed literature synthesis and need to identify gaps
- Writing research motivation section (need visual evidence)
- Preparing grant proposals (need to show novelty)
- Planning research direction (need to see landscape)
- Defending thesis topic selection

**DO NOT** use this skill for:
- Initial literature search (use literature-synthesis first)
- Idea generation without literature context (use rapid-idea-generator)
- Detailed methodology planning (use research-driven-planning)

## Visual Output Types

### 1. Gap Matrix
2D matrix showing which combinations of methods/domains have been studied vs unexplored.

### 2. Research Landscape Map
Bubble/scatter diagram showing density of research in different areas.

### 3. Temporal Gap Analysis
Timeline showing when topics were studied and which are stale.

### 4. Method-Application Matrix
Which methods have been applied to which problems.

### 5. Opportunity Quadrant
2x2 matrix of feasibility vs impact for potential research directions.

## Input Contract

```yaml
input:
  literature_data: object (required)
    papers: array[object]
      title: string
      year: number
      methods: array[string]
      domains: array[string]
      key_findings: string

  analysis_type: enum[gap_matrix, landscape, temporal, method_application, opportunity] (required)

  dimensions:
    x_axis: string  # e.g., "methods", "year", "domain"
    y_axis: string  # e.g., "application", "dataset", "metric"

  filters:
    year_range: [start_year, end_year] (optional)
    min_papers: number (default: 1)

  output_format: enum[mermaid, ascii, markdown, graphviz] (default: mermaid)
```

## Output Contract

```yaml
output:
  visualization:
    type: string
    format: string
    code: string  # Mermaid/GraphViz/ASCII code

  gap_analysis:
    total_cells: number
    studied_cells: number
    gap_cells: number
    gap_percentage: number

  identified_gaps:
    high_priority: array[object]
      description: string
      evidence: string  # Why this is a gap
      opportunity_score: number
    medium_priority: array[object]
    low_priority: array[object]

  recommendations:
    top_opportunities: array[string]
    rationale: array[string]

  metadata:
    papers_analyzed: number
    dimensions_used: array[string]
    generation_time: number
```

## SOP Phase 1: Literature Data Parsing

Extract structured data from literature synthesis:

```markdown
## Literature Parsing

**Papers Analyzed**: [N]

**Extracted Dimensions**:
- Methods: [list of unique methods]
- Domains: [list of unique domains/applications]
- Datasets: [list of unique datasets]
- Years: [range]

**Dimension Frequency**:
| Dimension | Count | Percentage |
|-----------|-------|------------|
| [Method 1] | [N] | [%] |
| [Method 2] | [N] | [%] |
```

## SOP Phase 2: Gap Matrix Generation

Create the gap matrix visualization:

### Gap Matrix Template (Markdown)

```markdown
## Research Gap Matrix: [X-Axis] vs [Y-Axis]

|           | [Y1] | [Y2] | [Y3] | [Y4] | [Y5] |
|-----------|------|--

