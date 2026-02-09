

---
name: sql-database-specialist
version: 1.0.0
description: |
  SQL database specialist for PostgreSQL/MySQL optimization, EXPLAIN plan analysis, index optimization, query rewriting, partitioning strategies, connection pooling, and database performance tuning. Use
category: Database Specialists
tags:
- general
author: system
---

# SQL Database Specialist

Expert SQL database optimization, schema design, and performance tuning for PostgreSQL and MySQL.

## Purpose

Comprehensive SQL expertise including EXPLAIN plan analysis, index optimization, query rewriting, partitioning, replication, and performance tuning. Ensures databases are fast, scalable, and maintainable.

## When to Use

- Optimizing slow database queries
- Designing efficient database schemas
- Analyzing EXPLAIN plans
- Creating optimal indexes
- Implementing database partitioning
- Setting up replication and high availability
- Migrating data with zero downtime
- Troubleshooting performance issues

## Prerequisites

**Required**: SQL basics, understanding of relational databases, familiarity with PostgreSQL or MySQL

**Agents**: `backend-dev`, `perf-analyzer`, `system-architect`, `code-analyzer`

## Core Workflows

### Workflow 1: Query Optimization with EXPLAIN

**Step 1: Analyze EXPLAIN Plan (PostgreSQL)**

```sql
-- EXPLAIN shows query plan
EXPLAIN
SELECT u.name, o.total
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.created_at > '2024-01-01';

-- EXPLAIN ANALYZE executes and shows actual timings
EXPLAIN (ANALYZE, BUFFERS)
SELECT u.name, o.total
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.created_at > '2024-01-01';
```

**Key Metrics to Check**:
- **Seq Scan** (bad): Full table scan, add index
- **Index Scan** (good): Using index
- **Bitmap Index Scan** (good): Efficient for multiple conditions
- **Nested Loop** (watch out): Can be slow for large datasets
- **Hash Join** (usually good): Efficient join method
- **Cost**: Estimated cost (lower is better)
- **Actual time**: Real execution time

**Step 2: Create Optimal Index**

```sql
-- ❌ SLOW: No index on created_at
SELECT * FROM orders WHERE created_at > '2024-01-01';

-- ✅ FAST: Create index
CREATE INDEX idx_orders_created_at ON orders (created_at);

-- ✅ COMPOUND INDEX: For multiple columns
CREATE INDEX idx_orders_user_created
ON orders (user_id, created_at);

-- ✅ PARTIAL INDEX: For filtered queries
CREATE INDEX idx_orders_pending
ON orders (created_at)
WHERE status = 'pending';

-- ✅ COVERING INDEX: Include frequently queried columns
CREATE INDEX idx_orders_covering
ON orders (user_id, created_at)
INCLUDE (total, status);
```

**Step 3: Rewrite Query for Performance**

```sql
-- ❌ SLOW: N+1 query pattern
SELECT id, name FROM users;
-- Then for each user:
SELECT * FROM orders WHERE user_id = ?;

-- ✅ FAST: Single query with JOIN
SELECT u.id, u.name, o.*
FROM users u
LEFT JOIN orders o ON u.id = o.user_id;

-- ❌ SLOW: NOT IN with subquery
SELECT * FROM users
WHERE id NOT IN (SELECT user_id FROM orders);

-- ✅ FAST: LEFT JOIN with NULL check
SELECT u.*
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.user_id IS NULL;

-- ❌ SLOW: OR conditions prevent index use
SELECT * FROM orders
WHERE user_id = 123 OR status = 'pending';

-- ✅ FAST: UNION ALL with indexes
SELECT * FROM orders WHERE user_id = 123
UNION ALL
SELECT * FROM orders WHERE status = 'pending' AND user_id != 123;
```

### Workflow 2: Table Partitioning (PostgreSQL)

**Step 1: Create Partitioned Table**

```sql
-- Range partitioning by date
CREATE TABLE orders (
  id BIGSERIAL,
  user_id INT NOT NULL,
  created_at DATE NOT NULL,
  total DECIMAL(10, 2),
  status VARCHAR(20)
) PARTITION BY RANGE (created_at);

-- Create partitions
CREATE TABLE orders_2024_q1 PARTITION OF orders
FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE orders_2024_q2 PARTITION OF orders
FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

-- Create index on each partition
CREATE INDEX idx_orders_2024_q1_user_id
ON orders_2024_q1 (user_id);

-- Queries automatically use correct partition
SELECT * FROM orders
WHERE created_at >= '2024-02-01'
  AND created_at < '2024-03-01';
-- Only scans orders_2024_q1 partition
```

**Step 2: List Partitioning by Status**

```sql
CREATE TABLE orders_

