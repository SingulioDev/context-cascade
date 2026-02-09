

---
name: agentdb-advanced-features
version: 1.0.0
description: |
  Master advanced AgentDB features including QUIC synchronization, multi-database management, custom distance metrics, hybrid search, and distributed systems integration. Use when building distributed A
category: platforms
tags:
- platforms
- integration
- tools
triggers:
  - "when using advanced vector search"
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

# AgentDB Advanced Features

## What This Skill Does

Covers advanced AgentDB capabilities for distributed systems, multi-database coordination, custom distance metrics, hybrid search (vector + metadata), QUIC synchronization, and production deployment patterns. Enables building sophisticated AI systems with sub-millisecond cross-node communication and advanced search capabilities.

**Performance**: <1ms QUIC sync, hybrid search with filters, custom distance metrics.

## Prerequisites

- Node.js 18+
- AgentDB v1.0.7+ (via agentic-flow)
- Understanding of distributed systems (for QUIC sync)
- Vector search fundamentals

---

## QUIC Synchronization

### What is QUIC Sync?

QUIC (Quick UDP Internet Connections) enables sub-millisecond latency synchronization between AgentDB instances across network boundaries with automatic retry, multiplexing, and encryption.

**Benefits**:
- <1ms latency between nodes
- Multiplexed streams (multiple operations simultaneously)
- Built-in encryption (TLS 1.3)
- Automatic retry and recovery
- Event-based broadcasting

### Enable QUIC Sync

```typescript
import { createAgentDBAdapter } from 'agentic-flow/reasoningbank'

