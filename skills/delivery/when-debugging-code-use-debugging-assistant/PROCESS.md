# Process Notes – Debugging Assistant Router

This router applies prompt-architect constraint/clarity rules and skill-forge structure-first discipline before invoking `skills/delivery/debugging`.

## Flow
1. **Intent triage** – classify request as debugging; otherwise reroute (feature-dev-complete, smart-bug-fix, i18n-automation, etc.).
2. **Constraint ledger** – capture HARD/SOFT/INFERRED constraints; confirm inferred; record in `resources/`.
3. **Evidence pack** – gather repro steps, failing tests, logs/traces; store artifacts in `resources/`; add reusable snippets to `examples/`.
4. **Execution** – run the `debugging` SOP; ensure tests/linters executed; note any commands not run; keep outputs in `tests/` and citations in `references/`.
5. **Closeout** – summarize findings, risks, next steps, and **Confidence: X.XX (ceiling: TYPE Y.YY)**.

## Quality gates
- Routing correct; constraints confirmed.
- Repro established; validation results captured.
- Artifacts stored; confidence ceilings applied.

Confidence: 0.70 (ceiling: inference 0.70).
