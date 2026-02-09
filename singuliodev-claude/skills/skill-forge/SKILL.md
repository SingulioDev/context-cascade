

---
name: skill-forge
version: 3.0.1
description: |
  Advanced skill creation system for Claude Code that combines deep intent analysis, evidence-based prompting principles, and systematic skill engineering. Use when creating new skills or refining exist
category: foundry
tags:
- foundry
- creation
- meta-tools
author: ruv
---

<!-- SKILL SOP IMPROVEMENT v1.0 -->
## Skill Execution Criteria

### When to Use This Skill
- Creating new skills with comprehensive structure and validation
- Building agent-powered workflows with multi-agent orchestration
- Developing production-grade skills with proper documentation
- Need adversarial testing and COV protocol validation
- Creating skills that integrate with MCP servers and Claude Flow

### When NOT to Use This Skill
- For quick atomic micro-skills (use micro-skill-creator instead)
- For agent creation without skill wrapper (use agent-creator)
- For prompt optimization only (use prompt-architect)
- When simple script suffices without skill abstraction

### Success Criteria
- primary_outcome: "Production-grade skill with comprehensive structure, agent coordination, adversarial testing, and integration documentation"
- quality_threshold: 0.91
- verification_method: "Skill passes adversarial testing protocol, survives COV validation, integrates with Claude Flow, includes examples and tests"

### Edge Cases
- case: "Skill requires complex multi-agent coordination"
  handling: "Use agent orchestration patterns, define clear coordination protocol, test with ruv-swarm"
- case: "Skill needs MCP server integration"
  handling: "Declare MCP dependencies in frontmatter, add auto-enable logic, document requirements"
- case: "Skill has performance constraints"
  handling: "Add performance benchmarks, optimize agent selection, implement caching strategies"

### Skill Guardrails
NEVER:
  - "Skip adversarial testing (validation protocol required for production)"
  - "Create skills without proper file structure (examples, tests, resources mandatory)"
  - "Omit MCP integration points (skills should leverage available tools)"
  - "Use generic coordination (leverage specialized orchestration agents)"
ALWAYS:
  - "Follow file structure standards (examples/, tests/, resources/, references/)"
  - "Include adversarial testing protocol and COV validation"
  - "Declare MCP server dependencies in YAML frontmatter"
  - "Provide comprehensive examples with expected inputs/outputs"
  - "Document integration with Claude Flow and agent coordination"

### Evidence-Based Execution
self_consistency: "After skill creation, run multiple execution rounds with diverse inputs to verify consistent behavior and agent coordination quality"
program_of_thought: "Decompose skill forge into: 1) Define skill purpose, 2) Design agent coordination, 3) Build core structure, 4) Add examples/tests, 5) Apply adversarial validation, 6) Document integration"
plan_and_solve: "Plan: Identify skill scope + agents needed -> Execute: Build structure + coordinate agents + validate -> Verify: Adversarial testing + COV protocol + integration tests"
<!-- END SKILL SOP IMPROVEMENT -->

# Skill Forge

An advanced skill creation system that helps craft sophisticated, well-engineered skills for Claude Code by combining deep intent analysis, evidence-based prompting principles, and systematic skill engineering methodology.

## Overview

Skill Forge represents a meta-cognitive approach to skill creation. Rather than simply generating skill templates, it guides you through a comprehensive process that ensures every skill you create is strategically designed, follows best practices, and incorporates sophisticated prompt engineering techniques.

This skill operates as an intelligent collaborator that helps you think deeply about what you're trying to achieve, identifies the optimal structure for your skill, and applies evidence-based techniques to maximize effectiveness. The result is skills that are not just functional but genuinely powerful extensions of Claude's capab

