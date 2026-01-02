# Debugging Assistant Router

Use this skill to classify debugging requests and run the `debugging` SOP with structure-first assets and confidence ceilings.

## Use when
- Failing tests, runtime errors, unexpected output, perf regressions, flaky behavior, suspicious logs.
- Not for feature builds (`feature-dev-complete`) or complex incidents requiring `smart-bug-fix`.

## Workflow
1. **Intent & constraints** – list HARD/SOFT/INFERRED constraints (data safety, uptime, repro env, tooling); confirm inferred.
2. **Evidence pack** – collect repro steps, logs/traces, failing tests; store in `resources/`; add reusable snippets to `examples/`.
3. **Invoke debugging** – follow `skills/delivery/debugging` SOP; capture tests/validation outputs in `tests/`; cite sources in `references/`.
4. **Closeout** – summarize status, risks, next steps, and **Confidence: X.XX (ceiling: TYPE Y.YY)**.

## Quality gates
- Routing correct; constraints confirmed.
- Repro established; tests/linters run.
- Artifacts saved (resources/references/examples); confidence ceilings attached.

Confidence: 0.70 (ceiling: inference 0.70) – aligned with skill-forge structure-first and prompt-architect constraint/ceiling discipline.
