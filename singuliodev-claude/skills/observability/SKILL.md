

---
name: observability
version: 2.1.0
description: |
  Observability specialists hub for monitoring, logging, tracing, and alerting. Routes to specialists for metrics collection, log aggregation, distributed tracing, and incident response. Use for system
category: research
tags:
- general
author: system
---

# Observability

Central hub for monitoring, logging, tracing, and system observability.

## Phase 0: Expertise Loading

```yaml
expertise_check:
  domain: observability
  file: .claude/expertise/observability.yaml

  if_exists:
    - Load monitoring patterns
    - Load alerting rules
    - Apply SLO definitions

  if_not_exists:
    - Flag discovery mode
    - Document patterns learned
```

## When to Use This Skill

Use observability when:
- Setting up monitoring infrastructure
- Implementing logging strategies
- Configuring distributed tracing
- Creating dashboards and alerts
- Debugging production issues

## Observability Pillars

| Pillar | Purpose |
|--------|---------|
| Metrics | Quantitative measurements |
| Logs | Event records |
| Traces | Request flow tracking |
| Alerts | Incident notification |

## Tool Ecosystem

### Metrics
```yaml
tools:
  - Prometheus
  - Grafana
  - Datadog
  - CloudWatch
metrics_types:
  - Counters
  - Gauges
  - Histograms
  - Summaries
```

### Logging
```yaml
tools:
  - ELK Stack (Elasticsearch, Logstash, Kibana)
  - Loki
  - Splunk
  - CloudWatch Logs
patterns:
  - Structured logging (JSON)
  - Log levels
  - Correlation IDs
```

### Tracing
```yaml
tools:
  - Jaeger
  - Zipkin
  - OpenTelemetry
  - X-Ray
patterns:
  - Span context propagation
  - Baggage items
  - Sampling strategies
```

## SLO/SLI/SLA

```yaml
definitions:
  SLI: "Service Level Indicator - measurable metric"
  SLO: "Service Level Objective - target value"
  SLA: "Service Level Agreement - contractual commitment"

example:
  SLI: "Request latency p99"
  SLO: "99% of requests < 200ms"
  SLA: "99.9% availability per month"
```

## MCP Requirements

- **claude-flow**: For orchestration
- **Bash**: For tool CLI commands

## Recursive Improvement Integration (v2.1)

### Eval Harness Integration

```yaml
benchmark: observability-benchmark-v1
  tests:
    - obs-001: Monitoring coverage
    - obs-002: Alert quality
  minimum_scores:
    monitoring_coverage: 0.85
    alert_quality: 0.80
```

### Memory Namespace

```yaml
namespaces:
  - observability/configs/{id}: Monitoring configs
  - observability/dashboards: Dashboard templates
  - improvement/audits/observability: Skill audits
```

### Uncertainty Handling

```yaml
confidence_check:
  if confidence >= 0.8:
    - Proceed with implementation
  if confidence 0.5-0.8:
    - Confirm tool stack
  if confidence < 0.5:
    - Ask for infrastructure details
```

### Cross-Skill Coordination

Works with: **infrastructure**, **deployment-readiness**, **performance-analysis**

---

## !! SKILL COMPLETION VERIFICATION (MANDATORY) !!

- [ ] **Agent Spawning**: Spawned agent via Task()
- [ ] **Agent Registry Validation**: Agent from registry
- [ ] **TodoWrite Called**: Called with 5+ todos
- [ ] **Work Delegation**: Delegated to agents

**Remember: Skill() -> Task() -> TodoWrite() - ALWAYS**

## Core Principles

### 1. Three Pillars Integration
Comprehensive observability requires unified collection and correlation of metrics, logs, and traces - no single pillar provides complete system visibility.

**In practice:**
- Implement metrics collection for quantitative measurements (counters, gauges, histograms)
- Deploy structured logging with correlation IDs for event tracking across services
- Configure distributed tracing with span context propagation for request flow visualization
- Correlate all three pillars using common identifiers (trace IDs, request IDs, user IDs)

### 2. Proactive Alerting with SLO-Based Thresholds
Alerting must be driven by Service Level Objectives that reflect actual user impact, not arbitrary metric thresholds that generate noise.

**In practice:**
- Define SLIs (Service Level Indicators) that measure user-facing behavior (p99 latency, error rate)
- Set SLOs (Service Level Objectives) based on business requirements (99% requests < 200ms)
- Configure alerts to fire when SLO burn rate

