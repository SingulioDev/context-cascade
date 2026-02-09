

---
name: docker-containerization
version: 1.0.0
description: |
  Docker containerization specialist for multi-stage builds, layer caching optimization, security scanning with Trivy, Docker Compose orchestration, BuildKit advanced features, and production-grade Dock
category: Infrastructure
tags:
- general
author: system
---

# Docker Containerization Specialist

Expert Docker containerization for production-grade, secure, and optimized container images.

## Purpose

Comprehensive Docker expertise including multi-stage builds, layer caching, security scanning, Docker Compose, BuildKit features, and best practices. Ensures containers are small, fast, secure, and production-ready.

## When to Use

- Creating optimized Dockerfiles
- Implementing multi-stage builds
- Optimizing build caching
- Scanning images for vulnerabilities
- Orchestrating multi-container apps with Docker Compose
- Implementing CI/CD with Docker
- Troubleshooting container performance

## Prerequisites

**Required**: Basic Docker commands, understanding of containers vs VMs

**Agents**: `cicd-engineer`, `security-manager`, `code-analyzer`, `backend-dev`

## Core Workflows

### Workflow 1: Multi-Stage Node.js Build

```dockerfile
# syntax=docker/dockerfile:1
# Stage 1: Dependencies
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Stage 2: Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 3: Production
FROM node:18-alpine AS runner
WORKDIR /app

# Security: Run as non-root
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

# Copy only necessary files
COPY --from=deps --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist
COPY --chown=nodejs:nodejs package.json ./

USER nodejs
EXPOSE 3000
ENV NODE_ENV=production

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1); })"

CMD ["node", "dist/index.js"]
```

### Workflow 2: Python Multi-Stage Build

```dockerfile
# syntax=docker/dockerfile:1
FROM python:3.11-slim AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.11-slim

WORKDIR /app

# Copy Python dependencies from builder
COPY --from=builder /root/.local /root/.local

# Copy application code
COPY . .

# Security: Run as non-root
RUN useradd -m -u 1001 appuser
USER appuser

# Add .local/bin to PATH
ENV PATH=/root/.local/bin:$PATH

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"

CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Workflow 3: Docker Compose Multi-Service App

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
      target: runner
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://user:password@db:5432/mydb
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
    networks:
      - app-network
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - app-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    networks:
      - app-network
    command: redis-server --appendonly yes
    volumes:
      - redis-data:/data

networks:
  app-network:


