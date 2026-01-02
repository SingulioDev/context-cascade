# Debugging Skill (Delivery)

## What this skill does
Structured triage, isolation, and fix validation for defects. It follows the skill-forge structure-first rule (examples/tests/resources/references) and prompt-architect’s constraint + confidence ceiling discipline.

## When to use it
- Bug reports, failing tests, production incidents, performance regressions, unexplained logs.
- Not for net-new features (use `feature-dev-complete`) or prompt wording (use `prompt-architect`).

## How it works
1. **Triage & Reproduce** – capture signals, build minimal failing case, log HARD/SOFT/INFERRED constraints.
2. **Isolate** – hypothesis-driven narrowing (binary search, diffing, tracing) with ceilinged confidence for root-cause claims.
3. **Fix & Validate** – implement smallest safe change, add/adjust tests in `tests/`, verify with unit/integration/perf checks, keep rollback ready.
4. **Document** – summarize root cause, fix, evidence, and residual risk; store artifacts in `resources/` and citations in `references/`; add reusable notes to `examples/`.

## Output format
- Intent + constraints (HARD/SOFT/INFERRED) with confirmations.
- Repro notes, suspected causes, and **Confidence: X.XX (ceiling: TYPE Y.YY)**.
- Fix plan, validation and rollback steps, evidence links.

## Validation checklist
- Repro confirmed; scope + environment recorded.
- Tests updated and passing; rollback defined.
- Artifacts and references stored; confidence ceilings attached.

Confidence: 0.70 (ceiling: inference 0.70) – mirrors skill-forge guardrails and prompt-architect clarity/ceiling rules.
