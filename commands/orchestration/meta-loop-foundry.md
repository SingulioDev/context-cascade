---
name: meta-loop-foundry
description: Start a recursive self-improvement meta loop cycle targeting foundry skills. Coordinates agent-creator, skill-forge, and prompt-forge with Ralph Wiggum persistence loops for bounded self-improvement.
user_invocable: true
---

# /meta-loop-foundry

## Kompositioneller Rahmen (Compositional Frame Activation)
Strukturaufbaumodus aktiv.



Start a recursive improvement cycle on foundry skills using Ralph Wiggum persistence.

## Usage

```bash
/meta-loop-foundry "<task>" --target "<file_path>" --foundry "<skill>"
```

## Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `<task>` | Yes | The improvement task to execute |
| `--target` | Yes | File path to improve |
| `--foundry` | Yes | Foundry skill to use: `agent-creator`, `skill-forge`, or `prompt-forge` |
| `--max-iterations` | No | Max iterations per phase (default: 30) |
| `--skip-monitor` | No | Skip 7-day monitoring phase |

## Examples

### Improve a Skill

```bash
/meta-loop-foundry "Add cognitive frame integration to Phase 1" \
  --target "skills/foundry/skill-forge/SKILL.md" \
  --foundry "prompt-forge"
```

### Enhance an Agent

```bash
/meta-loop-foundry "Add expertise loading to agent creation flow" \
  --target "agents/foundry/agent-creator.md" \
  --foundry "prompt-forge"
```

### Create New Agent via Meta Loop

```bash
/meta-loop-foundry "Create specialized code-reviewer agent" \
  --target "agents/quality/code-reviewer.md" \
  --foundry "agent-creator"
```

### Improve Prompt Forge Itself

```bash
/meta-loop-foundry "Add uncertainty handling to Operation 3" \
  --target "skills/foundry/prompt-forge/SKILL.md" \
  --foundry "skill-forge"  # Skill-forge improves prompt-forge
```

## Execution Flow

```
1. PREPARE
   - Parse task and target
   - Load domain expertise
   - Select foundry skill
   - Initialize state file

2. EXECUTE (Ralph Loop #1)
   - Run foundry skill phases
   - Generate improvement proposal
   - <promise>{FOUNDRY}_PROPOSAL_READY</promise>

3. IMPLEMENT (Ralph Loop #2)
   - Apply changes to target
   - Validate edits
   - <promise>CHANGES_APPLIED</promise>

4. AUDIT (Parallel Ralph Loops #3-6)
   - prompt-auditor
   - skill-auditor
   - expertise-auditor
   - output-auditor

5. EVAL (Ralph Loop #7)
   - Run eval harness
   - Fix failures
   - <promise>EVAL_HARNESS_PASS</promise>

6. COMPARE
   - Baseline vs candidate metrics
   - ACCEPT / REJECT / ESCALATE

7. COMMIT (if ACCEPT)
   - Git commit with attribution

8. MONITOR (Ralph Loop #8)
   - 7-day regression watch
   - <promise>MONITOR_COMPLETE</promise>
```

## Related Commands

| Command | Description |
|---------|-------------|
| `/meta-loop-status` | Check current meta loop status |
| `/meta-loop-cancel` | Cancel active meta loop |
| `/meta-loop-rollback <id>` | Rollback completed session |
| `/ralph-loop` | Start a simple Ralph persistence loop |
| `/cancel-ralph` | Cancel active Ralph loop |

## State Files

- Meta loop state: `~/.claude/ralph-wiggum/meta-loop-state.yaml`
- Ralph loop state: `~/.claude/ralph-wiggum/loop-state.md`
- Session history: `~/.claude/ralph-wiggum/foundry-sessions/`

## Safety Constraints

- Eval harness is FROZEN (cannot be modified)
- Changes > 500 lines require human approval
- All 4 auditors must pass
- 7-day monitoring with auto-rollback

## Triggers

This command is invoked when user mentions:
- "recursive improvement"
- "meta loop"
- "improve foundry"
- "self-improvement cycle"
- "run meta loop"

## Implementation

When this command is invoked:

1. Invoke `Skill("meta-loop-orchestrator")`
2. Parse parameters from user input
3. Initialize meta loop state
4. Begin PREPARE phase
5. Execute nested Ralph loops for each phase
6. Track progress via TodoWrite
7. Report final verdict

```javascript
// Execution pattern
Skill("meta-loop-orchestrator")

// Then spawn agents in parallel for auditing
[Single Message]:
  Task("Prompt Auditor", "Audit instructions in {target}...", "prompt-auditor")
  Task("Skill Auditor", "Audit skill structure in {target}...", "skill-auditor")
  Task("Expertise Auditor", "Verify expertise accuracy...", "expertise-auditor")
  Task("Output Auditor", "Validate output quality...", "output-auditor")
  TodoWrite({ todos: [
    {content: "PREPARE phase", status: "complete"},
    {content: "EXECUTE Ralph loop", status: "complete"},
    {content: "IMPLEMENT Ralph loop", status: "in_progress"},
    {content: "AUDIT (4 parallel)", status: "pending"},
    {content: "EVAL Ralph loop", status: "pending"},
    {content: "COMPARE metrics", status: "pending"},
    {content: "COMMIT if accepted", status: "pending"},
    {content: "MONITOR 7 days", status: "pending"}
  ]})
```
