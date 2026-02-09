

---
name: agentdb-memory-patterns
version: 1.0.0
description: |
  Apply persistent memory patterns for AI agents using AgentDB. Implement session memory, configure long-term storage, enable pattern learning, and manage context across sessions. Use when building stat
category: platforms
tags:
- platforms
- integration
- tools
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

# AgentDB Memory Patterns

## What This Skill Does

**Use this skill to** implement memory management patterns for AI agents using AgentDB's persistent storage and ReasoningBank integration. **Apply** these patterns to enable agents to remember conversations, learn from interactions, and maintain context across sessions. **Deploy** triple-layer retention (24h/7d/30d+) for optimal memory organization.

**Performance**: 150x-12,500x faster than traditional solutions with 100% backward compatibility.

## Prerequisites

**Install** Node.js 18+ and AgentDB v1.0.7+. **Ensure** you have AgentDB via agentic-flow or standalone. **Review** agent architecture patterns before implementing memory systems.

## Quick Start with CLI

### Initialize AgentDB

**Run** these commands to set up your AgentDB instance with memory patterns:

```bash
# Initialize vector database
npx agentdb@latest init ./agents.db

# Or with custom dimensions
npx agentdb@latest init ./agents.db --dimension 768

# Use preset configurations
npx agentdb@latest init ./agents.db --preset large

# In-memory database for testing
npx agentdb@latest init ./memory.db --in-memory
```

### Start MCP S

