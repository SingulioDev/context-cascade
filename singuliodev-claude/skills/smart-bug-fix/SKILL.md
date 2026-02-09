

---
name: smart-bug-fix
version: 1.1.0
description: |
  Intelligent bug fixing workflow combining root cause analysis, multi-model reasoning, Codex auto-fix, and comprehensive testing. Uses RCA agent, Codex iteration, and validation to systematically fix b
category: delivery
tags:
- debugging
- rca
- codex
- testing
- essential
author: ruv
---

# Smart Bug Fix

## Kanitsal Hata Ayiklama (Evidential Debugging)

Every bug hypothesis requires evidence. The evidential frame ensures no fix is applied without proof of causation.

**Evidence Requirements**:
- **GOZLEM** (Observation): Bug observed with concrete reproduction steps
- **HIPOTEZ** (Hypothesis): Theory X based on evidence Y
- **DOGRULAMA** (Verification): Fix verified by test results Z
- **RED** (Rejection): Hypothesis rejected due to counter-evidence W

**Example**:
```
GOZLEM: API timeout after 30s under load (reproduction: 1000 concurrent requests)
HIPOTEZ: Database connection pool exhausted (evidence: pool size=10, active=10, waiting=990)
DOGRULAMA: Increased pool to 100, timeout resolved (evidence: 0 timeouts in 10k requests)
```

## Al-Itar al-Sarfi li-Tahlil al-Sabab (Root Cause Morphology)

Symptoms are composed of causes. Decompose systematically using the "Why Chain" until the root is reached.

**Morphological Decomposition**:
- **SYMPTOM**: Observable error or behavior (surface manifestation)
- **CAUSE-1**: Immediate cause (why-1: "Why did this symptom occur?")
- **CAUSE-2**: Deeper cause (why-2: "Why did cause-1 occur?")
- **ROOT**: True root cause (why-N: "Why did cause-(N-1) occur?" until no further "why" exists)

**Example**:
```
SYMPTOM: Login fails on Firefox
CAUSE-1: JWT token not in cookie (why-1)
CAUSE-2: SameSite=Strict blocks cross-site cookies (why-2)
ROOT: Auth server on different subdomain than app (why-3 - architectural root)
```

**NASA 5 Whys Integration**:
The morphological frame is implemented through the 5 Whys methodology:
1. Why-1: Immediate cause (technical layer)
2. Why-2: Systemic cause (design layer)
3. Why-3: Process cause (architectural layer)
4. Why-4: Cultural cause (organizational layer)
5. Why-5: Root cause (foundational layer)

## When to Use This Skill

- **Domain-Specific Work**: Tasks requiring specialized domain knowledge
- **Complex Problems**: Multi-faceted challenges needing systematic approach
- **Best Practice Implementation**: Following industry-standard methodologies
- **Quality-Critical Work**: Production code requiring high standards
- **Team Collaboration**: Coordinated work following shared processes

## When NOT to Use This Skill

- **Outside Domain**: Tasks outside this skill specialty area
- **Incompatible Tech Stack**: Technologies not covered by this skill
- **Simple Tasks**: Trivial work not requiring specialized knowledge
- **Exploratory Work**: Experimental code without production requirements

## Success Criteria

- [ ] Implementation complete and functional
- [ ] Tests passing with adequate coverage
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] Performance benchmarks met
- [ ] Security considerations addressed
- [ ] Deployed or integrated successfully

## Edge Cases to Handle

- **Legacy Integration**: Working with older codebases or deprecated APIs
- **Missing Dependencies**: Unavailable libraries or external services
- **Version Conflicts**: Dependency version incompatibilities
- **Data Issues**: Malformed input or edge case data
- **Concurrency**: Race conditions or synchronization challenges
- **Error Handling**: Graceful degradation and recovery

## Guardrails

- **NEVER** skip testing to ship faster
- **ALWAYS** follow domain-specific best practices
- **NEVER** commit untested or broken code
- **ALWAYS** document complex logic and decisions
- **NEVER** hardcode sensitive data or credentials
- **ALWAYS** validate input and handle errors gracefully
- **NEVER** deploy without reviewing changes

## Evidence-Based Validation

- [ ] Automated tests passing
- [ ] Code linter/formatter passing
- [ ] Security scan completed
- [ ] Performance within acceptable range
- [ ] Manual testing completed
- [ ] Peer review approved
- [ ] Documentation reviewed

## Purpose

Systematically debug and fix bugs using root cause analysis, multi-model reasoning,

