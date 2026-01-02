# i18n Automation Skill (Delivery)

## Scope
Automates internationalization setup, translation workflows, and locale validation while following skill-forge’s structure-first layout and prompt-architect’s clarity/ceiling rules.

## Use when
- Adding or fixing locales, pluralization, RTL support, or translation gaps.
- Wiring i18n libraries and locale detection/fallbacks.
- Validating translation files and formatting correctness.

## Workflow
1. **Assess & constrain** – capture HARD/SOFT/INFERRED requirements (locales, privacy/PII rules, release window, tone); confirm inferred.
2. **Implement** – externalize strings, namespace keys, configure locale detection + fallback, add formatting helpers; store snippets in `examples/`.
3. **Translate** – prep source files, protect placeholders, integrate vendor/MT pipelines; log glossaries in `references/`.
4. **Validate** – lint/validate locale files, test pluralization + formatting boundaries, exercise RTL; store artifacts in `resources/` and tests in `tests/`.

## Output contract
- Constraint ledger with confirmations.
- Key map, locale config, validation results.
- Rollout/rollback notes and **Confidence: X.XX (ceiling: TYPE Y.YY)**.

## Quality gates
- Externalized strings with preserved placeholders.
- Locale detection + fallback verified; RTL tested when relevant.
- Pluralization/formatting validated; tests captured.
- Evidence stored in resources/references; confidence ceilings stated.

Confidence: 0.70 (ceiling: inference 0.70) – reflects skill-forge guardrails and prompt-architect confidence discipline.
