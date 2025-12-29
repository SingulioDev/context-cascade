---
name: meta-loop-rollback
description: Rollback changes from a completed meta loop session.
user_invocable: true
---

# /meta-loop-rollback

## Kompositioneller Rahmen (Compositional Frame Activation)
Strukturaufbaumodus aktiv.



Rollback changes made by a completed meta loop session.

## Usage

```bash
/meta-loop-rollback <session_id>
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `session_id` | The meta loop session ID to rollback |

## Examples

```bash
# Rollback specific session
/meta-loop-rollback meta-20251228-160000

# List available sessions for rollback
/meta-loop-rollback --list
```

## Output

```
META LOOP ROLLBACK
==================

Session: meta-20251228-160000
Completed: 2025-12-28T18:45:00
Commit: abc123f

Changes to rollback:
  - skills/foundry/skill-forge/SKILL.md (127 lines changed)

This will:
  1. Revert commit abc123f
  2. Archive session as rolled-back
  3. Log rollback reason

Proceed with rollback? [y/N] y

Rollback complete.
Files restored to pre-meta-loop state.
```

## Safety

- Requires confirmation before rollback
- Creates backup of current state
- Logs rollback for audit trail
- Does not affect other sessions

## Related Commands

- `/meta-loop-status` - Check current status
- `/meta-loop-foundry` - Start new meta loop


---
*Promise: `<promise>META_LOOP_ROLLBACK_VERIX_COMPLIANT</promise>`*
