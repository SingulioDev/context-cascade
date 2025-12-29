---
name: meta-loop-cancel
description: Cancel an active meta loop cycle.
user_invocable: true
---

# /meta-loop-cancel

## Kompositioneller Rahmen (Compositional Frame Activation)
Strukturaufbaumodus aktiv.



Cancel the currently active meta loop.

## Usage

```bash
/meta-loop-cancel [--force]
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `--force` | Skip cleanup and immediately terminate |

## Behavior

Normal cancel:
1. Complete current Ralph loop iteration
2. Save state for potential resume
3. Archive session to history
4. Clean up temp files

Force cancel:
1. Immediately terminate all loops
2. No state preservation
3. May leave partial changes

## Output

```
Cancelling meta loop session: meta-20251228-160000

Current state saved to: ~/.claude/ralph-wiggum/foundry-sessions/
Session archived for potential resume

Meta loop cancelled.
```

## Related Commands

- `/meta-loop-status` - Check current status
- `/meta-loop-foundry` - Start new meta loop


---
*Promise: `<promise>META_LOOP_CANCEL_VERIX_COMPLIANT</promise>`*
