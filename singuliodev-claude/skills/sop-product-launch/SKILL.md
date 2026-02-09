

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for operations workflows
category: operations
tags:
- general
author: system
---

# SOP: Product Launch Workflow

Complete end-to-end product launch process using multi-agent coordination.

## Timeline: 10 Weeks

**Phases**:
1. Research & Planning (Week 1-2)
2. Product Development (Week 3-6)
3. Marketing & Sales Prep (Week 5-8)
4. Launch Execution (Week 9)
5. Post-Launch Monitoring (Week 10+)

---

## Phase 1: Research & Planning (Week 1-2)

### Week 1: Market Research

**Sequential Workflow**:

```javascript
// Step 1: Market Analysis
await Task("Market Researcher", `
Conduct comprehensive market analysis:
- Target market size and demographics
- Competitor analysis (features, pricing, positioning)
- Market trends and opportunities
- Customer pain points and needs

Store findings in memory: market-research/product-launch-2024/analysis
`, "researcher");

// Step 2: Retrieve results and delegate to Business Analyst
const marketData = await memory_retrieve('market-research/product-launch-2024/analysis');

await Task("Business Analyst", `
Using market data: ${marketData}

Perform:
- SWOT analysis
- Business model validation
- Revenue projections
- Risk assessment

Store results: business-analysis/product-launch-2024/strategy
`, "analyst");

// Step 3: Product Strategy
await Task("Product Manager", `
Using:
- Market analysis: market-research/product-launch-2024/analysis
- Business analysis: business-analysis/product-launch-2024/strategy

Define:
- Product positioning
- Feature prioritization (MVP vs future)
- Pricing strategy
- Go-to-market strategy

Store: product-strategy/product-launch-2024/plan
`, "planner");
```

**Deliverables**:
- Market analysis report
- SWOT analysis
- Product strategy document
- Launch timeline

---

## Phase 2: Product Development (Week 3-6)

### Week 3-4: Technical Architecture & Development

**Parallel Workflow** (Backend + Frontend + Mobile):

```javascript
// Initialize development swarm
await mcp__ruv-swarm__swarm_init({
  topology: 'mesh',
  maxAgents: 6,
  strategy: 'adaptive'
});

// Parallel agent spawning
const [backend, frontend, mobile, database, security, tester] = await Promise.all([
  Task("Backend Developer", `
Using product requirements from: product-strategy/product-launch-2024/plan

Build:
- REST API with authentication
- Database schema and migrations
- Business logic layer
- Integration with payment gateway

Store API spec: backend-dev/product-launch-2024/api-spec
Store schema: backend-dev/product-launch-2024/db-schema
`, "backend-dev"),

  Task("Frontend Developer", `
Using API spec from: backend-dev/product-launch-2024/api-spec

Build:
- React web application
- Component library
- State management (Redux/Context)
- API integration layer

Store components: frontend-dev/product-launch-2024/components
`, "coder"),

  Task("Mobile Developer", `
Using API spec from: backend-dev/product-launch-2024/api-spec

Build:
- React Native mobile app (iOS + Android)
- Native modules for device features
- Offline sync capability
- Push notifications

Store builds: mobile-dev/product-launch-2024/builds
`, "mobile-dev"),

  Task("Database Architect", `
Design optimized database:
- Schema design for scalability
- Indexing strategy
- Query optimization
- Backup and recovery plan

Store: database/product-launch-2024/architecture
`, "code-analyzer"),

  Task("Security Specialist", `
Implement security:
- Authentication (OAuth 2.0 + JWT)
- Authorization (RBAC)
- Data encryption (at rest + in transit)
- Security audit and penetration testing

Store audit: security/product-launch-2024/audit
`, "reviewer"),

  Task("QA Engineer", `
Create test suite:
- Unit tests (90%+ coverage)
- Integration tests
- E2E tests
- Performance tests
- Security tests

Store test plan: testing/product-launch-2024/plan
`, "tester")
]);

// Wait for all parallel tasks to complete
await Promise.all([backend, frontend, mobile, database, security, tester]);
```

### Week 5-6: Integration & Testing

**Sequential Workflow**:

```javascr

