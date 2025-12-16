

## When to Use This Skill

- **Tool Usage**: When you need to execute specific tools, lookup reference materials, or run automation pipelines
- **Reference Lookup**: When you need to access documented patterns, best practices, or technical specifications
- **Automation Needs**: When you need to run standardized workflows or pipeline processes

## When NOT to Use This Skill

- **Manual Processes**: Avoid when manual intervention is more appropriate than automated tools
- **Non-Standard Tools**: Do not use when tools are deprecated, unsupported, or outside standard toolkit

## Success Criteria

- **Tool Executed Correctly**: Verify tool runs without errors and produces expected output
- **Reference Accurate**: Confirm reference material is current and applicable
- **Pipeline Complete**: Ensure automation pipeline completes all stages successfully

## Edge Cases

- **Tool Unavailable**: Handle scenarios where required tool is not installed or accessible
- **Outdated References**: Detect when reference material is obsolete or superseded
- **Pipeline Failures**: Recover gracefully from mid-pipeline failures with clear error messages

## Guardrails

- **NEVER use deprecated tools**: Always verify tool versions and support status before execution
- **ALWAYS verify outputs**: Validate tool outputs match expected format and content
- **ALWAYS check health**: Run tool health checks before critical operations

## Evidence-Based Validation

- **Tool Health Checks**: Execute diagnostic commands to verify tool functionality before use
- **Output Validation**: Compare actual outputs against expected schemas or patterns
- **Pipeline Monitoring**: Track pipeline execution metrics and success rates

# Enhancement Instructions for baseline-replication
You are following structured enhancement instructions. Execute tasks sequentially with explicit validation gates. Document all modifications with clear rationale. Preserve existing functionality while implementing improvements. Use MECE principles for systematic coverage.
You are following structured enhancement instructions. Execute tasks sequentially with explicit validation gates. Document all modifications with clear rationale. Preserve existing functionality while implementing improvements. Use MECE principles for systematic coverage.

**Target Tier**: Silver
**Current Tier**: Incomplete
**Estimated Time**: 2.5 hours

## ⚠️ CRITICAL: Preserve Existing Files

**BEFORE starting any work**:
1. [!] DO NOT modify or delete existing skill.md/SKILL.md
2. [!] DO NOT modify or delete existing README.md (unless improving it)
3. [!] CREATE new files in proper MECE directories only
4. [!] FOLLOW file naming conventions (lowercase for all .md files except SKILL.md, README.md in root)

## Skill Purpose
--- name: "Baseline Replication" description: "Replicate published ML baseline experiments with exact reproducibility (±1% tolerance) for Deep Research SOP Pipeline D. Use when validating baselines, r...

## Tasks to Complete

### Task 1: create_readme (Agent: technical-writer)

Create README.md following MECE universal template:

**Location**: `baseline-replication/README.md`

**Required Sections**:
1. Title and one-line description
2. Quick Start (2-3 steps)
3. When to Use This Skill
4. Structure Overview
5. Examples (link to examples/)
6. Quality Tier: Silver

**Template**: Reference skill-forge/README.md as example

### Task 2: create_examples (Agent: researcher)

Create 1 example(s) in examples/ directory:

**Location**: `baseline-replication/examples/`

**Requirements**:
- example-1-basic.md: Simple, straightforward use case

**Format**: Step-by-step walkthrough with code samples

**Template**: Reference skill-forge/examples/ as model

### Task 3: create_references (Agent: technical-writer)

Create reference documentation in references/ directory:

**Location**: `baseline-replication/references/`

**Suggested Files**:
- best-practices.md: Guidelines and recommendations
- troubleshooting.md: Common issues and solutions
- related-skills.md: Links to complementary skills

**Content**: Abstract concepts, background knowledge, design decisions

### Task 4: create_graphviz (Agent: architect)

Create GraphViz process diagram(s):

**Location**: `baseline-replication/graphviz/`

**Suggested Diagrams**:
- workflow.dot: Main process flow
- orchestration.dot (if multi-agent): Agent coordination pattern

**Format**: GraphViz DOT language with clear labels

**Template**: Reference skill-forge/graphviz/ as model


## Coordination Protocol

**BEFORE starting**:
```bash
npx claude-flow@alpha hooks pre-task --description "Enhance baseline-replication to Silver tier"
```

**DURING work**:
```bash
npx claude-flow@alpha hooks post-edit --file "{file}" --memory-key "skill-enhancement-pipeline/baseline-replication/{component}"
```

**AFTER completion**:
```bash
npx claude-flow@alpha hooks post-task --task-id "enhance-baseline-replication"
npx claude-flow@alpha memory store --key "skill-enhancement-pipeline/baseline-replication/status" --value "enhanced-to-Silver"
```

## Quality Checklist

- [ ] All missing components created
- [ ] MECE structure validated
- [ ] File naming conventions followed
- [ ] Examples are concrete and actionable
- [ ] References provide value-added context
- [ ] GraphViz diagrams are clear
- [ ] Resources are production-ready
- [ ] Tests cover key scenarios

## Success Criteria

**Tier Achievement**: Silver
- File count: 7+ files
- All required directories present
- Quality validation passes (≥85%)

