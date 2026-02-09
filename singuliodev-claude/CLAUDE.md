# singuliodev-claude Plugin

Cognitive architecture plugin providing skills, agents, and multi-agent coordination for Claude Code.

## Quick Reference

| Component | Count | Location |
|-----------|-------|----------|
| Skills | ~175 | `skills/<name>/SKILL.md` |
| Agents | ~224 | `agents/<name>.md` |
| Commands | ~20 | `commands/<name>.md` |
| Hook scripts | ~16 | `hooks/scripts/*.sh` |

## 5-Phase Workflow

Every non-trivial request follows this pipeline:

1. **Intent Analysis** - Understand what the user needs
2. **Prompt Optimization** - Refine the request with context
3. **Strategic Planning** - Break into tasks with dependencies
4. **Routing** - Match tasks to appropriate skills/agents
5. **Execution** - Run tasks in parallel where possible

**Golden Rule:** 1 message = all parallel operations.

## Agent Invocation Pattern

Agents are conceptual personas embedded in Task prompts. Only these subagent_types are valid:

| subagent_type | Use For |
|---------------|---------|
| `general-purpose` | Multi-step tasks, research, coding (DEFAULT) |
| `Explore` | Fast codebase search |
| `Plan` | Architecture and planning |
| `Bash` | Shell command execution |

```
Task("Fix auth bug",
  "Acting as a bug-fixer agent: Analyze and fix the auth issue in auth.js",
  "general-purpose")
```

## Top Skills

| Skill | Purpose | Invoke |
|-------|---------|--------|
| `build-feature` | Feature development lifecycle | `/singuliodev-claude:build-feature` |
| `fix-bug` | Systematic debugging | `/singuliodev-claude:fix-bug` |
| `code` | Code implementation | `/singuliodev-claude:code` |
| `debug` | Troubleshooting | `/singuliodev-claude:debug` |
| `code-review` | Code quality review | `/singuliodev-claude:code-review` |
| `architect` | System design | `/singuliodev-claude:architect` |
| `sparc` | SPARC methodology | `/singuliodev-claude:sparc` |
| `deep-research` | Multi-pipeline research | `/singuliodev-claude:deep-research` |
| `swarm-init` | Multi-agent swarm | `/singuliodev-claude:swarm-init` |
| `deploy-check` | Deployment validation | `/singuliodev-claude:deploy-check` |
| `security-review` | Security analysis | `/singuliodev-claude:security-review` |
| `performance-analysis` | Performance optimization | `/singuliodev-claude:performance-analysis` |
| `reflect` | Session learning | `/singuliodev-claude:reflect` |
| `improve` | Code improvement | `/singuliodev-claude:improve` |
| `cascade-orchestrator` | Multi-skill pipelines | `/singuliodev-claude:cascade-orchestrator` |

## Key Rules

1. Batch parallel operations in a single message
2. All user-facing output in plain English
3. Use only registered agents (see `agents/` directory)
4. Track progress with task lists
5. Validate work before marking complete
