---
name: meta-loop-orchestrator
description: Orchestrates the recursive self-improvement meta loop by coordinating foundry skills (agent-creator, skill-forge, prompt-forge) with Ralph Wiggum persistence loops. Use when running recursive improvement cycles on the plugin's own skills and agents.
version: 1.0.0
category: orchestration
tags:
  - orchestration
  - meta-loop
  - recursive-improvement
  - foundry
  - ralph-wiggum
author: Context Cascade
mcp_servers:
  required:
    - memory-mcp
  optional:
    - ruv-swarm
---

# Meta Loop Orchestrator

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.



Orchestrates the recursive self-improvement pipeline by coordinating foundry skills with Ralph Wiggum persistence loops. This skill enables bounded self-improvement where skills, agents, and prompts can improve themselves while being gated by frozen eval harness validation.

## SKILL-SPECIFIC GUIDANCE

### When to Use This Skill

- Recursive improvement of foundry skills (agent-creator, skill-forge, prompt-forge)
- Self-improvement cycles on the plugin's own components
- Coordinating multiple foundry skills in a pipeline
- Running auditor validation on foundry outputs
- Executing eval harness gated improvement cycles

### When NOT to Use This Skill

- One-time skill/agent creation (use individual foundry skills directly)
- Tasks not involving self-improvement of plugin components
- Non-foundry skills (use cascade-orchestrator instead)
- Quick fixes without full validation cycle

### Success Criteria
- [assert|neutral] All nested Ralph loops complete within max iterations [ground:acceptance-criteria] [conf:0.90] [state:provisional]
- [assert|neutral] All 4 auditors pass validation [ground:acceptance-criteria] [conf:0.90] [state:provisional]
- [assert|neutral] Eval harness shows improvement >= 0% (no regression) [ground:acceptance-criteria] [conf:0.90] [state:provisional]
- [assert|neutral] Changes committed and monitoring initiated [ground:acceptance-criteria] [conf:0.90] [state:provisional]

### Edge Cases

- If nested Ralph loop hits max iterations: Escalate to human
- If auditor fails repeatedly: Route back to foundry skill
- If eval harness regression detected: REJECT and rollback

### Critical Guardrails

NEVER:
- Modify eval harness code (FROZEN)
- Skip auditor validation
- Commit without eval harness pass
- Disable monitoring phase
- Bypass human gates for large changes (>500 lines)

ALWAYS:
- Run all 4 auditors in parallel
- Store all intermediate states in memory-mcp
- Maintain rollback capability
- Log all iterations for debugging

## Core Architecture

```
META-LOOP ORCHESTRATION FLOW
============================

INPUT: Task + Target + Foundry Skill
                |
                v
        +---------------+
        |   PREPARE     |
        |   - Parse     |
        |   - Load exp  |
        |   - Select    |
        +---------------+
                |
                v
    +=======================+
    |   EXECUTE (Ralph #1)  |
    |   Foundry skill runs  |
    |   until proposal ready|
    +=======================+
                |
                v
    +=======================+
    |  IMPLEMENT (Ralph #2) |
    |   Apply changes to    |
    |   target file(s)      |
    +=======================+
                |
                v
    +-------+-------+-------+-------+
    |       |       |       |       |
    v       v       v       v       v
  [R#3]   [R#4]   [R#5]   [R#6]   <- Parallel Ralph Loops
  Prompt  Skill   Expert  Output
  Audit   Audit   Audit   Audit
    |       |       |       |
    +-------+-------+-------+
                |
                v
    +=======================+
    |    EVAL (Ralph #7)    |
    |    Run eval harness   |
    |    Fix until pass     |
    +=======================+
                |
                v
        +---------------+
        |    COMPARE    |
        |   baseline vs |
        |   candidate   |
        +---------------+
                |
        +-------+-------+
        |               |
        v               v
     ACCEPT          REJECT
        |               |
        v               v
     COMMIT        LOG FAILURE
        |           (retry)
        v
    +=======================+
    |  MONITOR (Ralph #8)   |
    |    7-day watch        |
    +=======================+
        |
        v
     COMPLETE
```

## Phase Definitions

### Phase 1: PREPARE

```yaml
prepare:
  actions:
    - Parse task and target from input
    - Detect domain from target path
    - Load expertise: .claude/expertise/{domain}.yaml
    - Select foundry skill based on task type
    - Initialize meta-loop state file

  outputs:
    task: "Parsed task description"
    target: "File path to modify"
    foundry_skill: "agent-creator|skill-forge|prompt-forge"
    expertise: "Loaded domain expertise"
    session_id: "meta-{timestamp}"

  completion:
    signal: State file created with phase=EXECUTE
```

### Phase 2: EXECUTE (Ralph Loop #1)

```yaml
execute:
  ralph_config:
    max_iterations: 30
    completion_promise: "{FOUNDRY}_PROPOSAL_READY"

  prompt_template: |
    Execute {foundry_skill} for task: {task}
    Target: {target}

    Foundry Skill Phases:
    [Insert appropriate foundry skill phases]

    After completing all phases:
    - Generate improvement proposal
    - Document all changes needed
    - Predict improvement metrics

    Output <promise>{FOUNDRY}_PROPOSAL_READY</promise>

  outputs:
    proposal:
      changes: "List of changes to make"
      rationale: "Why each change improves target"
      predicted_improvement: "Expected metric deltas"
```

### Phase 3: IMPLEMENT (Ralph Loop #2)

```yaml
implement:
  ralph_config:
    max_iterations: 20
    completion_promise: "CHANGES_APPLIED"

  prompt_template: |
    Apply improvement proposal to {target}:

    Changes to make:
    {proposal.changes}

    For each change:
    1. Locate exact position in file
    2. Apply edit
    3. Validate syntax/structure
    4. Run quick validation

    Output <promise>CHANGES_APPLIED</promise> when all edits complete

  outputs:
    modified_files: "List of files changed"
    edit_summary: "Summary of edits applied"
```

### Phase 4: AUDIT (Parallel Ralph Loops #3-6)

```yaml
audit:
  parallel_loops:
    - id: prompt-audit
      ralph_config:
        max_iterations: 10
        completion_promise: "PROMPT_AUDIT_PASS"
      prompt: |
        Audit prompts/instructions in modified files:
        - Clarity score >= 0.8
        - Completeness score >= 0.8
        - Evidence-based techniques applied
        Output <promise>PROMPT_AUDIT_PASS</promise>

    - id: skill-audit
      ralph_config:
        max_iterations: 10
        completion_promise: "SKILL_AUDIT_PASS"
      prompt: |
        Audit skill structure:
        - Tier 1-2 sections at 100%
        - YAML frontmatter valid
        - Examples present
        Output <promise>SKILL_AUDIT_PASS</promise>

    - id: expertise-audit
      ralph_config:
        max_iterations: 15
        completion_promise: "EXPERTISE_AUDIT_PASS"
      prompt: |
        Audit domain expertise accuracy:
        - File locations still valid
        - Patterns match current code
        - No stale information
        Output <promise>EXPERTISE_AUDIT_PASS</promise>

    - id: output-audit
      ralph_config:
        max_iterations: 10
        completion_promise: "OUTPUT_AUDIT_PASS"
      prompt: |
        Audit generated outputs:
        - Matches specification
        - Quality metrics met
        - Format validation passes
        Output <promise>OUTPUT_AUDIT_PASS</promise>

  aggregation:
    all_must_pass: true
    failure_action: Route back to EXECUTE phase with auditor feedback
```

### Phase 5: EVAL (Ralph Loop #7)

```yaml
eval:
  ralph_config:
    max_iterations: 50
    completion_promise: "EVAL_HARNESS_PASS"

  prompt_template: |
    Run complete eval harness validation:

    Benchmark Suite: {benchmark_suite}
    Regression Suite: {regression_suite}

    For each failing test:
    1. Analyze failure reason
    2. Generate fix
    3. Apply fix
    4. Re-run test

    Requirements:
    - All benchmarks PASS
    - No regressions (0 failures)
    - Metrics improved or unchanged

    Output <promise>EVAL_HARNESS_PASS</promise>

  outputs:
    benchmark_results: "Benchmark test results"
    regression_results: "Regression test results"
    final_metrics: "Post-improvement metrics"
```

### Phase 6: COMPARE

```yaml
compare:
  actions:
    - Load baseline metrics from before changes
    - Load candidate metrics from eval phase
    - Calculate deltas for each metric
    - Apply decision rules

  decision_rules:
    accept_if:
      - All metrics improved OR unchanged
      - No new regressions introduced
      - Auditor scores >= baseline

    reject_if:
      - Any metric regressed > 5%
      - New critical issues introduced
      - Auditor scores < baseline

    escalate_if:
      - Mixed results (some improved, some regressed)
      - Large change (>500 lines)
      - Confidence < 0.80

  outputs:
    verdict: "ACCEPT|REJECT|ESCALATE"
    rationale: "Explanation of decision"
```

### Phase 7: COMMIT (if ACCEPT)

```yaml
commit:
  actions:
    - Stage all modified files
    - Generate commit message from proposal
    - Create commit with attribution
    - Tag with session_id for rollback

  commit_template: |
    {type}({scope}): {description}

    Meta-Loop Session: {session_id}
    Foundry Skill: {foundry_skill}
    Iterations: {total_iterations}

    Metrics:
    - Before: {baseline_metrics}
    - After: {candidate_metrics}

    Generated by Meta-Loop Orchestrator
    Co-Authored-By: Claude <noreply@anthropic.com>
```

### Phase 8: MONITOR (Ralph Loop #8)

```yaml
monitor:
  ralph_config:
    max_iterations: 7  # One per day
    completion_promise: "MONITOR_COMPLETE"
    interval: 24h

  prompt_template: |
    Monitor deployed changes for day {iteration}/7:

    Check:
    - Error logs for regressions
    - Usage metrics vs baseline
    - Performance degradation

    If regression detected:
    - Alert with details
    - Recommend rollback

    After day 7:
    Output <promise>MONITOR_COMPLETE</promise>

  rollback_trigger:
    - Error rate increase > 10%
    - Performance degradation > 20%
    - Critical bug reported
```

## State Management

### Meta Loop State File

Location: `~/.claude/ralph-wiggum/meta-loop-state.yaml`

```yaml
---
session_id: meta-20251228-160000
active: true
current_phase: EXECUTE
started_at: 2025-12-28T16:00:00

input:
  task: "Add cognitive frame integration"
  target: "skills/foundry/skill-forge/SKILL.md"
  foundry_skill: prompt-forge

nested_loops:
  - id: execute-001
    phase: EXECUTE
    status: complete
    iterations: 12
    promise: "PROMPT_FORGE_PROPOSAL_READY"

  - id: implement-002
    phase: IMPLEMENT
    status: active
    iterations: 3
    promise: "CHANGES_APPLIED"

auditor_status:
  prompt: pending
  skill: pending
  expertise: pending
  output: pending

metrics:
  baseline:
    clarity: 0.85
    completeness: 0.82
    precision: 0.80
  candidate: null

verdict: null
commit_sha: null
monitoring_day: 0
---
```

## Memory Namespace

```yaml
memory_namespace: meta-loop/

namespaces:
  sessions/{session_id}:
    description: Complete session state
    retention: 90d

  foundry/{skill}/{session_id}:
    description: Foundry skill execution logs

  auditors/{type}/{session_id}:
    description: Auditor results and feedback

  proposals/{session_id}:
    description: Generated improvement proposals

  eval-results/{session_id}:
    description: Eval harness results

  comparisons/{session_id}:
    description: Baseline vs candidate analysis

  monitoring/{session_id}/{day}:
    description: Daily monitoring logs
```

## Commands

### /meta-loop-foundry

```bash
# Start a meta loop cycle
/meta-loop-foundry "<task>" --target "<file>" --foundry "<skill>"

# Examples
/meta-loop-foundry "Improve error handling" \
  --target "skills/foundry/skill-forge/SKILL.md" \
  --foundry "prompt-forge"

/meta-loop-foundry "Add cognitive frame support" \
  --target "agents/foundry/agent-creator.md" \
  --foundry "prompt-forge"
```

### /meta-loop-status

```bash
# Check current status
/meta-loop-status

# Output:
# Session: meta-20251228-160000
# Phase: IMPLEMENT (3/20 iterations)
# Nested Loops: 2 complete, 1 active
# Auditors: Pending (4/4)
# Next: Finish IMPLEMENT, then AUDIT
```

### /meta-loop-cancel

```bash
# Cancel active loop
/meta-loop-cancel

# Force cancel (skip cleanup)
/meta-loop-cancel --force
```

### /meta-loop-rollback

```bash
# Rollback a completed session
/meta-loop-rollback meta-20251228-160000

# Confirm rollback
# > This will revert 3 files to previous state. Proceed? [y/N]
```

## Cross-Skill Coordination

Works with:
- **ralph-loop**: Provides persistence mechanism for each phase
- **agent-creator**: Target foundry skill for agent improvements
- **skill-forge**: Target foundry skill for skill improvements
- **prompt-forge**: Target foundry skill for prompt improvements
- **cascade-orchestrator**: Alternative for non-foundry orchestration

Integration Points:
- Ralph loop state management shared with `/ralph-loop`
- Foundry skills invoked with full phase execution
- Eval harness integration for quality gating
- Memory MCP for state persistence

## Conclusion

Meta Loop Orchestrator enables bounded self-improvement of the Context Cascade plugin by coordinating foundry skills within Ralph Wiggum persistence loops. Each phase runs in its own loop, ensuring completion before progression. The frozen eval harness prevents Goodhart's Law drift while 4 parallel auditors catch quality issues. The 7-day monitoring phase with automatic rollback ensures production stability.

Use this skill when the plugin needs to improve itself - whether enhancing skill-forge's documentation audit, adding cognitive frames to agent-creator, or optimizing prompt-forge's evidence-based techniques. The nested loop architecture ensures persistent execution while safety constraints prevent unbounded self-modification.

---

## Completion Verification

After invoking this skill, verify:

- [ ] Meta loop state file created
- [ ] All nested Ralph loops configured
- [ ] Auditor parallel execution planned
- [ ] Eval harness suite identified
- [ ] Monitoring scheduled

Pattern: `Skill("meta-loop-orchestrator") -> [Ralph loops] -> TodoWrite()`
