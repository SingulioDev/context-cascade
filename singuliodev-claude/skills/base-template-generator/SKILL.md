

---
name: base-template-generator
version: 2.0.0
description: |
  Generate clean, production-ready boilerplate templates for Node.js, Python, Go, React, Vue, and other frameworks. Use when starting new projects or creating consistent foundational code structures. Pr
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
- Starting new projects requiring solid foundational structure
- Creating consistent boilerplate across team projects
- Scaffolding microservices or API backends
- Setting up frontend applications with modern tooling
- Need Docker and CI/CD ready out-of-box
- Require automated validation and quality checks

### When NOT to Use This Skill
- For existing projects (use refactoring skills instead)
- When custom architecture is required (templates enforce patterns)
- For prototypes that won't reach production
- When dependencies must be minimized beyond template defaults

### Success Criteria
- primary_outcome: "Production-ready project template with modern tooling, automated validation, Docker support, and CI/CD integration"
- quality_threshold: 0.88
- verification_method: "Template generates successfully, passes validation scripts, builds without errors, includes working tests and CI/CD pipeline"

### Edge Cases
- case: "Template type not supported (not in 6 core types)"
  handling: "Identify closest template match, customize post-generation, or request new template type"
- case: "Conflicting dependency requirements"
  handling: "Document conflicts, provide manual override instructions, suggest alternative template"
- case: "Custom project structure needed"
  handling: "Use base template as starting point, document customizations, consider creating new template variant"

### Skill Guardrails
NEVER:
  - "Generate templates with excessive dependencies (minimal deps philosophy)"
  - "Skip validation scripts (automated quality checks required)"
  - "Omit Docker/CI/CD support (production-readiness requirement)"
  - "Use outdated patterns (modern best practices enforced)"
ALWAYS:
  - "Include automated validation tools and quality checks"
  - "Provide Docker support and CI/CD integration out-of-box"
  - "Use modern ES modules, async/await, type hints per language"
  - "Follow standard layout (cmd/internal/pkg for Go, src/tests for others)"
  - "Include comprehensive README with setup and usage instructions"

### Evidence-Based Execution
self_consistency: "After template generation, validate structure matches specification, all scripts execute successfully, and quality checks pass"
program_of_thought: "Decompose generation into: 1) Select template type, 2) Generate base structure, 3) Configure tooling, 4) Add validation, 5) Setup Docker/CI/CD, 6) Validate output"
plan_and_solve: "Plan: Identify project requirements + select template -> Execute: Generate + configure + validate -> Verify: Build success + tests pass + CI/CD ready"
<!-- END SKILL SOP IMPROVEMENT -->

# Base Template Generator (Gold Tier)

Generate clean, production-ready foundational code templates for modern development frameworks with automated validation, Docker support, and CI/CD integration.

## When to Use This Skill

Use this skill when:
- Starting new projects that need solid foundational structure
- Creating consistent boilerplate across team projects
- Scaffolding microservices or API backends
- Setting up frontend applications with modern tooling
- Need Docker and CI/CD ready out-of-box
- Require automated validation and quality checks

## Template Types (6 Supported)

### Backend Templates
- **Node.js with Express** - ES modules, modern async/await, minimal deps
- **Python with FastAPI** - Type hints, async, Pydantic validation
- **Go with standard library** - Standard layout (cmd/internal/pkg), minimal deps

### Frontend Templates
- **React 18 with Vite** - TypeScript, fast HMR, modern tooling
- **Vue 3 Composition API** - TypeScript, Pinia, modern patterns
- *

