---
name: when-debugging-code-use-debugging-assistant
description: Routing SOP for debugging requests; invokes the debugging skill with ceilinged confidence and preserved constraints.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task, TodoWrite
model: sonnet
x-version: 3.2.0
x-category: delivery
x-vcl-compliance: v3.1.1
x-cognitive-frames: [HON, MOR, COM, CLS, EVD, ASP, SPC]
---

## STANDARD OPERATING PROCEDURE

### Purpose
Classify debugging requests, gather evidence, and execute the `debugging` skill with the same structure-first and confidence rules as prompt-architect and skill-forge.

### Trigger Conditions
- **Positive:** failing tests, runtime errors, unexpected output, perf regressions, flaky behavior, suspicious logs.
- **Negative:** net-new features (`feature-dev-complete`), localization (`i18n-automation`), or complex incidents better suited for `smart-bug-fix`.

### Guardrails
- **Structure-first:** maintain `examples/`, `tests/`, `resources/`, `references/` in this router and downstream `debugging`.
- **Constraint extraction:** HARD (data safety, uptime, repro environment), SOFT (tooling), INFERRED (rollback tolerance) — confirm inferred.
- **Confidence ceilings:** `{inference/report:0.70, research:0.85, observation/definition:0.95}` for routing and initial hypotheses.
- **Safety:** no production mutation without backups; prefer minimal repro environments.

### Execution Phases
1. **Intent & Scope**
   - Parse request; record HARD/SOFT/INFERRED constraints; confirm this is a debugging ask.
2. **Evidence Pack**
   - Collect repro steps, logs/traces, failing tests; store in `resources/`.
   - Note prior attempts; add reusable snippets to `examples/`.
3. **Invoke Debugging Skill**
   - Apply `skills/delivery/debugging` SOP; ensure tests and validation steps captured in `tests/`.
   - Track hypotheses with ceilings; cite sources in `references/`.
4. **Closeout**
   - Deliver summary, status, risks, next steps, and **Confidence: X.XX (ceiling: TYPE Y.YY)**.

### Output Format
- Routing decision + constraints (HARD/SOFT/INFERRED) with confirmations.
- Evidence pack summary; validation progress.
- Confidence statement with ceiling and action items.

### Validation Checklist
- [ ] Intent correctly classified; misroutes avoided.
- [ ] Constraints logged; evidence collected.
- [ ] Debugging SOP followed; tests/linters run.
- [ ] Artifacts stored (`resources/`, `references/`, `examples/`); confidence ceilings applied.

### MCP / Memory Tags
- Namespace: `skills/delivery/when-debugging-code-use-debugging-assistant/{project}/{incident}`
- Tags: `WHO=debugging-router-{session}`, `WHY=skill-execution`, `WHAT=debug-routing`

Confidence: 0.70 (ceiling: inference 0.70) - Routing respects skill-forge structure-first and prompt-architect constraint/ceiling discipline.

---

## VCL COMPLIANCE APPENDIX
- [[HON:teineigo]] [[MOR:root:R-O-U]] [[COM:Routing+Debug]] [[CLS:ge_skill]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:path:/skills/delivery/when-debugging-code-use-debugging-assistant]]
  - Structure-first directories enforced.
- [[HON:teineigo]] [[MOR:root:C-N-S]] [[COM:Constraint+Extraction]] [[CLS:ge_principle]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:axis:analysis]]
  - HARD/SOFT/INFERRED constraints confirmed before routing/exec.
- [[HON:teineigo]] [[MOR:root:E-P-S]] [[COM:Epistemic+Ceiling]] [[CLS:ge_rule]] [[EVD:-DI<gozlem>]] [[ASP:nesov.]] [[SPC:coord:EVD-CONF]]
  - Confidence ceilings applied to routing and hypothesis statements.
- Root cause statement with evidence
- Affected code locations and line numbers
- Explanation of why the bug occurs
- Related issues or side effects

**Success Criteria:**
- Clear understanding of the mechanism causing the failure
- Reproducible test case that isolates the root cause
- Documented reasoning chain from symptom to cause

### Phase 3: Fix Generation

**Objective:** Develop and explain solution options

**Agent:** coder

**Actions:**
1. Generate 2-3 solution approaches
2. Evaluate trade-offs for each approach
3. Select optimal solution based on:
   - Correctness and completeness
   - Performance impact
   - Code maintainability
   - Risk of side effects
4. Implement the fix with clear comments
5. Document why this approach was chosen

**Fix Patterns:**
- **Null Safety:** Add null checks, use optional chaining
- **Race Conditions:** Add synchronization, use promises properly
- **Memory Leaks:** Clean up listeners, break circular references
- **Type Errors:** Add runtime validation, improve type definitions
- **Logic Errors:** Correct conditions, fix off-by-one errors

**Outputs:**
- Implemented fix with explanation
- Alternative approaches considered
- Potential side effects documented
- Migration notes if API changes

**Success Criteria:**
- Fix addresses root cause, not just symptoms
- Code is clean and maintainable
- No new issues introduced
- Clear explanation provided

### Phase 4: Validation Testing

**Objective:** Confirm the fix resolves the issue without breaking existing functionality

**Agent:** tester

**Actions:**
1. Create test case that reproduces original bug
2. Verify test fails before fix (proves test validity)
3. Apply fix and verify test passes
4. Run full re

---
<!-- S4 SUCCESS CRITERIA                                                          -->
---

[define|neutral] SUCCESS_CRITERIA := {
  primary: "Skill execution completes successfully",
  quality: "Output meets quality thresholds",
  verification: "Results validated against requirements"
} [ground:given] [conf:1.0] [state:confirmed]

---
<!-- S5 MCP INTEGRATION                                                           -->
---

[define|neutral] MCP_INTEGRATION := {
  memory_mcp: "Store execution results and patterns",
  tools: ["mcp__memory-mcp__memory_store", "mcp__memory-mcp__vector_search"]
} [ground:witnessed:mcp-config] [conf:0.95] [state:confirmed]

---
<!-- S6 MEMORY NAMESPACE                                                          -->
---

[define|neutral] MEMORY_NAMESPACE := {
  pattern: "skills/delivery/SKILL/{project}/{timestamp}",
  store: ["executions", "decisions", "patterns"],
  retrieve: ["similar_tasks", "proven_patterns"]
} [ground:system-policy] [conf:1.0] [state:confirmed]

[define|neutral] MEMORY_TAGGING := {
  WHO: "SKILL-{session_id}",
  WHEN: "ISO8601_timestamp",
  PROJECT: "{project_name}",
  WHY: "skill-execution"
} [ground:system-policy] [conf:1.0] [state:confirmed]

---
<!-- S7 SKILL COMPLETION VERIFICATION                                             -->
---

[direct|emphatic] COMPLETION_CHECKLIST := {
  agent_spawning: "Spawn agents via Task()",
  registry_validation: "Use registry agents only",
  todowrite_called: "Track progress with TodoWrite",
  work_delegation: "Delegate to specialized agents"
} [ground:system-policy] [conf:1.0] [state:confirmed]

---
<!-- S8 ABSOLUTE RULES                                                            -->
---

[direct|emphatic] RULE_NO_UNICODE := forall(output): NOT(unicode_outside_ascii) [ground:windows-compatibility] [conf:1.0] [state:confirmed]

[direct|emphatic] RULE_EVIDENCE := forall(claim): has(ground) AND has(confidence) [ground:verix-spec] [conf:1.0] [state:confirmed]

[direct|emphatic] RULE_REGISTRY := forall(agent): agent IN AGENT_REGISTRY [ground:system-policy] [conf:1.0] [state:confirmed]

---
<!-- PROMISE                                                                      -->
---

[commit|confident] <promise>SKILL_VERILINGUA_VERIX_COMPLIANT</promise> [ground:self-validation] [conf:0.99] [state:confirmed]
