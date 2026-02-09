

---
name: SKILL
version: 1.0.0
description: |
  Get real-time web information using Gemini's built-in Google Search grounding
category: platforms
tags:
- gemini
- web-search
- real-time
- documentation
- current-info
author: system
---

# Gemini Search Skill

## Purpose
Leverage Gemini CLI's built-in Google Search grounding to fetch real-time web information, validate current best practices, and access the latest documentation - capabilities Claude Code doesn't have natively.

## Unique Capability
**What Claude Code Can't Do**: Claude Code's knowledge has a cutoff date and cannot access real-time web information during analysis. Gemini CLI has built-in Google Search integration that grounds responses in current web content with citations.

## When to Use

### Perfect For:
✅ Checking latest API documentation
✅ Finding current library versions and changelogs
✅ Validating best practices against current standards
✅ Researching breaking changes in dependencies
✅ Comparing current technology options
✅ Finding solutions to recent issues
✅ Checking security advisories and CVEs
✅ Verifying current framework conventions

### Don't Use When:
❌ Information is in your local codebase (use Claude Code)
❌ Need deep implementation logic (use Claude Code)
❌ Question doesn't require current web information
❌ Working with proprietary/internal systems

## How It Works

This skill spawns a **Gemini Search Agent** that:
1. Uses Gemini CLI's `@search` tool or built-in Google Search grounding
2. Fetches current web content with citations
3. Grounds analysis in real-time information
4. Returns findings with source URLs to Claude Code

## Usage

### Basic Search
```
/gemini-search
```

### With Specific Query
```
/gemini-search "What are the breaking changes in React 19?"
```

### Detailed Research
```
/gemini-search "Compare authentication approaches for Next.js 15 apps with latest security best practices"
```

## Input Examples

```bash
# API Documentation
/gemini-search "Latest Stripe API authentication methods 2025"

# Breaking Changes
/gemini-search "What changed in Python 3.13 that would break my code?"

# Best Practices
/gemini-search "Current best practices for securing Node.js REST APIs"

# Version Information
/gemini-search "Is TensorFlow 2.16 stable? What are known issues?"

# Framework Conventions
/gemini-search "How should I structure a Next.js 15 app directory?"

# Security Research
/gemini-search "Recent vulnerabilities in Express.js and mitigation strategies"

# Technology Comparison
/gemini-search "Compare Prisma vs Drizzle ORM for TypeScript projects 2025"
```

## Output

The agent provides:
- **Direct Answer**: Response to your query
- **Source Citations**: URLs where information was found
- **Current Status**: What's latest/stable/recommended
- **Key Findings**: Bullet points of important info
- **Recommendations**: Based on current web consensus
- **Related Resources**: Links to docs, guides, discussions

## Real-World Examples

### Example 1: API Changes
```
Query: "What changed in OpenAI API v2?"

Agent searches and returns:
- New endpoint structure with examples
- Deprecated methods and replacements
- Migration guide links
- Breaking changes to watch for
- Source: Official OpenAI docs + dev discussions
```

### Example 2: Security Advisory
```
Query: "Are there security issues with lodash 4.17.20?"

Agent searches and returns:
- CVE-2020-8203 prototype pollution vulnerability
- Affected versions: < 4.17.21
- Severity: High
- Fix: Upgrade to 4.17.21 or higher
- Sources: npm advisory, Snyk, GitHub issues
```

### Example 3: Framework Best Practices
```
Query: "How should I handle authentication in Next.js 15?"

Agent searches and returns:
- Recommended approaches (NextAuth.js, Clerk, Auth.js)
- App router vs pages router differences
- Server components considerations
- Code examples from official docs
- Sources: Next.js docs, Vercel guides, community tutorials
```

## Technical Details

### Gemini CLI Command Pattern
```bash
# Using @search tool
gemini "@search What are the latest Rust 2024 features?"

# Natural prompt with automatic search
gemini "Search for current best practices i

