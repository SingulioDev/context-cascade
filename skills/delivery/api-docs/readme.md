# API Docs Skill (Delivery)

## Scope
Create and maintain accurate REST/GraphQL documentation with validated specs, runnable examples, and interactive explorers. Uses skill-forge’s structure-first layout and prompt-architect’s constraint + confidence rules.

## Use when
- Authoring or updating API references, changelogs, and auth/error guides.
- Publishing OpenAPI/Swagger or GraphQL schemas with tested examples.
- Rolling out new versions or deprecating endpoints.

## Workflow
1. **Scope & constraints** – capture audience, surfaces (REST/GraphQL), versions, auth, and HARD/SOFT/INFERRED constraints; confirm inferred items.
2. **Outline & author** – build required sections (overview, auth, endpoints/operations, errors, limits, changelog); draft specs and examples in `examples/`.
3. **Validate** – run spec lint/validation, execute sample calls where safe, store outputs in `resources/`.
4. **Publish** – wire explorers if needed; add link-check or spec tests in `tests/`; cite sources in `references/`.

## Output contract
- Constraint list + confirmed decisions.
- Validated spec status, runnable examples, and change notes.
- Evidence with **Confidence: X.XX (ceiling: TYPE Y.YY)**.

## Quality gates
- Specs validated; examples executed/annotated.
- Auth, errors, rate limits documented.
- Tests + artifacts in place; references captured.
- Confidence ceilings attached to claims.

Confidence: 0.70 (ceiling: inference 0.70) – aligned with skill-forge guardrails and prompt-architect clarity/ceiling discipline.
