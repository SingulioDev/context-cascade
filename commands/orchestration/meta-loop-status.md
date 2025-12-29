---
name: meta-loop-status
description: Check the current status of an active meta loop cycle.
user_invocable: true
---

# /meta-loop-status

## Kompositioneller Rahmen (Compositional Frame Activation)
Strukturaufbaumodus aktiv.



Display the current status of an active meta loop.

## Usage

```bash
/meta-loop-status
```

## Output

```
META LOOP STATUS
================
Session: meta-20251228-160000
Active: true
Phase: IMPLEMENT (iteration 3/20)

Task: Add cognitive frame integration
Target: skills/foundry/skill-forge/SKILL.md
Foundry: prompt-forge

Nested Loops:
  [x] EXECUTE     (12 iterations) - COMPLETE
  [>] IMPLEMENT   (3/20 iterations) - ACTIVE
  [ ] AUDIT       (4 parallel) - PENDING
  [ ] EVAL        - PENDING

Auditor Status:
  prompt:    PENDING
  skill:     PENDING
  expertise: PENDING
  output:    PENDING

Metrics:
  Baseline: clarity=0.85, completeness=0.82
  Candidate: Not yet measured

Next: Complete IMPLEMENT, then AUDIT phase
```

## Related Commands

- `/meta-loop-foundry` - Start new meta loop
- `/meta-loop-cancel` - Cancel active loop
- `/meta-loop-rollback` - Rollback completed session


---
*Promise: `<promise>META_LOOP_STATUS_VERIX_COMPLIANT</promise>`*
