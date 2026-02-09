

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for operations workflows
category: operations
tags:
- general
triggers:
  - "when analyzing performance"
author: system
---

# Performance Analysis Skill

Comprehensive performance analysis suite for identifying bottlenecks, profiling swarm operations, generating detailed reports, and providing actionable optimization recommendations.

## Overview

This skill consolidates all performance analysis capabilities:
- **Bottleneck Detection**: Identify performance bottlenecks across communication, processing, memory, and network
- **Performance Profiling**: Real-time monitoring and historical analysis of swarm operations
- **Report Generation**: Create comprehensive performance reports in multiple formats
- **Optimization Recommendations**: AI-powered suggestions for improving performance

## Quick Start

### Basic Bottleneck Detection
```bash
npx claude-flow bottleneck detect
```

### Generate Performance Report
```bash
npx claude-flow analysis performance-report --format html --include-metrics
```

### Analyze and Auto-Fix
```bash
npx claude-flow bottleneck detect --fix --threshold 15
```

## Core Capabilities

### 1. Bottleneck Detection

#### Command Syntax
```bash
npx claude-flow bottleneck detect [options]
```

#### Options
- `--swarm-id, -s <id>` - Analyze specific swarm (default: current)
- `--time-range, -t <range>` - Analysis period: 1h, 24h, 7d, all (default: 1h)
- `--threshold <percent>` - Bottleneck threshold percentage (default: 20)
- `--export, -e <file>` - Export analysis to file
- `--fix` - Apply automatic optimizations

#### Usage Examples
```bash
# Basic detection for current swarm
npx claude-flow bottleneck detect

# Analyze specific swarm over 24 hours
npx claude-flow bottleneck detect --swarm-id swarm-123 -t 24h

# Export detailed analysis
npx claude-flow bottleneck detect -t 24h -e bottlenecks.json

# Auto-fix detected issues
npx claude-flow bottleneck detect --fix --threshold 15

# Low threshold for sensitive detection
npx claude-flow bottleneck detect --threshold 10 --export critical-issues.json
```

#### Metrics Analyzed

**Communication Bottlenecks:**
- Message queue delays
- Agent response times
- Coordination overhead
- Memory access patterns
- Inter-agent communication latency

**Processing Bottlenecks:**
- Task completion times
- Agent utilization rates
- Parallel execution efficiency
- Resource contention
- CPU/memory usage patterns

**Memory Bottlenecks:**
- Cache hit rates
- Memory access patterns
- Storage I/O performance
- Neural pattern loading times
- Memory allocation efficiency

**Network Bottlenecks:**
- API call latency
- MCP communication delays
- External service timeouts
- Concurrent request limits
- Network throughput issues

#### Output Format
```
🔍 Bottleneck Analysis Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Summary
├── Time Range: Last 1 hour
├── Agents Analyzed: 6
├── Tasks Processed: 42
└── Critical Issues: 2

🚨 Critical Bottlenecks
1. Agent Communication (35% impact)
   └── coordinator → coder-1 messages delayed by 2.3s avg

2. Memory Access (28% impact)
   └── Neural pattern loading taking 1.8s per access

⚠️ Warning Bottlenecks
1. Task Queue (18% impact)
   └── 5 tasks waiting > 10s for assignment

💡 Recommendations
1. Switch to hierarchical topology (est. 40% improvement)
2. Enable memory caching (est. 25% improvement)
3. Increase agent concurrency to 8 (est. 20% improvement)

✅ Quick Fixes Available
Run with --fix to apply:
- Enable smart caching
- Optimize message routing
- Adjust agent priorities
```

### 2. Performance Profiling

#### Real-time Detection
Automatic analysis during task execution:
- Execution time vs. complexity
- Agent utilization rates
- Resource constraints
- Operation patterns

#### Common Bottleneck Patterns

**Time Bottlenecks:**
- Tasks taking > 5 minutes
- Sequential operations that could parallelize
- Redundant file operations
- Inefficient algorithm implementations

**Coordination Bottlenecks:**
- Single agent for complex tasks
- Unbalanced agent workloads
- Poor topology selection
- Excessive s

