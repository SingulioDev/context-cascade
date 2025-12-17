---
name: documentation
version: 2.1.0
description: Documentation generation hub for code documentation, API docs, READMEs, and inline comments. Routes to doc-generator and related documentation tools. Use when generating or improving project documentation.
---

# Documentation

Central hub for generating and maintaining project documentation.

## Phase 0: Expertise Loading

```yaml
expertise_check:
  domain: documentation
  file: .claude/expertise/documentation.yaml

  if_exists:
    - Load documentation standards
    - Load project conventions
    - Apply style guides

  if_not_exists:
    - Flag discovery mode
    - Document patterns learned
```

## When to Use This Skill

Use documentation when:
- Generating README files
- Creating API documentation
- Adding inline code comments
- Building documentation sites
- Documenting architecture

## Sub-Skills

| Skill | Use Case |
|-------|----------|
| doc-generator | Generate documentation |
| doc-readme | README generation |
| doc-api | API documentation |
| doc-inline | Inline comments |

## Documentation Types

### README Generation
```yaml
type: readme
sections:
  - title_and_badges
  - description
  - installation
  - usage
  - api_reference
  - contributing
  - license
```

### API Documentation
```yaml
type: api
format: openapi|jsdoc|sphinx
output: html|markdown|json
includes:
  - endpoints
  - parameters
  - responses
  - examples
```

### Inline Comments
```yaml
type: inline
style: jsdoc|docstring|rustdoc
coverage:
  - functions
  - classes
  - complex_logic
```

## MCP Requirements

- **claude-flow**: For orchestration
- **Read/Write**: For file operations

## Recursive Improvement Integration (v2.1)

### Eval Harness Integration

```yaml
benchmark: documentation-benchmark-v1
  tests:
    - doc-001: README completeness
    - doc-002: API doc accuracy
  minimum_scores:
    completeness: 0.85
    accuracy: 0.90
```

### Memory Namespace

```yaml
namespaces:
  - documentation/generated/{id}: Generated docs
  - documentation/templates: Doc templates
  - improvement/audits/documentation: Skill audits
```

### Uncertainty Handling

```yaml
confidence_check:
  if confidence >= 0.8:
    - Generate documentation
  if confidence 0.5-0.8:
    - Show preview, ask confirmation
  if confidence < 0.5:
    - Ask for style preferences
```

### Cross-Skill Coordination

Works with: **code-review-assistant**, **api-development**, **feature-dev-complete**

---

## !! SKILL COMPLETION VERIFICATION (MANDATORY) !!

- [ ] **Agent Spawning**: Spawned agent via Task()
- [ ] **Agent Registry Validation**: Agent from registry
- [ ] **TodoWrite Called**: Called with 5+ todos
- [ ] **Work Delegation**: Delegated to agents

**Remember: Skill() -> Task() -> TodoWrite() - ALWAYS**

---

## Core Principles

### 1. Documentation as Code Synchronization, Not Artifact Generation
Documentation becomes stale the moment it diverges from code. Treating documentation as a separate artifact that must be manually updated creates guaranteed drift. Instead, documentation should be generated from code structure, type signatures, and inline comments, ensuring synchronization by design. README sections describe usage patterns, but API references should derive from source truth in the codebase itself.

### 2. Audience-Specific Documentation Layers
Documentation serves multiple audiences with conflicting needs: quick-start users need minimal viable knowledge, API consumers need comprehensive references, and contributors need architectural context. A single documentation artifact that tries to serve all audiences creates cognitive overload for beginners and insufficient depth for experts. Layered documentation with clear navigation between levels optimizes for each audience's distinct goals.

### 3. Completeness Metrics Over Coverage Metrics
High code coverage (90% of functions documented) does not guarantee useful documentation. A function with a docstring saying "handles user data" provides zero additional information beyond the function name. Completeness metrics (parameters explained, return values specified, edge cases documented, examples provided) measure documentation utility rather than documentation existence, preventing theater that satisfies linters without serving readers.

---

## Anti-Patterns

| Anti-Pattern | Why It Fails | Correct Approach |
|-------------|--------------|------------------|
| **Manually writing API documentation** | Diverges from code immediately. Parameters change, functions added/removed, return types evolve. Manual docs lag reality, misleading users and wasting maintainer time on sync. | Generate API docs from code: JSDoc -> html, Python docstrings -> Sphinx, Rust comments -> rustdoc. Source of truth is code, docs are derived artifact. |
| **README everything at once** | Overwhelms new users with 50-page READMEs covering every edge case. Buries essential quick-start information. Intimidates contributors. Reduces engagement with critical sections. | Layered docs: README (quick-start + links), /docs/api (reference), /docs/architecture (deep dive), /docs/contributing (process). Progressive disclosure based on user journey. |
| **Documenting without examples** | Abstract descriptions of parameters and return values require users to infer usage. Increases cognitive load. Leads to misuse and support burden. Examples communicate intent faster than prose. | Every public API function needs working example. Show common use case, edge case handling, and integration pattern. Runnable code > paragraphs of explanation. |

---

## Conclusion

Documentation generation addresses the fundamental tension between comprehensive knowledge transfer and maintainer velocity. Manual documentation workflows create bottlenecks that cause docs to lag reality, while generated documentation without editorial oversight produces technically accurate but pedagogically useless artifacts. This skill bridges the gap by automating the synchronization layer while preserving human curation for narrative structure.

The skill's effectiveness stems from treating documentation as a multi-layer system rather than a monolithic artifact. Quick-start READMEs prioritize time-to-first-success, API references derive from code structure to ensure accuracy, and architectural deep-dives provide context for contributors. The automation workflow handles the tedious synchronization tasks that humans consistently fail at (updating parameter lists, maintaining consistent formatting, validating examples) while preserving human control over high-value editorial decisions (narrative flow, audience targeting, conceptual explanations).

By integrating with recursive improvement systems and uncertainty handling, the skill learns project-specific conventions over time, reducing the editorial burden on each generation cycle. The result is documentation that stays synchronized with code by default, serves multiple audience needs through layered organization, and improves through feedback loops rather than decaying through neglect.

---

## Core Principles

### 1. Documentation Is Code
Documentation that is not version-controlled, reviewed, and tested alongside code becomes stale, inaccurate, and ignored. Treating documentation as second-class output guarantees documentation-code drift, where docs describe systems that no longer exist.

In practice:
- Store documentation in version control (Git) alongside code in `/docs` directory
- Require documentation updates in code review for any public API or architecture change
- Auto-generate API docs from code annotations (JSDoc, docstrings, Rustdoc) to ensure synchronization
- Validate documentation in CI/CD (broken links, outdated examples, missing sections)

### 2. Write For Future Maintainers, Not Current Experts
Documentation written for developers who already understand the system is useless - the people who need docs are those unfamiliar with the codebase (new hires, contributors, future self after 6 months). Expert-oriented docs create knowledge silos.

In practice:
- Include "Getting Started" section with zero-to-running instructions (setup, build, run, test)
- Document WHY decisions were made, not just WHAT the code does (architecture decision records)
- Provide working examples and common use cases, not just API reference
- Define domain-specific terminology in a glossary (avoid assumed knowledge)

### 3. Incomplete Documentation Is Better Than None
Perfectionism blocks documentation creation - teams delay writing docs until they are "comprehensive," resulting in zero documentation. Partial docs (README with installation steps) provide 80% of value with 20% of effort.

In practice:
- Start with essential documentation: README (what, why, how to run), CONTRIBUTING (how to contribute), API reference (public interfaces)
- Incrementally add docs based on support questions - if people ask the same question twice, document the answer
- Use documentation templates to reduce cognitive overhead (README template, API doc template)
- Accept imperfect docs and iterate - documentation improves through use and feedback

---

## Anti-Patterns

| Anti-Pattern | Why It Fails | Correct Approach |
|-------------|--------------|------------------|
| **Documentation Separate from Code** | Documentation in wikis, Google Docs, or Confluence becomes stale because it is not version-controlled or reviewed with code changes. API changes break documentation silently, creating documentation-code drift that misleads users. | Store documentation in `/docs` directory within code repository. Version control docs alongside code using Git. Require documentation updates in code review for any public API or architecture change. Auto-generate API docs from code annotations (JSDoc, docstrings). |
| **No Working Examples** | API reference without runnable examples forces users to guess how to use the API. Example-free docs result in support tickets asking "how do I actually use this?" for basic use cases. | Include working code examples for common use cases in documentation. Provide copy-paste starter code in README. Create `/examples` directory with runnable sample applications. Validate examples in CI/CD to ensure they stay functional. |
| **Waiting for Perfect Documentation** | Delaying documentation until it is "comprehensive" and "polished" results in zero documentation. Perfectionism blocks creation, leaving new developers with no guidance. Undocumented systems have high onboarding friction and knowledge silos. | Start with essential documentation: README (what, why, how to run), CONTRIBUTING (how to contribute), API reference (public interfaces). Incrementally add docs based on user questions. Accept imperfect docs and iterate based on feedback. Documentation improves through use, not upfront planning. |

---

## Conclusion

Documentation generation transforms knowledge silos into accessible, version-controlled resources that enable onboarding, contribution, and long-term maintainability. This skill provides automated documentation workflows for READMEs, API docs, inline comments, and architecture guides, treating documentation as first-class code artifacts subject to review and validation.

Use this skill to generate essential documentation (README, API reference, deployment guides) from templates, auto-generate API docs from code annotations (JSDoc, docstrings, Rustdoc), and validate documentation in CI/CD (broken links, outdated examples). The expertise loading system (Phase 0) enables domain-aware documentation that follows project conventions and style guides.

The key insight is that documentation-code drift occurs when documentation is not version-controlled and reviewed alongside code changes. Storing docs in wikis or Google Docs guarantees staleness - public API changes break docs silently, misleading users. Version-controlling documentation in `/docs` directory ensures synchronization, enabling documentation updates to be required in code review.

Documentation written for current experts is useless - the people who need docs are those unfamiliar with the system (new hires, contributors, future self after 6 months). Including working examples, "Getting Started" sections, and architecture decision records (ADRs) documenting WHY decisions were made reduces onboarding friction and prevents knowledge loss when team members leave.

Success requires accepting that incomplete documentation is better than none. Perfectionism blocks documentation creation - teams delay writing docs until they are "comprehensive," resulting in zero documentation. Starting with essential docs (README with installation, CONTRIBUTING, API reference) provides 80% of value with 20% of effort, enabling incremental improvement based on user questions and feedback. Documentation is a continuous discipline, not a one-time artifact.
