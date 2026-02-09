

---
name: agentdb-performance-optimization
version: 1.0.0
description: |
  Apply quantization to reduce memory by 4-32x. Enable HNSW indexing for 150x faster search. Configure caching strategies and implement batch operations. Use when optimizing memory usage, improving sear
category: platforms
tags:
- platforms
- integration
- tools
triggers:
  - "when optimizing vector search"
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

# AgentDB Performance Optimization

## What This Skill Does

**Use this skill to** apply comprehensive performance optimization techniques for AgentDB vector databases. **Implement** quantization strategies (binary, scalar, product) to achieve 4-32x memory reduction. **Enable** HNSW indexing for 150x-12,500x performance improvements. **Configure** caching strategies and **deploy** batch operations to reduce memory usage while maintaining accuracy.

**Performance**: <100µs vector search, <1ms pattern retrieval, 2ms batch insert for 100 vectors.

## Prerequisites

**Install** Node.js 18+ and AgentDB v1.0.7+ via agentic-flow. **Verify** you have an existing AgentDB database or application ready for optimization.

---

## Quick Start

**Execute** these steps to measure and optimize your AgentDB performance.

### Run Performance Benchmarks

**Execute** benchmarks to establish baseline performance:

```bash
# Comprehensive performance benchmarking
npx agentdb@latest benchmark

# Results show:
# ✅ Pattern Search: 150x faster (100µs vs 15ms)
# ✅ Batch Insert: 500x faster (2ms vs 1s for 100 vectors)
# ✅ Large-scale Query: 12,500x faster (8ms vs 100s at 1M v

