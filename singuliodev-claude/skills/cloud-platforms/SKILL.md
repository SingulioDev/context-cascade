

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

# Cloud Platforms - Multi-Cloud Infrastructure ⭐ GOLD TIER

Comprehensive cloud deployment and management for AWS, Google Cloud, and Azure platforms with production-ready automation scripts, infrastructure templates, and multi-cloud testing.

**Tier:** Gold
**Version:** 2.0.0
**Files:** 20
**Scripts:** 4 automation tools
**Templates:** 4 IaC configurations
**Tests:** 3 comprehensive suites

## When to Use This Skill

Use when deploying applications to cloud platforms, implementing serverless architectures (Lambda, Cloud Functions), managing containerized workloads (ECS, GKE, AKS), or provisioning cloud infrastructure with Terraform/CloudFormation.

## Supported Platforms

### AWS (Amazon Web Services)
- **Compute**: EC2, Lambda, ECS, Fargate, Batch
- **Storage**: S3, EBS, EFS, Glacier
- **Database**: RDS, DynamoDB, Aurora, Redshift
- **Networking**: VPC, Route 53, CloudFront, API Gateway
- **IaC**: CloudFormation, AWS CDK

### Google Cloud Platform
- **Compute**: Compute Engine, Cloud Functions, GKE, Cloud Run
- **Storage**: Cloud Storage, Persistent Disk, Filestore
- **Database**: Cloud SQL, Firestore, BigQuery, Spanner
- **Networking**: VPC, Cloud CDN, Cloud Load Balancing
- **IaC**: Deployment Manager, Terraform

### Microsoft Azure
- **Compute**: VMs, Azure Functions, AKS, Container Instances
- **Storage**: Blob Storage, Disk Storage, Azure Files
- **Database**: SQL Database, Cosmos DB, Synapse Analytics
- **Networking**: Virtual Network, Traffic Manager, Front Door
- **IaC**: ARM Templates, Bicep, Terraform

## Process

1. **Define requirements**
   - Determine workload type (compute, storage, database)
   - Assess scaling needs
   - Identify compliance requirements
   - Estimate costs

2. **Select platform and services**
   - Choose cloud provider (AWS/GCP/Azure)
   - Pick appropriate services for workload
   - Design for high availability
   - Plan disaster recovery

3. **Provision infrastructure**
   - Use Infrastructure as Code (Terraform, CloudFormation)
   - Implement security best practices
   - Configure networking and access
   - Set up monitoring and logging

4. **Deploy applications**
   - Containerize with Docker
   - Use CI/CD pipelines
   - Implement blue-green or canary deployments
   - Configure auto-scaling

5. **Monitor and optimize**
   - Track resource utilization
   - Optimize costs (right-sizing, spot instances)
   - Review security posture
   - Implement performance improvements

## Best Practices

- **Multi-region**: Deploy across regions for high availability
- **Infrastructure as Code**: Never provision manually
- **Cost Optimization**: Use reserved instances, spot instances
- **Security**: Least privilege IAM, encryption at rest/transit
- **Monitoring**: CloudWatch, Stackdriver, Azure Monitor

## 🚀 Automation Tools (Gold Tier)

### Deployment Scripts
Located in `resources/scripts/`:

1. **`deploy_aws.py`** (14 KB)
   - AWS Lambda, ECS Fargate, CloudFormation, EC2 deployment
   - Usage: `python deploy_aws.py lambda --name func --zip code.zip --handler index.handler`

2. **`deploy_k8s.sh`** (8.3 KB)
   - Kubernetes kubectl, Helm chart deployment
   - Usage: `./deploy_k8s.sh helm myapp ./charts/app production values.yaml`

3. **`terraform_apply.py`** (13 KB)
   - Terraform automation with validation, planning, state management
   - Usage: `python terraform_apply.py apply --var-file prod.tfvars`

4. **`gcp_deploy.sh`** (10 KB)
   - GCP Cloud Run, Cloud Functions, GKE, Compute Engine deployment
   - Usage: `./gcp_deploy.sh cloud-run myservice gcr.io/project/image us-central1`

### Infrastructure Templates
Located in `resources/templates/`:

1. **`aws-infra.tf`** (14 KB)
   - Complete AWS VPC, ALB, ECS Fargate, RDS setup
   - 30+ Terraform resources for production deployment

2. **`k8s-deployment.yaml`** (7.2 KB)
   - Production Kubernetes manifest with HPA, Ingress, PDB
   - 10 K8s resources with health checks and monit

