

---
name: sop-api-development
version: 1.0.0
description: |
  Complete REST API development workflow coordinating backend, database, testing, documentation, and DevOps agents. 2-week timeline with TDD approach.
category: delivery
tags:
- delivery
- development
- workflow
author: ruv
---

# SOP: REST API Development

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

Complete REST API development using Test-Driven Development and multi-agent coordination.

## Timeline: 2 Weeks

**Phases**:
1. Planning & Design (Days 1-2)
2. Development (Days 3-8)
3. Testing & Documentation (Days 9-11)
4. Deployment (Days 12-14)

---

## Phase 1: Planning & Design (Days 1-2)

### Day 1: Requirements & Architecture

**Sequential Workflow**:

```javascript
// Step 1: Gather Requirements
await Task("Product Manager", `
Define API requirements:
- List all endpoints needed
- Define data models and relationships
- Specify authentication/authorization
- Define rate limiting and quotas
- Identify third-party integrations

Store requirements: api-dev/rest-api-v2/requirements
`, "planner");

// Step 2: API Design
await Task("System Architect", `
Using requirements: api-dev/rest-api-v2/requirements

Design:
- RESTful API structure (resources, HTTP methods)
- URL patterns and versioning strategy
- Request/response formats (JSON schemas)
- Error handling patterns
- API security architecture

Generate OpenAPI 3.0 specification
Store: api-dev/rest-api-v2/openapi-spec
`, "system-architect");

// Step 3: Database Design
await Task("Database Architect", `
Using API spec: api-dev/rest-api-v2/openapi-spec

Design database:
- Schema design (tables, columns, types)
- Relationships and foreign keys
- Indexes for performance
- Migration strategy
- Backup and recovery plan

Generate SQL schema
Store: api-dev/rest-api-v2/db-schema
`, "code-analyzer");
```

### Day 2: Test Planning

```javascript
// Step 4: Test Strategy
await Task("QA Engineer", `
Using:
- API spec: api-dev/rest-api-v2/openapi-spec
- DB schema: api-dev/rest-api-v2/db-schema

Create test plan:
- Unit test strategy (per endpoint)
- Integration test scenarios
- E2E test workflows
- Performance test targets
- Security test cases

Store test plan: api-dev/rest-api-v2/test-plan
`, "tester");

//

