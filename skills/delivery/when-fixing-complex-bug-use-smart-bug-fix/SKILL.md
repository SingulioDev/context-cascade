---
name: when-fixing-complex-bug-use-smart-bug-fix
description: Routing SOP for complex or high-risk defects that should invoke the smart-bug-fix skill.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, TodoWrite
model: sonnet
x-version: 3.2.0
x-category: delivery
x-vcl-compliance: v3.1.1
x-cognitive-frames: [HON, MOR, COM, CLS, EVD, ASP, SPC]
---

## STANDARD OPERATING PROCEDURE

### Purpose
Identify complex defects and hand them to `smart-bug-fix` with preserved constraints, structure, and confidence ceilings.

### Trigger Conditions
- **Positive:** production incidents, multi-service issues, security/perf regressions, difficult-to-reproduce bugs, repeated failures.
- **Negative:** simple/localized bugs (`debugging`), feature delivery (`feature-dev-complete`), or doc-only asks.

### Guardrails
- **Structure-first:** keep `examples/`, `tests/`, `resources/`, `references/` ready for routing artifacts and downstream outputs.
- **Constraint extraction:** HARD (blast radius, uptime, data safety), SOFT (tooling), INFERRED (rollback tolerance) — confirm inferred before routing.
- **Confidence ceilings:** `{inference/report:0.70, research:0.85, observation/definition:0.95}` for routing and initial hypotheses.
- **Safety:** avoid production changes without validated rollback and evidence.

### Execution Phases
1. **Intake & Severity**
   - Gather symptoms, environment, and impact; classify severity; record constraints.
2. **Fit Assessment**
   - Determine complexity; if high-risk, proceed with `smart-bug-fix`; otherwise reroute.
3. **Hand-off Prep**
   - Assemble repro steps, logs/traces, and existing hypotheses; store in `resources/`.
   - Add any prior attempts or related incidents to `references/`; create scenario examples if needed.
4. **Invoke Smart Bug Fix**
   - Follow `skills/delivery/smart-bug-fix` SOP; ensure tests/regressions captured in `tests/`.
5. **Closeout**
   - Summarize decision, artifacts, risks, and **Confidence: X.XX (ceiling: TYPE Y.YY)**; outline next steps.

### Output Format
- Routing decision + constraints (HARD/SOFT/INFERRED) with confirmations.
- Evidence set (repro, logs, hypotheses) and validation status.
- Confidence statement with ceiling and follow-up plan.

### Validation Checklist
- [ ] Complexity/impact warrants `smart-bug-fix`; misroutes avoided.
- [ ] Constraints captured and confirmed.
- [ ] Repro + evidence packaged; tests/regressions noted.
- [ ] Artifacts stored; confidence ceilings applied.

### MCP / Memory Tags
- Namespace: `skills/delivery/when-fixing-complex-bug-use-smart-bug-fix/{project}/{incident}`
- Tags: `WHO=smart-bug-fix-routing-{session}`, `WHY=skill-execution`, `WHAT=complex-bug-routing`

Confidence: 0.70 (ceiling: inference 0.70) - Routing aligns with skill-forge structure-first and prompt-architect ceiling/constraint practices.

---

## VCL COMPLIANCE APPENDIX
- [[HON:teineigo]] [[MOR:root:R-O-U]] [[COM:Routing+BugFix]] [[CLS:ge_skill]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:path:/skills/delivery/when-fixing-complex-bug-use-smart-bug-fix]]
  - Structure-first directories enforced.
- [[HON:teineigo]] [[MOR:root:C-N-S]] [[COM:Constraint+Extraction]] [[CLS:ge_principle]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:axis:analysis]]
  - HARD/SOFT/INFERRED constraints confirmed before routing.
- [[HON:teineigo]] [[MOR:root:E-P-S]] [[COM:Epistemic+Ceiling]] [[CLS:ge_rule]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:coord:EVD-CONF]]
  - Confidence ceilings applied to routing and initial hypotheses.
