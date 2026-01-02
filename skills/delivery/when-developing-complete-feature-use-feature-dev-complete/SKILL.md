---
name: when-developing-complete-feature-use-feature-dev-complete
description: Routing SOP for full-feature asks that should invoke the feature-dev-complete skill.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, TodoWrite
model: sonnet
x-version: 3.2.0
x-category: delivery
x-vcl-compliance: v3.1.1
x-cognitive-frames: [HON, MOR, COM, CLS, EVD, ASP, SPC]
---

## STANDARD OPERATING PROCEDURE

### Purpose
Detect and route end-to-end feature requests to `feature-dev-complete` while preserving constraints, structure-first assets, and confidence ceilings.

### Trigger Conditions
- **Positive:** net-new features, multi-story implementations, or requests covering design-build-test-release.
- **Negative:** isolated bugs (`debugging`/`smart-bug-fix`), doc-only (`documentation`), or prompt design.

### Guardrails
- **Structure-first:** ensure `examples/`, `tests/`, `resources/`, `references/` exist in this routing skill and downstream skill.
- **Constraint extraction:** HARD (scope, deadlines, SLAs), SOFT (tech preferences), INFERRED (risk appetite) — confirm inferred before routing.
- **Confidence ceilings:** `{inference/report:0.70, research:0.85, observation/definition:0.95}` for routing decisions and readiness assessments.
- **Traceability:** keep mapping between user intent and `feature-dev-complete` artifacts.

### Execution Phases
1. **Intent & Fit Check**
   - Parse request; list HARD/SOFT/INFERRED constraints; verify it requires end-to-end feature delivery.
2. **Prep Hand-off**
   - Gather repo context, acceptance criteria, and dependencies; store in `resources/`.
   - Create initial outline or task breakdown; keep examples in `examples/`.
3. **Invoke Feature Dev Complete**
   - Apply `skills/delivery/feature-dev-complete` SOP; ensure tests/docs/rollback paths are planned.
   - Capture validations in `tests/`; cite sources in `references/`.
4. **Closeout**
   - Summarize routing decision, artifacts produced, risks, and **Confidence: X.XX (ceiling: TYPE Y.YY)**.
   - Record follow-ups for ongoing iterations.

### Output Format
- Routing decision + constraints (HARD/SOFT/INFERRED) with confirmation status.
- Hand-off package contents and validation progress.
- Evidence links and confidence statement with ceiling.

### Validation Checklist
- [ ] Intent aligns with full feature delivery; misroutes avoided.
- [ ] Constraints confirmed; hand-off context prepared.
- [ ] Downstream SOP followed; tests/docs accounted for.
- [ ] Artifacts stored (`resources/`, `references/`, `examples/`); confidence ceiling stated.

### MCP / Memory Tags
- Namespace: `skills/delivery/when-developing-complete-feature-use-feature-dev-complete/{project}/{feature}`
- Tags: `WHO=feature-routing-{session}`, `WHY=skill-execution`, `WHAT=feature-delivery-routing`

Confidence: 0.70 (ceiling: inference 0.70) - Routing honors skill-forge structure-first and prompt-architect ceiling/constraint rules.

---

## VCL COMPLIANCE APPENDIX
- [[HON:teineigo]] [[MOR:root:R-O-U]] [[COM:Routing+Feature]] [[CLS:ge_skill]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:path:/skills/delivery/when-developing-complete-feature-use-feature-dev-complete]]
  - Structure-first directories enforced.
- [[HON:teineigo]] [[MOR:root:C-N-S]] [[COM:Constraint+Extraction]] [[CLS:ge_principle]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:axis:analysis]]
  - HARD/SOFT/INFERRED constraints confirmed before routing.
- [[HON:teineigo]] [[MOR:root:E-P-S]] [[COM:Epistemic+Ceiling]] [[CLS:ge_rule]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:coord:EVD-CONF]]
  - Confidence ceilings attached to routing outputs.
