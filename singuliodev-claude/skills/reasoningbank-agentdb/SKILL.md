

---
name: reasoningbank-with-agentdb
version: 1.0.0
description: |
  Implement ReasoningBank adaptive learning with AgentDB's 150x faster vector database. Includes trajectory tracking, verdict judgment, memory distillation, and pattern recognition. Use when building se
category: platforms
tags:
- platforms
- integration
- tools
triggers:
  - "when implementing adaptive learning"
author: ruv
---

## When NOT to Use This Skill

- Local-only operations with no vector search needs
- Simple key-value storage without semantic similarity
- Real-time streaming data without persistence requirements
- Operations that do not require embedding-based retrieval

## Success Criteria
- Vector search query latency: <10ms for 99th percentile
- Embedding generation: <100ms per document
- Index build time: <1s per 1000 vectors
- Recall@10: >0.95 for similar documents
- Database connection success rate: >99.9%
- Memory footprint: <2GB for 1M vectors with quantization

## Edge Cases & Error Handling

- **Rate Limits**: AgentDB local instances have no rate limits; cloud deployments may vary
- **Connection Failures**: Implement retry logic with exponential backoff (max 3 retries)
- **Index Corruption**: Maintain backup indices; rebuild from source if corrupted
- **Memory Overflow**: Use quantization (4-bit, 8-bit) to reduce memory by 4-32x
- **Stale Embeddings**: Implement TTL-based refresh for dynamic content
- **Dimension Mismatch**: Validate embedding dimensions (384 for sentence-transformers) before insertion

## Guardrails & Safety
- NEVER: expose database connection strings in logs or error messages
- ALWAYS: validate vector dimensions before insertion
- ALWAYS: sanitize metadata to prevent injection attacks
- NEVER: store PII in vector metadata without encryption
- ALWAYS: implement access control for multi-tenant deployments
- ALWAYS: validate search results before returning to users

## Evidence-Based Validation

- Verify database health: Check connection status and index integrity
- Validate search quality: Measure recall/precision on test queries
- Monitor performance: Track query latency, throughput, and memory usage
- Test failure recovery: Simulate connection drops and index corruption
- Benchmark improvements: Compare against baseline metrics (e.g., 150x speedup claim)

# ReasoningBank with AgentDB

## What This Skill Does

Provides ReasoningBank adaptive learning patterns using AgentDB's high-performance backend (150x-12,500x faster). Enables agents to learn from experiences, judge outcomes, distill memories, and improve decision-making over time with 100% backward compatibility.

**Performance**: 150x faster pattern retrieval, 500x faster batch operations, <1ms memory access.

## Prerequisites

- Node.js 18+
- AgentDB v1.0.7+ (via agentic-flow)
- Understanding of reinforcement learning concepts (optional)

---

## Quick Start with CLI

### Initialize ReasoningBank Database

```bash
# Initialize AgentDB for ReasoningBank
npx agentdb@latest init ./.agentdb/reasoningbank.db --dimension 1536

# Start MCP server for Claude Code integration
npx agentdb@latest mcp
claude mcp add agentdb npx agentdb@latest mcp
```

### Migrate from Legacy ReasoningBank

```bash
# Automatic migration with validation
npx agentdb@latest migrate --source .swarm/memory.db

# Verify migration
npx agentdb@latest stats ./.agentdb/reasoningbank.db
```

---

## Quick Start with API

```typescript
import { createAgentDBAdapter, computeEmbedding }

