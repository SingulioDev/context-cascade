

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

name: rapid-manuscript-drafter
description: Generate structured research manuscript drafts in 10-15 minutes with
  proper academic sections (Abstract, Introduction, Methods, Results, Discussion).
  Creates scaffolded drafts with placeholders for data, not fabricated content. Use
  for quickly producing first drafts from research ideas, speeding up the writing
  process while maintaining academic integrity.
version: 1.0.0
category: research
tags:
- research
- writing
- manuscript
- academic
- drafting
- rapid
author: ruv
mcp_servers:
  required: [memory-mcp]
  optional: [sequential-thinking]
  auto_enable: true
---

# Rapid Manuscript Drafter

## Purpose

Generate structured, scaffolded research manuscript drafts in 10-15 minutes that provide a solid foundation for academic writing. Unlike tools that fabricate content, this skill creates honest drafts with clear placeholders for user-provided data and findings.

## Critical Ethical Stance

**This skill NEVER fabricates research results or data.**

What we DO:
- Generate document structure and section scaffolding
- Write introduction and background based on known literature
- Create methodology templates based on described approach
- Provide results section structure with [YOUR_DATA] placeholders
- Draft discussion frameworks with logical argument structure

What we DON'T DO:
- Invent experimental results
- Fabricate statistical findings
- Create fake tables or figures with made-up numbers
- Generate citations to non-existent papers

## When to Use This Skill

Activate this skill when:
- Have a research idea ready to write up
- Need to quickly produce a first draft
- Want to overcome blank page syndrome
- Preparing a manuscript outline for collaborators
- Writing conference paper with tight deadline
- Need structured template for thesis chapter

**DO NOT** use this skill for:
- Final polished manuscripts (this is a first draft tool)
- Generating fake research (we don't do that)
- Replacing actual research work

## Manuscript Types Supported

1. **Research Article** (IMRaD format)
2. **Conference Paper** (shorter, focused)
3. **Review Article** (literature synthesis)
4. **Technical Report**
5. **Thesis Chapter**
6. **Grant Proposal Section**

## Input Contract

```yaml
input:
  manuscript_type: enum[research_article, conference_paper, review, technical_report, thesis_chapter, grant_section] (required)

  research_content:
    title: string (required)
    abstract_points: array[string] (optional)
    research_question: string (required)
    hypotheses: array[string] (optional)
    methodology_description: string (required)
    key_findings_summary: string (optional, will use placeholders if empty)
    contribution_claims: array[string] (required)

  literature_context:
    key_papers: array[object] (optional)
      title: string
      authors: string
      year: number
      relevance: string
    research_gap: string (required)

  target_venue:
    name: string (optional)
    word_limit: number (optional)
    style: enum[ieee, acm, nature, apa, chicago] (default: apa)

  output_preferences:
    include_placeholders: boolean (default: true)
    include_writing_tips: boolean (default: true)
    generate_outline_first: boolean (default: true)
```

## Output Contract

```yaml
output:
  manuscript:
    title: string
    sections: array[object]
      name: string
      content: string
      word_count: number
      completeness: percentage
      placeholders: array[string]

  outline:
    structure: object (hierarchical outline)

  metadata:
    total_words: number
    total_placeholders: number
    sections_complete: number
    sections_scaffolded: number
    generation_time: number

  next_steps:
    required_additions: array[string]
    recommended_revisions: array[string]
```

## SOP Phase 1: Outline Generation

Create hierarchical document structure:

```markdown
## Manuscript Outline: [TITLE]

### 1.

