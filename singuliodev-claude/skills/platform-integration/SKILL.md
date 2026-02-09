

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

# Platform Integration

## Purpose

Execute enterprise-grade platform integration with comprehensive API connectivity, webhook automation, data synchronization, and event-driven coordination across multiple platforms and services.

## Specialist Agent

I am a platform integration architect specializing in multi-platform connectivity.

**Methodology** (Integration Lifecycle Pattern):
1. Discovery & mapping (API/webhook analysis)
2. Authentication strategy (OAuth, API keys, JWT)
3. Integration architecture design
4. Connector implementation (API clients, SDKs)
5. Webhook handler development
6. Data transformation pipelines
7. Synchronization engine setup
8. Error handling & retry logic
9. Monitoring & observability
10. Testing & validation
11. Documentation generation
12. Production deployment

**Supported Platforms**:
- **Cloud**: AWS, Azure, GCP, Salesforce, HubSpot
- **DevOps**: GitHub, GitLab, Jira, CircleCI, Jenkins
- **Commerce**: Stripe, Shopify, WooCommerce, PayPal
- **Communication**: Slack, Discord, Twilio, SendGrid
- **Databases**: PostgreSQL, MongoDB, Redis, Elasticsearch
- **Message Queues**: RabbitMQ, Kafka, AWS SQS, Azure Service Bus

**Integration Patterns**:
- **API-First**: RESTful, GraphQL, gRPC
- **Event-Driven**: Webhooks, WebSockets, SSE
- **Message Queues**: Pub/Sub, AMQP, MQTT
- **Data Sync**: ETL, CDC, batch/real-time
- **Orchestration**: Workflow engines, state machines

## Input Contract

```yaml
input:
  platforms: array[object] # Platform configurations
    - name: string (e.g., "salesforce", "stripe")
      type: string (api|webhook|sync)
      auth: object (credentials, tokens)
      endpoints: array[string]
  integration_type: string # "api_integration" | "webhook_automation" | "data_sync" | "full"
  sync_direction: string # "bidirectional" | "source_to_target" | "target_to_source"
  sync_frequency: string # "real_time" | "hourly" | "daily" | "on_demand"
  error_strategy: string # "retry" | "dead_letter" | "alert" | "fallback"
  monitoring: boolean # Enable observability (default: true)
```

## Output Contract

```yaml
output:
  artifacts:
    connectors: directory # API client implementations
    handlers: directory # Webhook handlers
    sync_engine: directory # Data synchronization
    tests: directory # Integration test suite
    configs: array[file] # Configuration files
    docs: markdown # Integration documentation
  metrics:
    api_latency_p95: number # ms
    webhook_success_rate: number # percentage
    sync_throughput: number # records/sec
    error_rate: number # percentage
  endpoints:
    api_base_url: string
    webhook_url: string
    health_check: string
  monitoring:
    dashboard_url: string
    alerts: array[object]
```

## Execution Flow

```bash
#!/bin/bash
set -e

INTEGRATION_TYPE="${1:-full}"
PLATFORMS_CONFIG="$2"
OUTPUT_DIR="platform-integration-$(date +%s)"

mkdir -p "$OUTPUT_DIR"/{connectors,handlers,sync,tests,configs,docs,monitoring}

echo "================================================================"
echo "Platform Integration Orchestration"
echo "Type: $INTEGRATION_TYPE | Platforms: $PLATFORMS_CONFIG"
echo "================================================================"

# STAGE 1: Discovery & Mapping
echo "[1/12] Discovering platform capabilities..."
python3 resources/scripts/api-connector.py \
  --mode discovery \
  --config "$PLATFORMS_CONFIG" \
  --output "$OUTPUT_DIR/discovery-report.json"

# STAGE 2: Authentication Strategy
echo "[2/12] Configuring authentication..."
cat > "$OUTPUT_DIR/configs/auth-config.yaml" <<EOF
authentication:
  strategy: oauth2 # or api_key, jwt, basic
  providers:
    - name: primary_platform
      type: oauth2
      client_id: \${CLIENT_ID}
      client_secret: \${CLIENT_SECRET}
      token_url: https://oauth.example.com/token
      scopes: [read, write]

  token_management:
    refresh_strategy: automatic
    expiry_buffer: 300 # seconds before ex

