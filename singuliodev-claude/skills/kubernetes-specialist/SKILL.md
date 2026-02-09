

---
name: kubernetes-specialist
version: 1.0.0
description: |
  Kubernetes orchestration expert for Helm chart development, custom operators and CRDs, service mesh (Istio/Linkerd), auto-scaling strategies (HPA/VPA/Cluster Autoscaler), multi-cluster management, and
category: Cloud Platforms
tags:
- general
author: system
---

# Kubernetes Specialist

Expert Kubernetes orchestration for cloud-native applications with production-grade deployments.

## Purpose

Comprehensive Kubernetes expertise including Helm charts, custom operators, service mesh, auto-scaling, and GitOps. Ensures K8s deployments are resilient, secure, observable, and cost-effective.

## When to Use

- Deploying microservices to Kubernetes
- Creating Helm charts for reusable deployments
- Implementing auto-scaling (HPA, VPA, Cluster Autoscaler)
- Setting up service mesh for advanced networking
- Building custom operators with Operator SDK
- Implementing GitOps with ArgoCD or Flux
- Optimizing pod scheduling and resource allocation

## Prerequisites

**Required**: Docker, kubectl, basic K8s concepts (Pods, Services, Deployments)

**Agents**: `system-architect`, `cicd-engineer`, `perf-analyzer`, `security-manager`

## Core Workflows

### Workflow 1: Production-Grade Deployment

**Step 1: Create Deployment Manifest**

```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  labels:
    app: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
        version: v1
    spec:
      containers:
      - name: app
        image: myregistry/my-app:v1.0.0
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
        securityContext:
          runAsNonRoot: true
          readOnlyRootFilesystem: true
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - my-app
              topologyKey: kubernetes.io/hostname
```

**Step 2: Create Service and Ingress**

```yaml
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: ClusterIP

---
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/rate-limit: "100"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - my-app.example.com
    secretName: my-app-tls
  rules:
  - host: my-app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
```

### Workflow 2: Helm Chart Development

**Step 1: Create Helm Chart**

```bash
helm create my-app
cd my-app
```

**Step 2: Define Values.yaml**

```yaml
# values.yaml
replicaCount: 3

image:
  repository: myregistry/my-app
  tag: "v1.0.0"
  pullPolicy: IfNotPresent

resources:
  requests:
    memory: "128Mi"
    cpu: "100m"
  limits:
    memory: "256Mi"
    cpu: "500m"

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: my-app-tls
      hosts:
        - my-app.example.com
```

**Step 3: Template Deployment**

```yaml
# templates/depl

