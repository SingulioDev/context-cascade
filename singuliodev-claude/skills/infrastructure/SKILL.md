

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

# Infrastructure Orchestration Skill

## Metadata
- **Skill ID**: infrastructure-orchestration
- **Category**: Infrastructure & DevOps
- **Tier**: Gold
- **Version**: 2.0.0
- **Last Updated**: 2025-11-02

## Overview

Comprehensive infrastructure orchestration skill that manages cloud resources, containerization, infrastructure as code (IaC), deployment automation, and monitoring setup. This parent skill coordinates specialized sub-skills for Docker containerization and Terraform IaC management.

## Capabilities

### Core Infrastructure Management
- **Cloud Provisioning**: Multi-cloud resource provisioning (AWS, Azure, GCP)
- **Container Orchestration**: Docker, Kubernetes, Docker Swarm
- **Infrastructure as Code**: Terraform, CloudFormation, Pulumi
- **Configuration Management**: Ansible, Chef, Puppet
- **Deployment Automation**: CI/CD pipelines, blue-green deployments
- **Monitoring & Observability**: Prometheus, Grafana, ELK stack, OpenTelemetry

### Specialized Sub-Skills
1. **Docker Containerization** (`docker-containerization/`)
   - Multi-stage builds, optimization, security scanning
   - Docker Compose orchestration
   - Registry management and image distribution

2. **Terraform IaC** (`terraform-iac/`)
   - Multi-cloud infrastructure provisioning
   - State management and GitOps workflows
   - Module development and reusability

## Trigger Conditions

Auto-invoke this skill when user mentions:
- "infrastructure", "cloud setup", "provision resources"
- "deploy to AWS/Azure/GCP", "multi-cloud"
- "container orchestration", "Kubernetes", "K8s"
- "infrastructure as code", "IaC", "Terraform", "CloudFormation"
- "monitoring setup", "observability", "logging"
- "configuration management", "Ansible"
- "CI/CD pipeline", "deployment automation"

## Agent Assignments

**Primary Agents**:
- `cicd-engineer` - CI/CD pipeline setup and deployment automation
- `backend-dev` - Infrastructure architecture and design
- `system-architect` - High-level infrastructure planning

**Supporting Agents**:
- `code-analyzer` - Infrastructure code review and optimization
- `reviewer` - Security and compliance validation
- `tester` - Infrastructure testing and validation

## Workflow

### 1. Assessment Phase
```yaml
Input: Infrastructure requirements, scale, compliance needs
Actions:
  - Analyze current infrastructure state
  - Identify gaps and requirements
  - Select appropriate tools and platforms
  - Design architecture with redundancy and scalability
Output: Infrastructure design document, technology stack selection
```

### 2. Provisioning Phase
```yaml
Input: Architecture design, resource specifications
Actions:
  - Write IaC templates (Terraform/CloudFormation)
  - Configure networking, security groups, IAM roles
  - Set up container orchestration (if needed)
  - Implement multi-region/AZ deployment
Output: IaC codebase, provisioned cloud resources
```

### 3. Deployment Automation Phase
```yaml
Input: Application artifacts, deployment strategy
Actions:
  - Configure CI/CD pipelines (GitHub Actions, GitLab CI, Jenkins)
  - Set up container registries and artifact storage
  - Implement blue-green or canary deployment strategies
  - Configure auto-scaling and load balancing
Output: Automated deployment pipeline, deployment scripts
```

### 4. Monitoring & Observability Phase
```yaml
Input: SLOs, SLIs, alerting requirements
Actions:
  - Deploy monitoring stack (Prometheus, Grafana, ELK)
  - Configure metrics collection and log aggregation
  - Set up distributed tracing (Jaeger, Zipkin)
  - Create dashboards and alerting rules
Output: Monitoring infrastructure, dashboards, alert configurations
```

### 5. Configuration Management Phase
```yaml
Input: Server configurations, application configs
Actions:
  - Write Ansible playbooks or Chef recipes
  - Implement configuration drift detection
  - Set up secrets management (Vault, AWS Secrets Manager)
  - Configure envir

