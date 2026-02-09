

---
name: reasoningbank-intelligence
version: 1.0.0
description: |
  Implement adaptive learning with ReasoningBank for pattern recognition, strategy optimization, and continuous improvement. Use when building self-learning agents, optimizing workflows, or implementing
category: platforms
tags:
- platforms
- integration
- tools
triggers:
  - "when optimizing agent learning"
author: ruv
---

## When NOT to Use This Skill

- Simple fact retrieval without reasoning chains
- Operations that do not require logical inference
- Tasks without complex multi-step reasoning needs
- Applications that do not benefit from reasoning trace storage

## Success Criteria
- Reasoning chain accuracy: >90% logically valid steps
- Retrieval relevance: Top-5 recall >0.85 for similar reasoning
- Storage efficiency: <1MB per 100 reasoning chains
- Query latency: <50ms for reasoning retrieval
- Integration success: Seamless connection with AgentDB backend

## Edge Cases & Error Handling

- **Invalid Reasoning Chains**: Validate logical consistency before storage
- **Retrieval Failures**: Fallback to alternative search strategies
- **Storage Limits**: Implement pruning strategies for old/low-quality chains
- **Embedding Mismatches**: Ensure consistent embedding models across storage/retrieval
- **Circular Reasoning**: Detect and prevent circular reference chains

## Guardrails & Safety
- NEVER: store reasoning chains with sensitive or PII data
- ALWAYS: validate reasoning quality before storage
- ALWAYS: sanitize inputs to prevent prompt injection
- NEVER: expose internal reasoning structures in public APIs
- ALWAYS: implement access control for reasoning retrieval
- ALWAYS: audit reasoning chains for bias and harmful content

## Evidence-Based Validation

- Verify reasoning quality: Check logical consistency and validity
- Validate retrieval: Test that similar reasoning is correctly retrieved
- Monitor storage: Track database size and query performance
- Test edge cases: Validate handling of complex/invalid reasoning chains
- Benchmark improvements: Measure reasoning quality vs baseline methods

# ReasoningBank Intelligence

## What This Skill Does

Implements ReasoningBank's adaptive learning system for AI agents to learn from experience, recognize patterns, and optimize strategies over time. Enables meta-cognitive capabilities and continuous improvement.

## Prerequisites

- agentic-flow v1.5.11+
- AgentDB v1.0.4+ (for persistence)
- Node.js 18+

## Quick Start

```typescript
import { ReasoningBank } from 'agentic-flow/reasoningbank';

// Initialize ReasoningBank
const rb = new ReasoningBank({
  persist: true,
  learningRate: 0.1,
  adapter: 'agentdb' // Use AgentDB for storage
});

// Record task outcome
await rb.recordExperience({
  task: 'code_review',
  approach: 'static_analysis_first',
  outcome: {
    success: true,
    metrics: {
      bugs_found: 5,
      time_taken: 120,
      false_positives: 1
    }
  },
  context: {
    language: 'typescript',
    complexity: 'medium'
  }
});

// Get optimal strategy
const strategy = await rb.recommendStrategy('code_review', {
  language: 'typescript',
  complexity: 'high'
});
```

## Core Features

### 1. Pattern Recognition
```typescript
// Learn patterns from data
await rb.learnPattern({
  pattern: 'api_errors_increase_after_deploy',
  triggers: ['deployment', 'traffic_spike'],
  actions: ['rollback', 'scale_up'],
  confidence: 0.85
});

// Match patterns
const matches = await rb.matchPatterns(currentSituation);
```

### 2. Strategy Optimization
```typ

