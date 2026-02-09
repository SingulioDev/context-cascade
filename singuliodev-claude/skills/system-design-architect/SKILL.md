

---
name: system-design-architect
version: 1.0.0
description: |
  Comprehensive system design methodology using Dr. Synthara's organism-based approach. Treats systems as living organisms with specialized organs (API, DB, cache, queues), circulation (load balancing),
category: specialists
tags:
- system-design
- architecture
- scaling
- infrastructure
- interviews
author: Context Cascade (Dr. Synthara methodology)
---

# System Design Architect

A comprehensive system design skill using the organism-based mental model: systems are living creatures with organs, circulation, immune systems, and survival mechanisms.

## SKILL-SPECIFIC GUIDANCE

### When to Use This Skill

- Designing new systems from scratch
- System design interviews (FAANG-level)
- Architecture reviews and evolution planning
- Scaling existing systems (10x, 100x)
- Production readiness assessments
- Identifying and removing SPOFs

### When NOT to Use This Skill

- Simple CRUD applications with no scale needs
- Prototypes where architecture doesn't matter yet
- When requirements are completely undefined
- Premature optimization scenarios

### Success Criteria
- Clear non-negotiable invariants defined
- All SPOFs identified and mitigated
- Decision trees applied for each component choice
- Trade-offs explicitly documented
- 90-second narrative can explain the design
- -

## Phase 0: Pin the Target Before Drawing Boxes

**You are designing for constraints, not for tech.**

### Constraint Extraction Checklist

| Constraint | Questions to Ask |
|------------|------------------|
| **Users & Usage** | DAU/MAU? Peak QPS? Read/write ratio? Payload sizes? |
| **Latency Target** | p50/p95/p99? Mobile vs desktop? Global vs local? |
| **Availability** | SLO (99.9? 99.99?)? RTO/RPO? |
| **Consistency** | Strong vs eventual? Where does correctness matter? |
| **Data Shape** | Relational? Document? Graph? Hot keys? |
| **Security** | Auth model? Threat surface? Compliance? |
| **Growth Path** | What changes if traffic 10x? 100x? |

### What I'm Thinking as a Designer

"What are the non-negotiable invariants?"

Examples:
- "No double-charging" (payments)
- "Messages never delivered out of order per conversation" (chat)
- "Inventory can't go negative" (e-commerce)
- "Tokens must be revocable" (auth)

---

## Phase 1: Baseline Single-Server Organism

Start with a simple diagram you can explain in 30 seconds:

```
Domain -> DNS -> Server IP
Client -> HTTPS -> Server
Server -> Business Logic -> DB -> Response
```

This sets a clean foundation to EVOLVE from, instead of prematurely microservicing.

---

## Phase 2: First Evolution - Split Tiers

Split into:
- **Web/App Tier**: Stateless compute (horizontally scalable by default)
- **Data Tier**: Database + durable storage

**Design Rule**: The web/app tier should be horizontally scalable BY DEFAULT.

**What I'm Thinking**: "Where is state living? Where does it need to live?"

If state lives in app memory, scaling breaks it.

---

## Decision Tree 1: Scaling

```
Need to handle more load?
|
+-- Mostly CPU/RAM bound + small scale + OK if brief downtime?
|   +-- Vertical scale (scale up) as short-term patch
|
+-- Need high availability OR growth beyond one machine?
    +-- Horizontal scale (scale out)
        +-- Add load balancer
        +-- Make app tier stateless
        +-- Move state to shared systems (DB/cache/object storage)
```

**System-Designer Thought**: Vertical scaling is a DELAY TACTIC; horizontal scaling is an ARCHITECTURE CHOICE.

---

## Decision Tree 2: Database Choice

```
What is the data + correctness need?
|
+-- Strong transactions / invariants (money, inventory, ledgers)?
|   +-- SQL (Postgres/MySQL) + ACID + constraints
|
+-- Clear relationships + joins matter?
|   +-- SQL (normalized + indexes)
|
+-- Semi-structured JSON + evolving schema + high scale writes?
|   +-- Document or wide-co

