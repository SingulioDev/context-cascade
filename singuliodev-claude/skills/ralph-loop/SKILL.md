

---
name: ralph-loop
version: 1.0.0
description: |
  Persistence loop system that prevents premature task completion by using Stop hooks to re-inject prompts until success criteria are met. Named after Ralph Wiggum from The Simpsons. Use for iterative t
category: orchestration
tags:
- orchestration
- persistence
- iteration
- automation
- tdd
author: Context Cascade (integrated from Anthropic's Ralph Wiggum plugin)
---

# Ralph Loop (Persistence Loop System)

An orchestration skill that implements continuous self-referential AI loops for iterative development until task completion.

## SKILL-SPECIFIC GUIDANCE

### When to Use This Skill

- Tasks with clear, binary success criteria (tests pass/fail)
- Iterative refinement tasks (TDD, test coverage, linting)
- Greenfield development where you can "walk away"
- Tasks requiring multiple attempts to get right
- Automated verification is possible (tests, linters, compilers)

### When NOT to Use This Skill

- Tasks requiring human judgment or design decisions
- One-shot operations with no iteration needed
- Tasks with unclear or subjective success criteria
- Production debugging (need human oversight)
- When max iterations would be reached quickly

### Success Criteria
- Task completes with completion promise output
- All automated checks pass (tests, linters)
- Work persists in files after loop ends
- Iteration count within max-iterations limit

### Edge Cases & Limitations

- Exact string matching only for completion promise
- Cannot handle subjective "quality" assessments
- May get stuck if task is truly impossible
- Windows requires bash/git-bash environment

### Critical Guardrails

- ALWAYS set --max-iterations (never run unlimited)
- ALWAYS define clear completion criteria
- NEVER use for tasks requiring human approval
- ALWAYS have escape hatch in prompt ("if blocked, document why")

## Core Concept

Ralph Loop creates a self-referential feedback loop:

```
1. User runs /ralph-loop once with task
2. Claude works on task
3. Claude tries to exit
4. Stop hook intercepts exit
5. If completion promise NOT found:
   - Increment iteration
   - Re-inject same prompt
   - Loop continues
6. If completion promise found OR max iterations:
   - Allow exit
   - Report results
```

## How It Works Under the Hood

### State File
Location: `~/.claude/ralph-wiggum/loop-state.md`

```yaml
---
session_id: 20251228-143022-12345
iteration: 3
max_iterations: 50
completion_promise: "COMPLETE"
started_at: 2025-12-28T14:30:22
active: true
---

[Original prompt here]
```

### Stop Hook Mechanism

The Stop hook (`ralph-loop-stop-hook.sh`):
1. Checks if loop is active
2. Validates iteration < max_iterations
4. If not complete: exits with code 2 (blocks exit)
5. Re-injects original prompt with iteration info

## Integration with Three-Loop System

Ralph Loop complements the Three-Loop system:

| Loop | Purpose | Ralph Integration |
|------|---------|-------------------|
| Loop 1: Planning | Research-driven planning | N/A (planning phase) |
| Loop 2: Implementation | Parallel swarm execution | Ralph handles single-agent iteration |
| Loop 3: CI/CD | Intelligent recovery | Ralph can drive fix-until-pass loops |

### Recommended Pattern

```
Phase 1-4: Use 5-phase workflow for planning
Phase 5: Use /ralph-loop for persistent execution
```

## Commands

### /ralph-loop

Start a persistence loop.

```bash
/ralph-loop "<prompt>" --max-iterations N --completion-promise "<text>"
```

### /cancel-ralph

Cancel active loop.

```bash
/cancel-ralph
```

## Prompt Templates

### TDD Loop

```
Implement [FEATURE] using TDD:

1. Write failing tests first
2. Implement minimum code to pass
3. Run tests
4. If any fail, debug and fix
5. Refactor if needed
6. Repeat until all green

```

### Coverage Loop

```
Write tests for [MODULE] until coverage reaches [TARGET]%.

After each test:
1. Run coverage report
2. Identify uncovered lines
3. Wr

