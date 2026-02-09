

---
name: documentation
version: 2.2.1
description: |
  Documentation generation hub for code documentation, API docs, READMEs, and inline comments. Routes to doc-generator and related documentation tools. Use when generating or improving project documenta
category: tooling
tags:
- general
author: system
---

# Documentation

## Keigo Wakugumi (Honorific Frame Activation)
Taishougisha nintei moodoga yuukoudesu.

Central hub for generating and maintaining project documentation.

## Phase 0: Expertise Loading & Cognitive Frame Activation

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

cognitive_activation:
  - Activate hierarchical documentation framework (Keigo Wakugumi)
  - Activate morphological concept extraction (Al-Itar al-Sarfi)
  - Map codebase to audience levels
  - Extract documentation concepts from code structure
```

## Cognitive Frame 1: Keigo Wakugumi (Hierarchical Documentation)

Documentation organized by **audience level** and **scope hierarchy** - from executive summaries to implementation details.

### Rejisutaa Shurui (Audience Register Levels)

**SONKEIGO (Executive/Respectful)** - High-level overview, business value:
- **Purpose**: Explain "why this exists" for executives, product managers
- **Content**: Business value, ROI, strategic alignment, high-level architecture
- **Format**: Executive summary, one-page overviews, architecture diagrams
- **Example**: "This authentication system reduces security incidents by 40% and enables SSO integration"

**TEINEIGO (Developer/Polite)** - Technical details, API reference:
- **Purpose**: Enable developers to integrate and use the system
- **Content**: API reference, function signatures, parameters, return values, examples
- **Format**: OpenAPI specs, JSDoc, function-level documentation
- **Example**: "POST /api/auth/login - Accepts email/password, returns JWT token (200) or error (401)"

**CASUAL (Internal/Plain)** - Implementation notes, quick reference:
- **Purpose**: Help maintainers understand internal workings
- **Content**: Code comments, implementation notes, architectural decisions (ADRs)
- **Format**: Inline comments, ADRs, internal wikis
- **Example**: "// Uses bcrypt with cost factor 12 - balances security vs performance"

### Hierarchy Structure (Multi-Level Documentation)

```
LEVEL 1 (SYSTEM) - Architecture Overview
├── What: System purpose and scope
├── Why: Business drivers and constraints
├── How: High-level architecture
└── Who: Stakeholders and users
    |
    ├── LEVEL 2 (COMPONENT) - Module Documentation
    |   ├── Component responsibility
    |   ├── Dependencies and interfaces
    |   ├── Data flow diagrams
    |   └── Configuration options
    |       |
    |       ├── LEVEL 3 (INTERFACE) - API/Function Docs
    |       |   ├── Function signatures
    |       |   ├── Parameters and types
    |       |   ├── Return values and errors
    |       |   └── Usage examples
    |       |       |
    |       |       └── LEVEL 4 (IMPLEMENTATION) - Code Comments
    |       |           ├── Algorithm explanations
    |       |           ├── Edge case handling
    |       |           ├── Performance considerations
    |       |           └── TODO/FIXME notes
```

### Documentation Routing by Audience

| Audience | Register | Level | Example |
|----------|----------|-------|---------|
| CTO, Product Manager | SONKEIGO | L1 System | "Reduces auth latency by 60%" |
| External Developer | TEINEIGO | L3 Interface | "auth.login(email, password) -> Promise<Token>" |
| Team Developer | TEINEIGO | L2 Component | "Auth module handles JWT, OAuth, SAML" |
| Maintainer | CASUAL | L4 Implementation | "// Edge case: token refresh race condition" |
| New Hire | TEINEIGO | L2-L3 | "Architecture + API quick start" |

## Cognitive Frame 2: Al-Itar al-Sarfi lil-Tawthiq (Morphological Documentation)

Documentation sections **derived from code structure** - extract concepts from patterns, root words, and compositions.

### Concept Extraction Process

**ROOT (Jidhir)** - Core concept identified from codebase:
- Extracted from: Class names, module names,

