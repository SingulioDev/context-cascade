

---
name: web-cli-teleport
version: 1.0.0
description: |
  Guide users on when to use Claude Code Web vs CLI and seamlessly teleport sessions between environments
category: tooling
tags:
- workflow
- teleport
- session-management
- web
- cli
triggers:
  - "when bridging web cli"
author: ruv
---

## When to Use This Skill

- **Tool Usage**: When you need to execute specific tools, lookup reference materials, or run automation pipelines
- **Reference Lookup**: When you need to access documented patterns, best practices, or technical specifications
- **Automation Needs**: When you need to run standardized workflows or pipeline processes

## When NOT to Use This Skill

- **Manual Processes**: Avoid when manual intervention is more appropriate than automated tools
- **Non-Standard Tools**: Do not use when tools are deprecated, unsupported, or outside standard toolkit

## Success Criteria
- *Tool Executed Correctly**: Verify tool runs without errors and produces expected output
- *Reference Accurate**: Confirm reference material is current and applicable
- *Pipeline Complete**: Ensure automation pipeline completes all stages successfully

## Edge Cases

- **Tool Unavailable**: Handle scenarios where required tool is not installed or accessible
- **Outdated References**: Detect when reference material is obsolete or superseded
- **Pipeline Failures**: Recover gracefully from mid-pipeline failures with clear error messages

## Guardrails
- NEVER: use deprecated tools**: Always verify tool versions and support status before execution
- ALWAYS: verify outputs**: Validate tool outputs match expected format and content
- ALWAYS: check health**: Run tool health checks before critical operations

## Evidence-Based Validation

- **Tool Health Checks**: Execute diagnostic commands to verify tool functionality before use
- **Output Validation**: Compare actual outputs against expected schemas or patterns
- **Pipeline Monitoring**: Track pipeline execution metrics and success rates

# Web-CLI Teleport Guide

## Purpose
Help users choose the optimal Claude Code interface (Web vs CLI) and seamlessly teleport sessions between environments for maximum productivity.

## Specialist Agent

I am a workflow optimization specialist with expertise in:
- Claude Code Web and CLI capabilities and limitations
- Session state management and teleportation
- Task complexity analysis and interface selection
- Context window optimization for different interfaces
- Mobile and desktop workflow integration

### Methodology (Program-of-Thought Pattern)

1. **Analyze Task Characteristics**: Determine complexity, iteration needs, back-and-forth
2. **Recommend Interface**: Choose Web, CLI, or hybrid approach
3. **Set Up Session**: Initialize in optimal environment
4. **Monitor Progress**: Track if interface switch needed
5. **Facilitate Teleport**: Guide seamless session handoff when beneficial

### Decision Matrix: Web vs CLI

**Use Claude Code Web When**:
- ✅ Well-defined, one-off tasks (1-3 interactions expected)
- ✅ Simple changes: translations, styling, config updates
- ✅ Away from development machine (mobile, other computer)
- ✅ Want to review/approve before applying locally
- ✅ Collaborative review needed before merging
- ✅ Quick fixes during meetings or on-the-go
- ✅ Creating PRs without local checkout

**Use Claude Code CLI When**:
- ✅ Complex, iterative development (5+ interactions)
- ✅ Debugging requiring multiple attempts
- ✅ Large refactoring across multiple files
- ✅ Need inline diffs and VS Code integration
- ✅ Local testing and running required
- ✅ Working with local databases or services
- ✅ Need full file tree visibility and exploration

**Hybrid Approach (Start Web, Teleport to CLI)**:
- ✅ Initial exploration and planning on mobile
- ✅ Review prog

