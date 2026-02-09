

---
name: typescript-specialist
version: 1.0.0
description: |
  Modern TypeScript development specialist for Node.js backends, Express/Nest.js frameworks, type-safe frontend development, npm package creation, and monorepo management with Turborepo/nx. Use when bui
category: Language Specialists
tags:
- general
author: system
---

# TypeScript Specialist

Expert TypeScript development for type-safe, scalable backend and full-stack applications with modern tooling.

## Purpose

This skill provides comprehensive TypeScript expertise including advanced type systems, modern Node.js patterns, framework integration (Express, Nest.js), and production-grade TypeScript configuration. It ensures TypeScript code leverages the full power of static typing while maintaining developer productivity.

## When to Use This Skill

Activate this skill when:
- Building backend APIs with Express or Nest.js
- Creating type-safe frontend applications
- Developing npm packages or libraries
- Setting up monorepos with Turborepo or nx
- Migrating JavaScript projects to TypeScript
- Configuring strict TypeScript compiler options
- Implementing advanced TypeScript patterns (generics, mapped types, conditional types)
- Optimizing TypeScript build performance

## Prerequisites

**Required Knowledge**:
- JavaScript ES6+ syntax and concepts
- Node.js runtime and npm/yarn/pnpm
- Basic understanding of static typing

**Required Tools**:
- Node.js 18+ installed
- npm, yarn, or pnpm package manager
- Code editor with TypeScript support (VS Code recommended)

**Agent Assignments**:
- `backend-dev`: Primary TypeScript API implementation
- `coder`: General TypeScript development
- `base-template-generator`: Project scaffolding
- `tester`: Jest/Vitest test suite creation
- `code-analyzer`: Type safety and quality analysis

## Core Workflows

### Workflow 1: Nest.js Backend API Development

**Step 1: Initialize Nest.js Project**

Create a production-ready Nest.js project with TypeScript:

```bash
# Install Nest CLI globally
npm install -g @nestjs/cli

# Create new project
nest new my-api --package-manager pnpm

# Navigate to project
cd my-api

# Install additional dependencies
pnpm add @nestjs/config @nestjs/typeorm typeorm pg class-validator class-transformer
pnpm add -D @types/node
```

**Step 2: Configure TypeScript Strict Mode**

```json
// tsconfig.json
{
  "compilerOptions": {
    "module": "commonjs",
    "declaration": true,
    "removeComments": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "allowSyntheticDefaultImports": true,
    "target": "ES2021",
    "sourceMap": true,
    "outDir": "./dist",
    "baseUrl": "./",
    "incremental": true,
    "skipLibCheck": true,
    "strict": true,
    "strictNullChecks": true,
    "noImplicitAny": true,
    "strictBindCallApply": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "esModuleInterop": true,
    "resolveJsonModule": true
  }
}
```

**Step 3: Create Type-Safe DTOs with Class Validator**

```typescript
// src/users/dto/create-user.dto.ts
import { IsEmail, IsString, MinLength, MaxLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateUserDto {
  @ApiProperty({ description: 'User email address' })
  @IsEmail()
  email: string;

  @ApiProperty({ description: 'Username', minLength: 3, maxLength: 50 })
  @IsString()
  @MinLength(3)
  @MaxLength(50)
  username: string;

  @ApiProperty({ description: 'User password', minLength: 8 })
  @IsString()
  @MinLength(8)
  password: string;
}
```

**Step 4: Implement Service with Dependency Injection**

```typescript
// src/users/users.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
import { CreateUserDto } from './dto/create-user.dto';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly usersRepository: Repository<User>,
  ) {}

  async create(createUserDto: CreateUserDto): Promise<User> {
    const user = this.usersRepository.create(createUserDto);
    return await this.usersReposi

