

---
name: dependencies
version: 2.1.0
description: |
  Dependency management and analysis hub. Map project dependencies, analyze dependency graphs, identify vulnerabilities, and manage package versions. Routes to dependency-mapper and related analysis too
category: tooling
tags:
- general
author: system
---

# Dependencies

Dependency management, analysis, and vulnerability detection for projects.

## Phase 0: Expertise Loading

```yaml
expertise_check:
  domain: dependencies
  file: .claude/expertise/dependencies.yaml

  if_exists:
    - Load package ecosystems
    - Load vulnerability databases
    - Apply version policies

  if_not_exists:
    - Flag discovery mode
    - Document patterns learned
```

## When to Use This Skill

Use dependencies when:
- Mapping project dependency graphs
- Analyzing package vulnerabilities
- Managing version upgrades
- Identifying circular dependencies
- Auditing security issues

## Sub-Skills

| Skill | Use Case |
|-------|----------|
| dependency-mapper | Visualize dependency graphs |

## Dependency Analysis

### Package Ecosystems
```yaml
supported:
  - npm/yarn (JavaScript)
  - pip/poetry (Python)
  - cargo (Rust)
  - go mod (Go)
  - maven/gradle (Java)
  - composer (PHP)
```

### Analysis Types
```yaml
analyses:
  graph: "Dependency tree visualization"
  vulnerabilities: "CVE/security scanning"
  outdated: "Version freshness check"
  circular: "Circular dependency detection"
  unused: "Dead dependency identification"
```

## Commands

```bash
# Map dependencies
npm ls --all
pip list --format=freeze
cargo tree

# Security audit
npm audit
pip-audit
cargo audit
```

## MCP Requirements

- **claude-flow**: For orchestration
- **Bash**: For package commands

## Recursive Improvement Integration (v2.1)

### Eval Harness Integration

```yaml
benchmark: dependencies-benchmark-v1
  tests:
    - dep-001: Graph generation
    - dep-002: Vulnerability detection
  minimum_scores:
    graph_accuracy: 0.95
    vuln_detection: 0.90
```

### Memory Namespace

```yaml
namespaces:
  - dependencies/graphs/{id}: Dependency graphs
  - dependencies/audits/{id}: Security audits
  - improvement/audits/dependencies: Skill audits
```

### Uncertainty Handling

```yaml
confidence_check:
  if confidence >= 0.8:
    - Proceed with analysis
  if confidence 0.5-0.8:
    - Confirm package ecosystem
  if confidence < 0.5:
    - Ask for package.json/requirements.txt
```

### Cross-Skill Coordination

Works with: **security**, **code-review-assistant**, **deployment-readiness**

---

## !! SKILL COMPLETION VERIFICATION (MANDATORY) !!

- [ ] **Agent Spawning**: Spawned agent via Task()
- [ ] **Agent Registry Validation**: Agent from registry
- [ ] **TodoWrite Called**: Called with 5+ todos
- [ ] **Work Delegation**: Delegated to agents

**Remember: Skill() -> Task() -> TodoWrite() - ALWAYS**

---

## Core Principles

### 1. Transitive Dependency Awareness as Security Priority
Direct dependencies are visible and reviewed, but transitive dependencies (dependencies-of-dependencies) often escape scrutiny despite comprising 80-95% of total dependency count. A single vulnerable transitive dependency deep in the graph creates exploitable attack surface. Dependency analysis must traverse the full graph, flagging high-risk transitives (unmaintained packages, known CVEs, excessive permissions) with equal priority to direct dependencies.

### 2. Version Freshness Balanced Against Stability Risk
Outdated dependencies accumulate security vulnerabilities and miss performance improvements, but aggressive version upgrades introduce breaking changes and untested code paths. The optimal strategy is risk-stratified: security patches applied immediately, minor updates batched and tested weekly, major updates evaluated for breaking changes and scheduled deliberately. Blanket "always latest" or "never update" policies fail by ignoring risk context.

### 3. Circular Dependencies as Architectural Code Smell
Circular dependencies (package A depends on B, B depends on A) indicate architectural coupling that prevents independent evolution, complicates testing, and signals unclear separation of concerns. While sometimes unavoidable in legacy codebases, new circular dependenc

