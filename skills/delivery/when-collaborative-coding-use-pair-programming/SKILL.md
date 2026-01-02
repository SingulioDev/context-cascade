---
name: when-collaborative-coding-use-pair-programming
description: Routing and execution SOP for collaborative coding requests using the pair-programming skill.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, TodoWrite
model: sonnet
x-version: 3.2.0
x-category: delivery
x-vcl-compliance: v3.1.1
x-cognitive-frames: [HON, MOR, COM, CLS, EVD, ASP, SPC]
---

## STANDARD OPERATING PROCEDURE

### Purpose
Detect collaborative coding intents and execute the pair-programming workflow with the same constraint and confidence discipline as prompt-architect and skill-forge.

### Trigger Conditions
- **Positive:** collaborative coding, paired debugging, live code review, mentoring/onboarding, TDD pairing.
- **Negative:** solo bug triage (use `debugging`), complex fixes (use `smart-bug-fix`), or feature delivery (use `feature-dev-complete`).

### Guardrails
- **Structure-first:** ensure `examples/`, `tests/`, `resources/`, `references/` exist in this routing skill and in downstream `pair-programming`.
- **Constraint extraction:** HARD (timebox, repo restrictions, CI requirements), SOFT (tooling prefs), INFERRED (communication cadence) — confirm inferred.
- **Confidence ceilings:** `{inference/report:0.70, research:0.85, observation/definition:0.95}` for routing decisions and pairing guidance.
- **Role hygiene:** require driver/navigator rotation and summary checkpoints.

### Execution Phases
1. **Intent Check**
   - Parse request; list constraints HARD/SOFT/INFERRED; confirm suitability for pairing.
2. **Preparation**
   - Set session goal and done definition; choose mode (driver/navigator/switch/TDD); log constraints.
   - Update `resources/` with context links; add baseline example to `examples/` if new scenario.
3. **Invoke Pair Programming**
   - Apply `skills/delivery/pair-programming` SOP; record decisions, tests, and artifacts.
   - Capture validation outputs in `tests/` and evidence in `references/`.
4. **Closeout**
   - Deliver summary, risks, and next steps; provide **Confidence: X.XX (ceiling: TYPE Y.YY)**.
   - Store reusable snippets/notes for future routing in `examples/`.

### Output Format
- Routing decision + constraints (HARD/SOFT/INFERRED) with confirmations.
- Selected pairing mode, goals, and validation status.
- Evidence links and confidence statement with ceiling.

### Validation Checklist
- [ ] Intent matches collaborative coding; misroutes avoided.
- [ ] Constraints captured and confirmed; role cadence defined.
- [ ] Pair-programming SOP followed; tests/linters run and logged.
- [ ] Artifacts stored (`resources/`, `references/`, `examples/`); confidence ceilings stated.

### MCP / Memory Tags
- Namespace: `skills/delivery/when-collaborative-coding-use-pair-programming/{project}/{session}`
- Tags: `WHO=pair-programming-router-{session}`, `WHY=skill-execution`, `WHAT=collab-routing`

Confidence: 0.70 (ceiling: inference 0.70) - Routing mirrors skill-forge structure-first and prompt-architect ceiling/constraint requirements.

---

## VCL COMPLIANCE APPENDIX
- [[HON:teineigo]] [[MOR:root:R-O-U]] [[COM:Routing+Pairing]] [[CLS:ge_skill]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:path:/skills/delivery/when-collaborative-coding-use-pair-programming]]
  - Structure-first directories enforced for routing artifacts.
- [[HON:teineigo]] [[MOR:root:C-N-S]] [[COM:Constraint+Extraction]] [[CLS:ge_principle]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:axis:analysis]]
  - HARD/SOFT/INFERRED constraints confirmed before invoking downstream skill.
- [[HON:teineigo]] [[MOR:root:E-P-S]] [[COM:Epistemic+Ceiling]] [[CLS:ge_rule]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:coord:EVD-CONF]]
  - Confidence ceilings attached to routing and execution summaries.
