

---
name: meta-tools
version: 1.0.0
description: |
  Meta-tools is a comprehensive framework for creating, validating, optimizing, and composing development tools. It provides automated workflows for tool generation, cross-tool composition, and orchestr
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
- [AUTO-EXTRACTED from skill description and content]
- [Task patterns this skill is optimized for]
- [Workflow contexts where this skill excels]

### When NOT to Use This Skill
- [Situations where alternative skills are better suited]
- [Anti-patterns that indicate wrong skill choice]
- [Edge cases this skill doesn't handle well]

### Success Criteria
- primary_outcome: "[SKILL-SPECIFIC measurable result based on skill purpose]"
- quality_threshold: 0.85
- verification_method: "[How to validate skill executed correctly and produced expected outcome]"

### Edge Cases
- case: "Ambiguous or incomplete input"
  handling: "Request clarification, document assumptions, proceed with explicit constraints"
- case: "Conflicting requirements or constraints"
  handling: "Surface conflict to user, propose resolution options, document trade-offs"
- case: "Insufficient context for quality execution"
  handling: "Flag missing information, provide template for needed context, proceed with documented limitations"

### Skill Guardrails
NEVER:
  - "[SKILL-SPECIFIC anti-pattern that breaks methodology]"
  - "[Common mistake that degrades output quality]"
  - "[Shortcut that compromises skill effectiveness]"
ALWAYS:
  - "[SKILL-SPECIFIC requirement for successful execution]"
  - "[Critical step that must not be skipped]"
  - "[Quality check that ensures reliable output]"

### Evidence-Based Execution
self_consistency: "After completing this skill, verify output quality by [SKILL-SPECIFIC validation approach]"
program_of_thought: "Decompose this skill execution into: [SKILL-SPECIFIC sequential steps]"
plan_and_solve: "Plan: [SKILL-SPECIFIC planning phase] -> Execute: [SKILL-SPECIFIC execution phase] -> Verify: [SKILL-SPECIFIC verification phase]"
<!-- END SKILL SOP IMPROVEMENT -->

# Meta-Tools - Tool Creation and Composition Framework

## Overview

Meta-tools is a comprehensive framework for creating, validating, optimizing, and composing development tools. It provides automated workflows for tool generation, cross-tool composition, and orchestration patterns that enable developers to build custom tooling ecosystems.

## Purpose

Enable developers to:
- **Generate Tools**: Automatically create new tools from specifications
- **Validate Tools**: Ensure tool correctness, security, and performance
- **Optimize Tools**: Enhance tool efficiency and resource usage
- **Package Tools**: Bundle tools for distribution and deployment
- **Compose Tools**: Chain multiple tools into powerful workflows
- **Orchestrate Tools**: Coordinate complex multi-tool operations

## Capabilities

### Tool Generation
- Specification-driven tool creation
- Template-based scaffolding
- Auto-generated validation logic
- Built-in error handling
- Documentation generation

### Tool Validation
- Schema validation
- Security scanning
- Performance profiling
- Integration testing
- Compliance checking

### Tool Optimization
- Performance analysis
- Resource optimization
- Caching strategies
- Parallel execution
- Memory management

### Tool Packaging
- Dependency resolution
- Version management
- Distribution packaging
- Installation scripts
- Update mechanisms

### Tool Composition
- Pipeline creation
- Data flow management
- Error propagation
- State management
- Result aggregation

### Tool Orchestration
- Multi-tool coordination
- Parallel execution
- Conditional workflows
- Event-driven triggers
- Monitoring and logging

## Usage Patterns

### Quick Tool Generation
```bash
# Generate a new tool from specification
python resources/tool-generator.py \
  --spec specs/my-tool.yaml \
  --output tools/my-tool \
  --template resources/templates/tool-template.yaml
```

### Tool Validation
```bash
# Validate a tool implementation
node resou

