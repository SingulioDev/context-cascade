

---
name: terraform-iac
version: 1.0.0
description: |
  Terraform infrastructure as code specialist for multi-cloud deployments (AWS/GCP/Azure), state management with remote backends, module development, drift detection, policy as code with Sentinel/OPA, a
category: Infrastructure
tags:
- general
author: system
---

# Terraform Infrastructure as Code Specialist

Expert Terraform for cloud-agnostic infrastructure provisioning and state management.

## Purpose

Comprehensive Terraform expertise including multi-cloud deployments, state management, module development, drift detection, and GitOps. Ensures infrastructure is versioned, reproducible, and maintainable.

## When to Use

- Provisioning cloud infrastructure (AWS, GCP, Azure)
- Managing infrastructure state with remote backends
- Creating reusable Terraform modules
- Implementing GitOps for infrastructure
- Detecting and fixing infrastructure drift
- Migrating from manual infrastructure to IaC
- Multi-environment deployments (dev, staging, prod)

## Prerequisites

**Required**: Cloud provider basics (AWS/GCP/Azure), HCL syntax, Terraform CLI

**Agents**: `system-architect`, `cicd-engineer`, `security-manager`, `reviewer`

## Core Workflows

### Workflow 1: AWS Infrastructure with Modules

**Step 1: Directory Structure**

```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── terraform.tfvars
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

**Step 2: Main Configuration**

```hcl
# main.tf
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = var.project_name
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  environment        = var.environment
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_subnet_ids
  instance_type     = var.instance_type
  instance_count    = var.instance_count
  security_group_id = module.vpc.security_group_id
}
```

**Step 3: Variables and Outputs**

```hcl
# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# outputs.tf
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "instance_ids" {
  description = "EC2 instance IDs"
  value       = module.ec2.instance_ids
}
```

### Workflow 2: Dynamic Blocks and for_each

```hcl
# Dynamic ingress rules
resource "aws_security_group" "app" {
  name   = "${var.environment}-app-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# for_each for multiple resources
resource "aws_instance" "app" {
  for_each = toset(var.availability_zones)

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[each.key]

  tags = {
    Name = "${var.environment}-app-${each.key}"
    AZ   = each.v

