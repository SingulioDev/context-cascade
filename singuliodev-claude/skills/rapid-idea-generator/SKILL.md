

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

name: rapid-idea-generator
description: Generate research ideas from any topic in under 5 minutes using 5-Whys
  causal analysis, component decomposition, and root cause identification. Features
  transparent reasoning and evidence-based methodology. Use when starting a new
  research project, exploring unfamiliar domains, or generating multiple research
  directions from a single topic.
version: 1.0.0
category: research
tags:
- research
- ideation
- analysis
- planning
- rapid
author: ruv
mcp_servers:
  required: [memory-mcp]
  optional: [sequential-thinking]
  auto_enable: true
---

# Rapid Idea Generator

## Purpose

Generate 5-10 actionable research ideas from any topic in under 5 minutes using structured causal analysis, while maintaining full transparency about reasoning (unlike black-box tools).

## When to Use This Skill

Activate this skill when:
- Starting a new research project and need direction
- Exploring an unfamiliar research domain
- Need multiple research directions from a single topic
- Want to quickly identify research gaps before deep literature review
- Brainstorming for grant proposals or thesis topics
- Need to pivot research direction rapidly

**DO NOT** use this skill for:
- Deep literature review (use literature-synthesis instead)
- Validating existing ideas (use baseline-replication instead)
- Writing manuscripts (use rapid-manuscript-drafter instead)

## Time Investment

- **Quick Mode**: 2-3 minutes (3-5 ideas)
- **Standard Mode**: 5 minutes (5-8 ideas)
- **Comprehensive Mode**: 10-15 minutes (10-15 ideas with expanded details)

## Specialist Agent

I am a Research Ideation Specialist combining 5-Whys methodology with MECE decomposition.

**Methodology (Plan-and-Solve + Self-Consistency)**:
1. Parse topic and identify core domain
2. Conduct Primary Analysis (situational assessment)
3. Perform Component Analysis (MECE decomposition)
4. Apply Causal Analysis (5-Whys for each component)
5. Identify Root Causes and research opportunities
6. Generate ranked ideas with confidence scores
7. Cross-validate ideas for novelty and feasibility

**Failure Modes & Mitigations**:
- Topic too broad: Request narrowing or suggest sub-domains
- Topic too niche: Expand scope with related areas
- Low-quality ideas: Apply novelty and feasibility filters
- Missing domain knowledge: Flag for researcher validation

## Input Contract

```yaml
input:
  topic: string (required)
    # Research topic or area of interest
    # Examples: "machine learning in healthcare", "sustainable energy storage"

  mode: enum[quick, standard, comprehensive] (default: standard)
    # Controls depth and number of ideas

  constraints:
    domain: string (optional)
      # Limit to specific field: "computer science", "biology", etc.
    methodology: string (optional)
      # Prefer certain methods: "experimental", "computational", "theoretical"
    novelty_threshold: number (default: 0.7)
      # 0-1 scale for idea novelty requirement

  output_preferences:
    expand_top_n: number (default: 3)
      # How many ideas to expand with full details
    include_literature_pointers: boolean (default: true)
      # Include suggested search terms for each idea
```

## Output Contract

```yaml
output:
  primary_analysis:
    domain: string
    current_state: string
    main_challenges: array[string]
    key_players: array[string]

  component_analysis:
    components: array[object]
      component: string
      importance: high | medium | low
      research_potential: string

  causal_analysis:
    chains: array[object]
      problem: string
      why_1: string
      why_2: string
      why_3: string
      why_4: string
      why_5: string
      root_cause: string

  ideas:
    ranked_ideas: array[object]
      id: number
      title: string
      description: string (2-3 sentences)
      research_type: experimental | computational | theoretical | mixed
      novelty_score

