

---
name: language-specialists
version: 1.0.0
description: |
  Unified language specialists for Python and TypeScript development, providing expert guidance for modern backend APIs, type-safe development, async optimization, and framework integration (Django/Flas
category: Specialized Development
tags:
- specialists
- domain-expert
author: ruv
---

# Language Specialists - Gold Tier

## When to Use This Skill

- **Language-Specific Features**: Leveraging unique language capabilities
- **Idiomatic Code**: Writing language-specific best practices
- **Performance Optimization**: Using language-specific optimization techniques
- **Type System**: Advanced TypeScript, Rust, or type system features
- **Concurrency**: Language-specific async/parallel programming patterns
- **Ecosystem Tools**: Language-specific linters, formatters, build tools

## When NOT to Use This Skill

- **Cross-Language Work**: Polyglot projects requiring multiple languages
- **Framework-Specific**: React, Django, Rails (use framework specialist instead)
- **Algorithm Design**: Language-agnostic algorithmic work
- **Generic Patterns**: Design patterns applicable across languages

## Success Criteria

- [ ] Code follows language-specific style guide (PEP 8, Effective Go, etc.)
- [ ] Language-specific linter passing (eslint, pylint, clippy)
- [ ] Idiomatic patterns used (decorators, context managers, traits)
- [ ] Type safety enforced (TypeScript strict mode, mypy, etc.)
- [ ] Language-specific tests passing (pytest, jest, cargo test)
- [ ] Performance benchmarks met
- [ ] Documentation follows language conventions (JSDoc, docstrings, rustdoc)

## Edge Cases to Handle

- **Version Differences**: Language version compatibility (Python 2 vs 3, ES5 vs ES6)
- **Platform Differences**: OS-specific behavior (Windows vs Linux paths)
- **Encoding Issues**: Unicode, character sets, binary data
- **Dependency Hell**: Version conflicts or missing dependencies
- **Memory Management**: GC tuning, manual memory management (Rust, C++)
- **Concurrency Models**: GIL limitations, async runtime differences

## Guardrails

- **NEVER** ignore language-specific warnings or deprecations
- **ALWAYS** use language version managers (nvm, pyenv, rustup)
- **NEVER** reinvent standard library functionality
- **ALWAYS** follow language security best practices
- **NEVER** disable type checking to make code compile
- **ALWAYS** use language-native package managers
- **NEVER** commit language-specific artifacts (node_modules, __pycache__)

## Evidence-Based Validation

- [ ] Language-specific linter passes with zero warnings
- [ ] Type checker passes (tsc --strict, mypy --strict)
- [ ] Tests pass on target language version
- [ ] Benchmarks show performance within acceptable range
- [ ] Code review by language expert
- [ ] Security scanner passes (npm audit, safety, cargo audit)
- [ ] Documentation generated successfully

Expert multi-language development suite for Python and TypeScript backend systems with comprehensive tooling, testing, and examples.

## Purpose

This Gold tier skill provides unified access to Python and TypeScript specialists with production-ready resources, automated linting/validation scripts, configuration templates, comprehensive test suites, and real-world examples for multi-language repository development.

## When to Use This Skill

Activate this skill when:
- Building multi-language backend services (Python + TypeScript)
- Setting up monorepo with Python and Node.js components
- Migrating between Python and TypeScript
- Requiring language-specific best practices and tooling
- Setting up CI/CD for polyglot projects
- Implementing type-safe APIs across languages

## Nested Specialist Skills

This parent skill orchestrates two specialized sub-skills:

1. **Python Specialist** (`python-specialist/`)
   - FastAPI, Django, Flask backend development
   - Async/await optimization with asyncio
   - Type hints and mypy validation
   - Performance profiling with cProfile
   - pytest testing and coverage

2. **TypeScript Specialist** (`typescript-specialist/`)
   - Nest.js and Express API development
   - Advanced TypeScript types (generics, mapped types, conditional types)
   - npm package creation and monorepo management
   - Jest/Vitest tes

