# Recursive Self-Improvement System

## Overview

A dogfooding loop where meta-tools improve each other, then audit and improve everything else.

```
                    RECURSIVE IMPROVEMENT LOOP

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
     +--------------------------------------------------+
              |                            |
              |   All changes gated by     |
              v                            v
     +--------------------------------------------------+
     |              EVAL HARNESS (FROZEN)               |
     |  Benchmarks | Regression Tests | Human Gates     |
     +--------------------------------------------------+
```

## Core Principle

> "A self-improvement loop is only as good as its evaluation harness."

The eval harness is **FROZEN** - it does NOT self-improve. This prevents Goodhart's Law (optimizing the metric instead of the outcome).

---

## Components

### Skills

| Skill | Path | Purpose |
|-------|------|---------|
| **prompt-forge** | `prompt-forge/SKILL.md` | Generate improved prompts with rationale |
| **eval-harness** | `eval-harness/SKILL.md` | FROZEN evaluation (benchmarks + regressions) |
| **bootstrap-loop** | `bootstrap-loop/SKILL.md` | Orchestrate improvement cycles |
| **improvement-pipeline** | `improvement-pipeline/SKILL.md` | Executable pipeline stages |

### Agents

| Agent | Path | Purpose |
|-------|------|---------|
| **prompt-auditor** | `agents/.../prompt-auditor.md` | Find prompt issues |
| **skill-auditor** | `agents/.../skill-auditor.md` | Check skill compliance |
| **expertise-auditor** | `agents/.../expertise-auditor.md` | Detect expertise drift |
| **output-auditor** | `agents/.../output-auditor.md` | Catch premature coherence |

### Integrations

| Integration | Path | Purpose |
|-------------|------|---------|
| **prompt-architect** | `prompt-architect/RECURSIVE-IMPROVEMENT-ADDENDUM.md` | Connect Phase 2 skill |
| **skill-forge** | `skill-forge/RECURSIVE-IMPROVEMENT-ADDENDUM.md` | Enable self-rebuild |
| **agent-creator** | `agent-creator/RECURSIVE-IMPROVEMENT-ADDENDUM.md` | Create improvement-aware agents |

---

## Quick Start

### Run Single Improvement Cycle

```javascript
// 1. Pick a target skill to improve
const target = ".claude/skills/example-skill/SKILL.md";

// 2. Run prompt-auditor to find issues
Task("Prompt Auditor", `Audit ${target} for improvement opportunities`, "prompt-auditor")

// 3. Generate proposals with prompt-forge
Skill("prompt-forge")
// Input: Audit report from step 2

// 4. Apply proposals with skill-forge
Skill("skill-forge")
// Input: Proposals from step 3

// 5. Test against eval harness
// Automatic - eval-harness runs benchmarks + regressions

// 6. Review decision
// ACCEPT: Changes committed, monitoring started
// REJECT: Changes discarded, reasons logged
// PENDING: Human review required
```

### Improve Skill Forge Itself

```javascript
// The recursive magic
Skill("bootstrap-loop")
// This:
// 1. Audits skill-forge
// 2. Generates proposals via prompt-forge
// 3. Applies via skill-forge (PREVIOUS version)
// 4. Tests against eval-harness
// 5. Commits if improved
```

---

## Pipeline Stages

```
PROPOSE -> TEST -> COMPARE -> COMMIT -> MONITOR -> ROLLBACK
   |         |        |          |         |          |
   v         v        v          v         v          v
Generate  Run eval  Compare   Archive   Track     Restore
proposals harness   baseline  + apply   metrics   previous
                    vs new
```

### Stage Details

| Stage | Input | Output | Gate |
|-------|-------|--------|------|
| PROPOSE | Audit report | Proposals with diffs | Must have changes |
| TEST | Candidate content | Benchmark + regression results | Must run full suite |
| COMPARE | Baseline vs candidate | ACCEPT/REJECT/PENDING | Regression = REJECT |
| COMMIT | Accepted proposal | Versioned change | Archive first |
| MONITOR | Committed change | Metric tracking | 7-day window |
| ROLLBACK | Regression alert | Restored version | Archive must exist |

---

## Benchmarks (FROZEN)

### prompt-generation-benchmark-v1
- Tests prompt improvement quality
- Minimum scores: clarity 0.7, completeness 0.7, precision 0.7

### skill-generation-benchmark-v1
- Tests skill creation quality
- Minimum scores: functionality 0.75, compliance 0.8

### expertise-generation-benchmark-v1
- Tests expertise file quality
- Minimum: falsifiability 0.8, precision 0.7

---

## Regression Tests (FROZEN)

### prompt-forge-regression-v1
- 5 must-pass tests
- ANY failure = REJECT

### skill-forge-regression-v1
- 4 must-pass tests
- ANY failure = REJECT

---

## Human Gates

| Gate | Trigger | Timeout | On Timeout |
|------|---------|---------|------------|
| Breaking Change | Interface modification | 24h | REJECT |
| High Risk | Security/core logic | 48h | REJECT |
| Disagreement | 3+ auditors disagree | 24h | REJECT |
| Novel Pattern | First-time change type | 12h | REJECT |
| Threshold | Metric > 10% movement | 24h | Manual review |

---

## Memory Namespaces

| Namespace | Purpose | Retention |
|-----------|---------|-----------|
| `improvement/proposals/{id}` | Pending proposals | Until resolved |
| `improvement/commits/{id}` | Committed changes | Permanent |
| `improvement/rollbacks/{id}` | Rollback events | Permanent |
| `improvement/cycles/{id}` | Full cycle details | 90 days |
| `improvement/metrics` | Aggregate metrics | Permanent |

---

## Hook Integration

The recursive improvement system is enforced via hooks in `.claude/settings.json`:

### Hooks Added

| Hook | Type | File | Purpose |
|------|------|------|---------|
| **recursive-improvement-gate** | PreToolUse (Write/Edit) | `recursive-improvement-gate.sh` | Gate changes to meta-skills |
| **pattern-retention** | PreCompact | `pattern-retention-precompact.sh` | Retain recursive improvement patterns |

### Hook Details

**recursive-improvement-gate.sh** (PreToolUse):
- Detects when modifying meta-skills (prompt-forge, skill-forge, etc.)
- Warns about eval harness requirement
- Lists forbidden changes
- Reminds about archive-before-commit

**pattern-retention-precompact.sh** (PreCompact):
- Section 7 added for recursive improvement system
- Reminds about foundry role (Agent Creator)
- Reminds about eval harness constraint
- Updates checklist with meta-skill items

### Existing Hooks (Enhanced)

| Hook | Enhancement |
|------|-------------|
| **five-phase-enforcer** | Now includes recursive improvement context |
| **sop-compliance-verifier** | Validates SOP pattern for meta-skills |
| **Stop** | Reminds about eval harness and Agent Creator role |

---

## Anti-Patterns

### NEVER:
1. Auto-expand eval harness (only manual)
2. Lower thresholds to pass (thresholds only go UP)
3. Skip regressions (every change runs full suite)
4. Ignore human gates (gates exist for good reasons)
5. Modify frozen benchmarks (create new versions instead)

### ALWAYS:
1. Run full evaluation (no partial runs)
2. Log all results (audit trail required)
3. Respect timeouts (timeout = REJECT)
4. Document decisions (why ACCEPT or REJECT)
5. Archive before commit (90-day retention minimum)

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Improvement acceptance rate | >60% | Accepted / Proposed |
| Regression rate | <5% | Rollbacks / Commits |
| Cycle time | <4 hours | Propose to Commit |
| Compounding gain | >2% per cycle | Metric improvement trend |
| Human intervention | <20% | Human gates triggered |

---

## File Structure

```
.claude/skills/recursive-improvement/
  README.md                    # This file
  ARCHITECTURE.md              # Full architecture design

  prompt-forge/
    SKILL.md                   # Meta-prompt for improvements

  eval-harness/
    SKILL.md                   # FROZEN evaluation

  bootstrap-loop/
    SKILL.md                   # Cycle orchestrator

  improvement-pipeline/
    SKILL.md                   # Executable pipeline

agents/foundry/recursive-improvement/
  prompt-auditor.md            # Prompt quality auditor
  skill-auditor.md             # Skill compliance auditor
  expertise-auditor.md         # Expertise drift detector
  output-auditor.md            # Premature coherence detector
```

---

## Version

- **System Version**: 1.0.0
- **Last Updated**: 2025-12-15
- **Key Constraint**: Eval harness NEVER self-improves
