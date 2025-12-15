# Mass Improvement Plan: Skills, Agents, and Commands

**Created**: 2025-12-15
**Status**: Planning
**Meta-Skills Version**: 2.2.0

---

## Scope Analysis

| Category | Count | Location |
|----------|-------|----------|
| Skills | 126 | `.claude/skills/` |
| Agents | 217 | `claude-code-plugins/ruv-sparc-three-loop-system/agents/` |
| Commands | 18 | Various `.claude/commands/` directories |
| **Total** | **361** | |

---

## Strategy: 4-Phase Improvement Pipeline

### Phase 1: AUDIT (Automated Discovery)
Run auditors on all items to identify improvement opportunities.

### Phase 2: TRIAGE (Prioritization)
Categorize by impact and effort, create improvement queue.

### Phase 3: IMPROVE (Batch Processing)
Apply improvements using meta-skills in batches.

### Phase 4: VALIDATE (Quality Gate)
Verify improvements work, no regressions.

---

## Phase 1: AUDIT

### 1.1 Skill Audit

```yaml
audit_operation:
  target: "All 126 skills"
  auditors:
    - skill-auditor (structure, contracts, phases)
    - prompt-auditor (clarity, completeness)
    - expertise-auditor (domain knowledge)

  checks:
    - Has Phase 0 (Expertise Loading)?
    - Has Input/Output contracts?
    - Has error handling?
    - Has quality mechanisms?
    - Uses imperative voice?
    - Description 80-150 words?
    - Has GraphViz diagram?
    - Version in frontmatter?

  output: "skill-audit-report.json"
```

### 1.2 Agent Audit

```yaml
audit_operation:
  target: "All 217 agents"
  auditors:
    - prompt-auditor (system prompt quality)
    - output-auditor (output specification)

  checks:
    - Has clear identity section?
    - Has methodology section?
    - Has failure handling?
    - Has communication protocol?
    - Uses evidence-based techniques?
    - Has domain knowledge embedded?

  output: "agent-audit-report.json"
```

### 1.3 Command Audit

```yaml
audit_operation:
  target: "All 18 commands"
  auditors:
    - prompt-auditor (instruction clarity)

  checks:
    - Has clear description?
    - Has usage examples?
    - Has argument specification?
    - Has error handling guidance?

  output: "command-audit-report.json"
```

---

## Phase 2: TRIAGE

### Priority Matrix

| Priority | Criteria | Action |
|----------|----------|--------|
| P0 - Critical | Meta-skills, core orchestrators | Immediate improvement |
| P1 - High | Frequently used skills/agents | Next batch |
| P2 - Medium | Domain-specific tools | Scheduled improvement |
| P3 - Low | Rarely used, niche tools | As capacity allows |

### Categorization Rules

```yaml
P0_Critical:
  - skill-forge
  - agent-creator
  - prompt-architect
  - bootstrap-loop
  - eval-harness
  - improvement-pipeline
  - All auditor agents

P1_High:
  - intent-analyzer
  - cascade-orchestrator
  - parallel-swarm-implementation
  - research-driven-planning
  - cicd-intelligent-recovery
  - functionality-audit
  - code-review-assistant
  - All GitHub integration skills
  - All swarm skills

P2_Medium:
  - AgentDB skills (5)
  - Deep Research skills (5)
  - Flow Nexus skills (3)
  - ML/Training skills
  - Testing/Quality skills

P3_Low:
  - Specialized niche tools
  - Legacy/deprecated items
  - Single-use utilities
```

### Effort Estimation

| Issue Type | Effort | Batch Size |
|------------|--------|------------|
| Missing Phase 0 | Low | 20/batch |
| Missing contracts | Low | 20/batch |
| Missing error handling | Medium | 10/batch |
| System prompt rewrite | High | 5/batch |
| Full skill rebuild | Very High | 1-2/batch |

---

## Phase 3: IMPROVE

### 3.1 Improvement Waves

```
Wave 1: Foundation (P0 items)
  - Already done: agent-creator, skill-forge, prompt-architect
  - Remaining: bootstrap-loop, eval-harness, improvement-pipeline, auditors
  - Estimated: 10 items

Wave 2: Core Infrastructure (P1 - Orchestrators)
  - Target: intent-analyzer, cascade-orchestrator, parallel-swarm, etc.
  - Estimated: 15 items

Wave 3: Core Infrastructure (P1 - Integration)
  - Target: GitHub skills, swarm skills, code-review
  - Estimated: 20 items

Wave 4: Domain Skills (P2)
  - Target: AgentDB, Deep Research, Flow Nexus, ML
  - Estimated: 30 items

Wave 5: Agent Updates (Batch 1)
  - Target: First 50 agents alphabetically
  - Focus: Add Phase 0, contracts

Wave 6: Agent Updates (Batch 2)
  - Target: Next 50 agents
  - Focus: Add Phase 0, contracts

Wave 7: Agent Updates (Batch 3)
  - Target: Next 50 agents
  - Focus: Add Phase 0, contracts

Wave 8: Agent Updates (Batch 4)
  - Target: Remaining 67 agents
  - Focus: Add Phase 0, contracts

Wave 9: Remaining Skills (P3)
  - Target: All remaining skills
  - Focus: Standardization

Wave 10: Commands
  - Target: All 18 commands
  - Focus: Documentation, examples
```

### 3.2 Per-Item Improvement Process

```yaml
improvement_process:
  for_each_item:
    1_load_expertise:
      - Check if domain expertise exists
      - Load if available
      - Flag for generation if missing

    2_audit:
      - Run appropriate auditors
      - Collect findings
      - Score current state (0.0-1.0)

    3_generate_proposal:
      - Use prompt-forge for prompts
      - Use skill-forge for skills
      - Use agent-creator for agents
      - Create concrete diffs

    4_apply_changes:
      - Apply diffs via improvement-pipeline
      - Preserve existing functionality
      - Add new sections

    5_validate:
      - Run validation script
      - Check for regressions
      - Score new state

    6_commit_or_rollback:
      - If improved: commit changes
      - If regression: rollback
      - Log results
```

### 3.3 Batch Processing Template

```javascript
// Batch improvement script
async function improveBatch(items, batchId) {
  const results = [];

  for (const item of items) {
    console.log(`[BATCH ${batchId}] Processing: ${item.name}`);

    // 1. Audit
    const audit = await runAudit(item);

    // 2. Generate proposal
    const proposal = await generateProposal(item, audit);

    // 3. Apply
    const candidate = await applyProposal(item, proposal);

    // 4. Validate
    const validation = await validate(candidate);

    // 5. Commit or rollback
    if (validation.improved && !validation.regression) {
      await commit(candidate);
      results.push({ item: item.name, status: 'improved', delta: validation.delta });
    } else {
      await rollback(candidate);
      results.push({ item: item.name, status: 'skipped', reason: validation.reason });
    }
  }

  return results;
}
```

---

## Phase 4: VALIDATE

### 4.1 Validation Criteria

```yaml
validation_gates:
  structure:
    - YAML frontmatter valid
    - Required sections present
    - File references resolve

  functionality:
    - Skill can be invoked
    - No runtime errors
    - Output matches contract

  quality:
    - Score >= previous score
    - No regression in tests
    - Imperative voice check passes

  integration:
    - Works with related skills
    - Memory coordination intact
    - Hooks execute correctly
```

### 4.2 Regression Testing

```yaml
regression_tests:
  run_after_each_batch:
    - Invoke 3 random skills from batch
    - Verify they produce expected output
    - Check memory operations work
    - Verify cross-skill references resolve

  run_after_each_wave:
    - Full integration test
    - Test skill chains
    - Verify agent orchestration
```

---

## Execution Commands

### Start Audit Phase

```bash
# Create audit command
/run-mass-audit --target skills --output skill-audit-report.json
/run-mass-audit --target agents --output agent-audit-report.json
/run-mass-audit --target commands --output command-audit-report.json
```

### Start Improvement Wave

```bash
# Wave 1 example
/run-improvement-wave --wave 1 --items "bootstrap-loop,eval-harness,improvement-pipeline" --dry-run
/run-improvement-wave --wave 1 --items "bootstrap-loop,eval-harness,improvement-pipeline" --execute
```

### Track Progress

```bash
# Check status
/improvement-status
```

---

## Progress Tracking

### Dashboard Schema

```yaml
improvement_dashboard:
  total_items: 361

  by_category:
    skills:
      total: 126
      audited: 0
      improved: 3  # meta-skills done
      validated: 3
    agents:
      total: 217
      audited: 0
      improved: 0
      validated: 0
    commands:
      total: 18
      audited: 0
      improved: 0
      validated: 0

  by_wave:
    wave_1: { planned: 10, completed: 3, status: "in_progress" }
    wave_2: { planned: 15, completed: 0, status: "pending" }
    # ...

  metrics:
    average_improvement: 0.0
    regressions: 0
    time_per_item: "TBD"
```

---

## Risk Mitigation

### Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Breaking existing functionality | Validation gate + rollback capability |
| Inconsistent improvements | Use standardized templates |
| Time/effort underestimation | Start with small batches, adjust |
| Missing domain expertise | Generate expertise as side effect |
| Circular dependencies | Improve in dependency order |

### Rollback Strategy

```yaml
rollback_strategy:
  per_item:
    - Keep original in .archive/
    - Version tag before changes
    - Git commit per batch

  per_wave:
    - Git branch per wave
    - Can revert entire wave

  emergency:
    - Full backup before starting
    - Can restore from backup
```

---

## Success Criteria

### Wave Completion Criteria

- All items in wave processed
- No unresolved regressions
- Average improvement score > 0
- Validation pass rate > 90%

### Overall Success Criteria

- All 361 items processed
- Average improvement >= 20%
- No critical regressions
- All P0/P1 items at quality threshold
- Documentation updated

---

## Next Steps

1. **Create audit scripts** for automated discovery
2. **Run audit on all skills** (126 items)
3. **Generate triage report** with priorities
4. **Start Wave 1** (remaining P0 items)
5. **Iterate through waves** until complete

---

**Version**: 1.0.0
**Last Updated**: 2025-12-15
