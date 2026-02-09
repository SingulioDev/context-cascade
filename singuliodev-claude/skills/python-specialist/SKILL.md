

---
name: python-specialist
version: 1.0.0
description: |
  Expert Python development specialist for backend APIs, async/await optimization, Django/Flask/FastAPI frameworks, type hints, packaging, and performance profiling. Use when building Python backend ser
category: Language Specialists
tags:
- general
author: system
---

# Python Specialist

Expert Python development for modern backend systems, API development, and high-performance applications.

## Purpose

This skill provides comprehensive Python expertise across frameworks, async patterns, type safety, and production deployment. It ensures Python code follows best practices, leverages modern features (Python 3.10+), and achieves optimal performance.

## When to Use This Skill

Activate this skill when:
- Building backend APIs with Django REST Framework, FastAPI, or Flask
- Implementing async/await patterns with asyncio or trio
- Optimizing Python performance (cProfile, memory_profiler, line_profiler)
- Setting up Python projects with proper dependency management
- Writing type-safe code with type hints and mypy validation
- Creating Python packages with setuptools or poetry
- Debugging production Python issues
- Migrating from Python 2 to Python 3 or upgrading to modern Python

## Prerequisites

**Required Knowledge**:
- Python 3.10+ syntax and standard library
- Virtual environment concepts (venv, virtualenv, conda)
- Basic understanding of HTTP and REST principles

**Required Tools**:
- Python 3.10+ installed
- pip and venv available
- Code editor with Python support

**Agent Assignments**:
- `backend-dev`: Primary Python implementation
- `coder`: General coding and refactoring
- `tester`: pytest test suite creation
- `code-analyzer`: Code quality and connascence analysis
- `perf-analyzer`: Performance optimization

## Core Workflows

### Workflow 1: FastAPI REST API Development

**Step 1: Initialize Project Structure**

Create a production-ready FastAPI project with proper organization:

```bash
# Create project structure
mkdir -p my_api/{app,tests,alembic}
cd my_api

# Initialize virtual environment
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# Install dependencies
pip install fastapi uvicorn[standard] pydantic pydantic-settings sqlalchemy alembic pytest pytest-asyncio httpx
```

**Step 2: Define Data Models with Pydantic**

Create type-safe models with validation:

```python
# app/models.py
from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from datetime import datetime

class UserBase(BaseModel):
    email: str = Field(..., description="User email address")
    username: str = Field(..., min_length=3, max_length=50)

class UserCreate(UserBase):
    password: str = Field(..., min_length=8)

class UserResponse(UserBase):
    id: int
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)
```

**Step 3: Implement API Routes with Dependency Injection**

```python
# app/main.py
from fastapi import FastAPI, Depends, HTTPException, status
from typing import Annotated
from .models import UserCreate, UserResponse
from .dependencies import get_db, get_current_user

app = FastAPI(title="My API", version="1.0.0")

@app.post("/users", response_model=UserResponse, status_code=status.HTTP_201_CREATED)
async def create_user(
    user: UserCreate,
    db: Annotated[AsyncSession, Depends(get_db)]
) -> UserResponse:
    """Create a new user with email validation."""
    # Implementation
    return user_response

@app.get("/users/me", response_model=UserResponse)
async def read_current_user(
    current_user: Annotated[User, Depends(get_current_user)]
) -> UserResponse:
    """Get current authenticated user."""
    return current_user
```

**Step 4: Add Database Integration with SQLAlchemy**

```python
# app/database.py
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import DeclarativeBase

SQLALCHEMY_DATABASE_URL = "postgresql+asyncpg://user:pass@localhost/dbname"

engine = create_async_engine(SQLALCHEMY_DATABASE_URL, echo=True)
async_session_maker = async_sessionmaker(engine, expire_on_commit=False)

class Base(DeclarativeBase):
    pass

async def get_db():
    async with as

