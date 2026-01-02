---
name: when-internationalizing-app-use-i18n-automation
description: Routing SOP for localization/internationalization work that should use the i18n-automation skill.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, TodoWrite
model: sonnet
x-version: 3.2.0
x-category: delivery
x-vcl-compliance: v3.1.1
x-cognitive-frames: [HON, MOR, COM, CLS, EVD, ASP, SPC]
---

## STANDARD OPERATING PROCEDURE

### Purpose
Detect localization needs and invoke `i18n-automation` while preserving constraints, structure, and ceilinged confidence.

### Trigger Conditions
- **Positive:** requests for multi-language support, locale setup, translation fixes, RTL enablement, pluralization bugs.
- **Negative:** general doc writing (`documentation`) or unrelated feature delivery (`feature-dev-complete`).

### Guardrails
- **Structure-first:** keep `examples/`, `tests/`, `resources/`, `references/` available for routing outputs and downstream artifacts.
- **Constraint extraction:** HARD (locales, compliance/PII rules), SOFT (tone, brand voice), INFERRED (fallback order) — confirm inferred.
- **Confidence ceilings:** `{inference/report:0.70, research:0.85, observation/definition:0.95}` for routing choices and initial guidance.
- **Safety:** avoid leaking secrets in translation payloads; protect placeholders.

### Execution Phases
1. **Intent & Fit**
   - Parse request; list constraints; confirm it is i18n/l10n work.
2. **Context Package**
   - Gather locale targets, frameworks, existing translation files; store in `resources/`.
   - Capture inferred needs (fallbacks, detection) and confirm; add examples if helpful.
3. **Invoke i18n Automation**
   - Apply `skills/delivery/i18n-automation` SOP; ensure translation validation steps planned.
   - Record tests/linting outcomes in `tests/`; citations in `references/`.
4. **Closeout**
   - Provide routing summary, validation status, risks, and **Confidence: X.XX (ceiling: TYPE Y.YY)**.
   - Note follow-ups for additional locales or audits.

### Output Format
- Routing decision + constraints (HARD/SOFT/INFERRED) with confirmations.
- Context package summary; validation/progress notes.
- Evidence links and confidence statement with ceiling.

### Validation Checklist
- [ ] Intent correctly classified as i18n/l10n; misroutes avoided.
- [ ] Constraints confirmed; locale targets documented.
- [ ] Downstream SOP followed; tests/validations captured.
- [ ] Artifacts stored (`resources/`, `references/`, `examples/`); confidence ceilings applied.

### MCP / Memory Tags
- Namespace: `skills/delivery/when-internationalizing-app-use-i18n-automation/{project}/{locale}`
- Tags: `WHO=i18n-routing-{session}`, `WHY=skill-execution`, `WHAT=i18n-routing`

Confidence: 0.70 (ceiling: inference 0.70) - Routing aligned with skill-forge structure-first and prompt-architect constraint/ceiling standards.

---

## VCL COMPLIANCE APPENDIX
- [[HON:teineigo]] [[MOR:root:R-O-U]] [[COM:Routing+I18n]] [[CLS:ge_skill]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:path:/skills/delivery/when-internationalizing-app-use-i18n-automation]]
  - Structure-first directories required.
- [[HON:teineigo]] [[MOR:root:C-N-S]] [[COM:Constraint+Extraction]] [[CLS:ge_principle]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:axis:analysis]]
  - HARD/SOFT/INFERRED constraints confirmed before routing.
- [[HON:teineigo]] [[MOR:root:E-P-S]] [[COM:Epistemic+Ceiling]] [[CLS:ge_rule]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:coord:EVD-CONF]]
  - Confidence ceilings enforced on routing summaries and guidance.
