---
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
skill: codex-auto
description: Use Codex CLI's Full Auto mode for unattended sandboxed prototyping and scaffolding
tags: [codex, openai, prototyping, automation, full-auto, scaffolding]
version: 1.0.0
---



## When to Use This Skill

- **Tool Usage**: When you need to execute specific tools, lookup reference materials, or run automation pipelines
- **Reference Lookup**: When you need to access documented patterns, best practices, or technical specifications
- **Automation Needs**: When you need to run standardized workflows or pipeline processes

## When NOT to Use This Skill

- **Manual Processes**: Avoid when manual intervention is more appropriate than automated tools
- **Non-Standard Tools**: Do not use when tools are deprecated, unsupported, or outside standard toolkit

## Success Criteria

- **Tool Executed Correctly**: Verify tool runs without errors and produces expected output
- **Reference Accurate**: Confirm reference material is current and applicable
- **Pipeline Complete**: Ensure automation pipeline completes all stages successfully

## Edge Cases

- **Tool Unavailable**: Handle scenarios where required tool is not installed or accessible
- **Outdated References**: Detect when reference material is obsolete or superseded
- **Pipeline Failures**: Recover gracefully from mid-pipeline failures with clear error messages

## Guardrails

- **NEVER use deprecated tools**: Always verify tool versions and support status before execution
- **ALWAYS verify outputs**: Validate tool outputs match expected format and content
- **ALWAYS check health**: Run tool health checks before critical operations

## Evidence-Based Validation

- **Tool Health Checks**: Execute diagnostic commands to verify tool functionality before use
- **Output Validation**: Compare actual outputs against expected schemas or patterns
- **Pipeline Monitoring**: Track pipeline execution metrics and success rates

# Codex Full Auto Skill

## Purpose
Leverage Codex CLI's Full Auto mode for unattended, sandboxed prototyping where the AI can autonomously read, write, and execute code without approval - perfect for rapid scaffolding and overnight builds.

## Unique Capability
**What Claude Code Can't Do**: Run completely autonomously without user approval for extended periods. Codex Full Auto mode can prototype entire features, fix broken builds, or scaffold projects while you're away - all in a secure sandbox.

## When to Use

### Perfect For:
✅ Rapid prototyping of new features
✅ Scaffolding entire projects (APIs, apps, tools)
✅ Fixing broken builds while you're away
✅ Automated refactoring tasks
✅ Generating boilerplate code
✅ "Set it and forget it" tasks
✅ Exploring implementation approaches

### Don't Use When:
❌ Need human oversight for critical decisions
❌ Working with production systems
❌ Requires network access (Full Auto disables network)
❌ Need to access resources outside project directory

## How It Works

Codex Full Auto mode:
- ✅ Reads/writes files automatically
- ✅ Executes commands in sandbox
- ✅ Iterates on its own output
- ⚠️ **Network disabled** for security
- ⚠️ **CWD only** - can't access outside project
- ⚠️ Uses macOS Seatbelt / Docker sandbox

## Usage

### Basic Auto Prototyping
```
/codex-auto "Create a REST API with user CRUD operations using Express and SQLite"
```

### Scaffolding
```
/codex-auto "Build a complete todo app with React frontend and Node.js backend, include tests"
```

### Overnight Task
```
/codex-auto "Refactor entire src/ directory to use TypeScript strict mode, fix all type errors"
```

## Safety

Full Auto runs in **secure sandbox**:
- Network: **DISABLED** (no external connections)
- Scope: **CWD only** (current working directory)
- Isolation: **Seatbelt (macOS) / Docker**
- Can't: Access parent dirs, make network calls, modify system

## Command Pattern
```bash
codex --full-auto "Detailed task description"
# Equivalent to: codex -a on-failure -s workspace-write
```

## Real Examples

### Example 1: API Scaffolding
```
/codex-auto "Create Express REST API with:
- User endpoints (CRUD)
- JWT authentication
- Input validation
- Error handling
- SQLite database
- Tests with Jest"

Result: Complete API in ~45 minutes
```

### Example 2: Refactoring
```
/codex-auto "Refactor all components in src/components to use hooks instead of class components, preserve all functionality"

Result: All components refactored, tests passing
```

---

**Note**: Use your ChatGPT Plus ($20/month) subscription. Recommended model: GPT-5-Codex for agentic tasks.

See `agents/codex-auto-agent.md` for full details.
