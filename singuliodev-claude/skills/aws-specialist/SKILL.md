

---
name: aws-specialist
version: 1.0.0
description: |
  AWS cloud specialist for infrastructure as code with CloudFormation/CDK, serverless with Lambda, container orchestration with ECS/Fargate, database management with RDS, storage with S3/CloudFront CDN,
category: Cloud Platforms
tags:
- general
author: system
---

# AWS Specialist

Expert AWS cloud infrastructure design, deployment, and optimization for production-grade applications.

## Purpose

Comprehensive AWS expertise across IaC (CloudFormation, CDK), serverless (Lambda), containers (ECS/Fargate), databases (RDS, DynamoDB), storage (S3), CDN (CloudFront), and DevOps automation. Ensures AWS architectures are secure, cost-effective, and scalable.

## When to Use

- Deploying applications to AWS
- Creating infrastructure as code templates
- Setting up serverless architectures
- Configuring auto-scaling and load balancing
- Implementing multi-region deployments
- Optimizing AWS costs (FinOps)
- Securing AWS resources with IAM

## Prerequisites

**Required**: AWS account, AWS CLI installed, basic understanding of cloud concepts

**Agent Assignments**: `cicd-engineer`, `system-architect`, `security-manager`, `perf-analyzer`

## Core Workflows

### Workflow 1: AWS CDK Infrastructure as Code

**Step 1: Initialize CDK Project**

```bash
mkdir my-infra && cd my-infra
npx cdk init app --language typescript
npm install @aws-cdk/aws-lambda @aws-cdk/aws-apigateway @aws-cdk/aws-dynamodb
```

**Step 2: Define Lambda + API Gateway Stack**

```typescript
// lib/api-stack.ts
import * as cdk from 'aws-cdk-lib';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as apigateway from 'aws-cdk-lib/aws-apigateway';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';

export class ApiStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // DynamoDB table
    const table = new dynamodb.Table(this, 'ItemsTable', {
      partitionKey: { name: 'id', type: dynamodb.AttributeType.STRING },
      billingMode: dynamodb.BillingMode.PAY_PER_REQUEST,
      removalPolicy: cdk.RemovalPolicy.DESTROY, // ONLY for dev
    });

    // Lambda function
    const handler = new lambda.Function(this, 'ItemsHandler', {
      runtime: lambda.Runtime.NODEJS_18_X,
      code: lambda.Code.fromAsset('lambda'),
      handler: 'index.handler',
      environment: {
        TABLE_NAME: table.tableName,
      },
    });

    table.grantReadWriteData(handler);

    // API Gateway
    const api = new apigateway.RestApi(this, 'ItemsApi', {
      restApiName: 'Items Service',
    });

    const items = api.root.addResource('items');
    items.addMethod('GET', new apigateway.LambdaIntegration(handler));
    items.addMethod('POST', new apigateway.LambdaIntegration(handler));
  }
}
```

**Step 3: Deploy Stack**

```bash
# Bootstrap CDK (first time only)
cdk bootstrap

# Deploy
cdk deploy
```

### Workflow 2: ECS Fargate Deployment

**Step 1: Create Fargate Service with CDK**

```typescript
import * as ecs from 'aws-cdk-lib/aws-ecs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as elbv2 from 'aws-cdk-lib/aws-elasticloadbalancingv2';

export class FargateStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = new ec2.Vpc(this, 'MyVpc', { maxAzs: 2 });

    const cluster = new ecs.Cluster(this, 'MyCluster', { vpc });

    const taskDefinition = new ecs.FargateTaskDefinition(this, 'TaskDef', {
      memoryLimitMiB: 512,
      cpu: 256,
    });

    taskDefinition.addContainer('web', {
      image: ecs.ContainerImage.fromRegistry('nginx'),
      portMappings: [{ containerPort: 80 }],
      logging: ecs.LogDrivers.awsLogs({ streamPrefix: 'MyApp' }),
    });

    const service = new ecs.FargateService(this, 'Service', {
      cluster,
      taskDefinition,
      desiredCount: 2,
    });

    const lb = new elbv2.ApplicationLoadBalancer(this, 'LB', {
      vpc,
      internetFacing: true,
    });

    const listener = lb.addListener('Listener', { port: 80 });
    listener.addTargets('ECS', {
      port: 80,
      targets: [service],
      healthCheck: { path: '/' },
    });
  }
}
```

### Workflow 3:

