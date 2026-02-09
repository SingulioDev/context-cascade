

---
name: agentdb-learning-plugins
version: 1.0.0
description: |
  Create AI learning plugins using AgentDB's 9 reinforcement learning algorithms. Train Decision Transformer, Q-Learning, SARSA, and Actor-Critic models. Deploy these plugins to build self-learning agen
category: platforms
tags:
- platforms
- integration
- tools
triggers:
  - "when training rl agents"
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

# AgentDB Learning Plugins

## What This Skill Does

**Use this skill to** create, train, and deploy learning plugins for autonomous agents using AgentDB's 9 reinforcement learning algorithms. **Implement** offline RL (Decision Transformer) for safe learning from logged experiences. **Apply** value-based learning (Q-Learning) for discrete actions. **Deploy** policy gradients (Actor-Critic) for continuous control. **Enable** agents to improve through experience with WASM-accelerated neural inference.

**Performance**: Train models 10-100x faster with WASM-accelerated neural inference.

## Prerequisites

- Node.js 18+
- AgentDB v1.0.7+ (via agentic-flow)
- Basic understanding of reinforcement learning (recommended)

---

## Quick Start with CLI

### Create Learning Plugin

```bash
# Interactive wizard
npx agentdb@latest create-plugin

# Use specific template
npx agentdb@latest create-plugin -t decision-transformer -n my-agent

# Preview without creating
npx agentdb@latest create-plugin -t q-learning --dry-run

# Custom output directory
npx agentdb@latest create-plugin -t actor-critic -o ./plugins
```

### List Available Templates

```bash
# Show all

