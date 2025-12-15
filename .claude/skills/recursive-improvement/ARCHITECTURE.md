# Recursive Self-Improvement Architecture

## Overview

A dogfooding loop where meta-tools improve each other, then audit and improve everything else.

```
                    COMPLETE RECURSIVE IMPROVEMENT LOOP

                         +-------------------+
                         |   AGENT CREATOR   |  <-- FOUNDRY: Creates all agents
                         |   (Meta-Agent)    |
                         +-------------------+
                                  |
                     creates      |      can improve
                   +-------------+-------------+
                   |                           |
                   v                           v
     +------------------+         +------------------+
     |   PROMPT FORGE   |-------->|   SKILL FORGE    |
     | (Meta-Prompt)    |<--------|   (Meta-Skill)   |
     +------------------+         +------------------+
              |                            |
              |   Improved tools audit     |
              |   and improve everything   |
              v                            v
     +--------------------------------------------------+
     |              AUDITOR AGENTS                       |
     |  [Prompt] [Skill] [Expertise] [Output]           |
     |       (created by Agent Creator)                 |
     +--------------------------------------------------+
              |                            |
              |   All changes gated by     |
              v                            v
     +--------------------------------------------------+
     |              EVAL HARNESS (FROZEN)               |
     |  Benchmarks | Regression Tests | Human Gates     |
     +--------------------------------------------------+
              |
              v
     +--------------------------------------------------+
     |         PROPOSE -> TEST -> COMPARE ->            |
     |         COMMIT -> MONITOR -> ROLLBACK            |
     +--------------------------------------------------+
```

## Agent Creator's Role in the Loop

**Agent Creator is the FOUNDRY** - it manufactures the components that power the loop.

### Role 1: Bootstrap (Before Loop Starts)

Agent Creator creates the auditor agents that the loop needs:

```
Agent Creator
    |
    +--> prompt-auditor (finds prompt issues)
    +--> skill-auditor (checks skill compliance)
    +--> expertise-auditor (detects drift)
    +--> output-auditor (catches premature coherence)
    |
    v
Auditors now exist to power the loop
```

### Role 2: Improvement Target (Inside Loop)

Agent Creator is itself a skill, so it CAN be improved by the loop:

```
skill-auditor --> Audits agent-creator
        |
        v
prompt-forge --> Generates proposals for agent-creator
        |
        v
skill-forge --> Applies proposals to agent-creator
        |
        v
eval-harness --> Tests improved agent-creator
        |
        v
If improved: Commit new version
```

### Role 3: Extension (When Loop Needs New Agents)

When the loop discovers it needs a new type of auditor:

```
Loop discovers gap: "Need specialized X auditor"
        |
        v
Agent Creator --> Creates new specialized auditor
        |
        v
New auditor joins the audit phase
        |
        v
Loop continues with enhanced capability
```

### Summary: Agent Creator is Dual-Role

| Role | When | What Happens |
|------|------|--------------|
| **Creator** | Bootstrap + Extension | Creates auditor agents |
| **Target** | During improvement cycles | Gets improved like any skill |

## Core Principle

> "A self-improvement loop is only as good as its evaluation harness."

Without frozen evaluation:
- Prettier prompts that are more confidently wrong
- Overfitting to "sounds good" instead of "works better"
- Goodhart's Law: optimize the metric, not the outcome

## Architecture Components

### 1. Prompt Forge (Meta-Prompt)

**Purpose**: Generate improved prompts/templates with rationale

**Outputs**:
- Candidate prompt improvements
- "Prompt diffs" showing what changed
- Rationale for each change
- Predicted improvement metrics

**Self-Improvement Target**: Skill Forge prompts

### 2. Skill Forge (Meta-Skill)

**Purpose**: Turn prompts into executable skills/tools

**Outputs**:
- Standardized skill files
- Interface contracts
- Logging specifications
- Test cases

**Self-Improvement Target**: Prompt Forge (and itself!)

### 3. Expert Packs (Agent Experts)

**Purpose**: Domain expertise files (mental models)

**Self-Improvement**: Auto-update after changes via expertise system

### 4. Eval Harness (FROZEN)

**Purpose**: Gate all changes with objective evaluation

**Components**:
- "Simple Wins" task suite (real work packets)
- Scoring: accuracy, format fidelity, time, regressions
- Gates: must-pass tests + human approval thresholds

**Critical**: This does NOT self-improve. Only manually expanded.

### 5. Auditor Agents

**Purpose**: Find issues across all components

**Types**:
- **Prompt Auditor**: Finds ambiguity, missing constraints, weak failure handling
- **Skill Auditor**: Checks tool contracts, logging, idempotency, safety rails
- **Expertise Auditor**: Compares expertise files against code, flags drift
- **Output Auditor**: Checks artifact compliance, catches "premature coherence"

## The Bootstrap Loop

### Safe Recursion Protocol

```
CYCLE N:

1. PROMPT FORGE proposes improvements to SKILL FORGE prompts
   - Better tool specs
   - Better error handling instructions
   - Better output schemas

2. SKILL FORGE rebuilds SKILL FORGE
   - Yes, it generates its own improved version
   - Output: skill-forge-v{N+1}.md

3. RUN EVAL HARNESS on both:
   - Prompt generation quality (does Prompt Forge produce better candidates?)
   - Skill generation quality (do generated skills run, log, follow contracts?)

4. IF metrics improve AND no regressions:
   - COMMIT as version bump
   - Archive previous version for rollback

5. IF metrics regress OR regressions detected:
   - REJECT change
   - Log failure reason for learning
   - Rollback to previous version

6. USE IMPROVED DUO to audit/upgrade other prompts/skills/experts
   - Same propose -> test -> commit pipeline
   - Each auditor finding becomes actionable diff
```

### Safeguards Against Compounding Misalignment

| Danger | Safeguard |
|--------|-----------|
| Optimizing wrong metric | Frozen eval suite (only manually expanded) |
| Confident fantasy drift | Multi-agent disagreement as rejection signal |
| Premature coherence | Refuse/uncertainty pathway in all prompts |
| Silent regressions | Regression test suite runs on every commit |
| Unrecoverable changes | Version everything, instant rollback |

## Improvement Pipeline

### Stage 1: Propose

```yaml
proposal:
  target: "skill-forge/SKILL.md"
  type: "prompt_improvement"
  changes:
    - section: "Phase 2"
      before: "..."
      after: "..."
      rationale: "Adds explicit failure handling for edge case X"
  predicted_improvement:
    metric: "skill_success_rate"
    expected_delta: "+5%"
  risk_assessment:
    regression_risk: "low"
    affected_components: ["micro-skill-creator", "agent-creator"]
```

### Stage 2: Test

```yaml
test_run:
  proposal_id: "prop-123"
  eval_suite: "skill-generation-benchmark-v1"
  results:
    baseline_score: 0.82
    candidate_score: 0.87
    regression_tests:
      passed: 47
      failed: 0
      new_failures: []
    human_review_required: false
```

### Stage 3: Compare

```yaml
comparison:
  improvement: 0.05  # 5% gain
  regressions: 0
  confidence: 0.92
  recommendation: "ACCEPT"
  reasoning: "Consistent improvement across all test cases, no regressions"
```

### Stage 4: Commit

```yaml
commit:
  proposal_id: "prop-123"
  target: "skill-forge/SKILL.md"
  version: "2.1.0"
  previous_version: "2.0.0"
  archive_path: ".claude/skills/skill-forge/.archive/SKILL-v2.0.0.md"
  changelog_entry: "Added explicit failure handling for edge case X (+5% success rate)"
```

### Stage 5: Monitor

```yaml
monitoring:
  commit_id: "prop-123"
  metrics_window: "7 days"
  tracked_metrics:
    - skill_success_rate
    - skill_generation_time
    - downstream_failures
  alert_threshold:
    regression: 0.03  # Alert if >3% regression
```

### Stage 6: Rollback (If Needed)

```yaml
rollback:
  trigger: "regression_detected"
  from_version: "2.1.0"
  to_version: "2.0.0"
  reason: "Downstream failures increased by 8% after commit"
  action: "Restore .archive/SKILL-v2.0.0.md"
```

## Memory Architecture

| Namespace | Purpose | Retention |
|-----------|---------|-----------|
| `improvement/proposals` | Pending proposals | Until resolved |
| `improvement/test-results` | Test run results | 30 days |
| `improvement/commits` | Committed changes | Permanent |
| `improvement/rollbacks` | Rollback events | Permanent |
| `improvement/metrics` | Continuous monitoring | 90 days |

## Key Insight: Auditors as Linters

Once Prompt Forge + Skill Forge are stable, auditors operate like code linters:

```
AUDITOR OUTPUT -> ACTIONABLE DIFF -> IMPROVEMENT PIPELINE

Example:
  Prompt Auditor finds: "Phase 3 lacks explicit timeout handling"
                 |
                 v
  Creates proposal: "Add timeout handling to Phase 3"
                 |
                 v
  Runs through: Propose -> Test -> Compare -> Commit
```

## Version Control

Every component is versioned:

```
.claude/skills/
  skill-forge/
    SKILL.md                    # Current version
    .archive/
      SKILL-v1.0.0.md          # Previous versions
      SKILL-v2.0.0.md
      ...
    CHANGELOG.md               # Version history

  prompt-forge/
    SKILL.md
    .archive/
      ...
```

## Human Gates

Not everything auto-commits. Human approval required for:

1. **Breaking changes** - Interface modifications
2. **High-risk changes** - Security-related, core logic
3. **Disagreement** - When 3+ auditors disagree
4. **Novel patterns** - First-time change types
5. **Threshold crossings** - Major metric movements

## Anti-Patterns to Avoid

### DO NOT:

1. **Auto-commit without eval** - Every change must pass harness
2. **Mutate eval suite in same cycle** - Keep eval frozen per cycle
3. **Trust "sounds better"** - Only trust measurable improvement
4. **Skip rollback capability** - Always archive before commit
5. **Ignore disagreement** - Multi-agent disagreement = human review

### DO:

1. **Gate everything through eval harness**
2. **Version everything with rollback**
3. **Require expertise diffs for learning updates**
4. **Include refuse/uncertainty pathway**
5. **Monitor continuously after commit**

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Improvement acceptance rate | >60% | Accepted / Proposed |
| Regression rate | <5% | Rollbacks / Commits |
| Cycle time | <4 hours | Propose to Commit |
| Compounding gain | >2% per cycle | Metric improvement trend |
| Human intervention | <20% | Human gates triggered |

---

**Status**: Architecture Design
**Version**: 1.0.0
**Key Insight**: Self-improvement only works with frozen evaluation
