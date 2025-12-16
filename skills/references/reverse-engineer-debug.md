---
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
skill: reverse-engineer-debug
description: Perform systematic reverse engineering root cause analysis to debug issues and find real underlying problems
tags: [debugging, rca, root-cause-analysis, reverse-engineering, investigation, forensics]
version: 1.0.0
---



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

# Reverse Engineer Debug Skill

## Purpose
This skill performs deep reverse engineering root cause analysis (RCA) to debug complex issues, trace problems to their source, and identify the real underlying causes rather than surface symptoms.

## When to Use
- Debugging mysterious or intermittent bugs
- Investigating production incidents
- Analyzing system failures or crashes
- Finding root causes of performance issues
- Reverse engineering legacy code problems
- Tracing error propagation through systems
- Understanding why something broke after changes
- Investigating integration or deployment failures

## How It Works
This skill spawns a specialized **Root Cause Analyzer Agent** that:
1. Systematically collects symptoms and evidence
2. Works backwards from failure points to root causes
3. Generates and tests multiple hypotheses
4. Distinguishes symptoms from true root causes
5. Provides actionable solutions and prevention strategies

## Usage

### Basic Investigation
```
/reverse-engineer-debug
```
You'll be prompted to describe the issue, or you can provide it directly:

### With Issue Description
```
/reverse-engineer-debug "Users report timeout errors on checkout page after latest deployment"
```

### With Detailed Context
```
/reverse-engineer-debug "API returning 500 errors intermittently. Error: 'Cannot read property 'id' of undefined' in user service. Started after database migration yesterday. Affects ~10% of requests."
```

## Input Requirements

The skill works best when you provide:
- **Error Messages**: Exact error text and stack traces
- **Reproduction Steps**: How to trigger the issue
- **Context**: What changed recently (deployments, configs, dependencies)
- **Frequency**: How often it occurs and any patterns
- **Environment**: Where it happens (dev, staging, production)
- **Logs**: Relevant log excerpts if available

## Output

The agent provides a comprehensive RCA report including:
1. **Executive Summary**: Quick overview of problem and root cause
2. **Symptom Analysis**: All observable symptoms documented
3. **Investigation Trail**: Hypotheses tested and evidence collected
4. **Root Cause**: The real problem with technical explanation
5. **Solution Design**: How to fix it properly (not just workarounds)
6. **Validation Plan**: How to verify the fix works
7. **Prevention Strategy**: How to avoid this in the future
8. **Code References**: Specific file:line locations

## Examples

### Example 1: Production Error
```
Issue: "Application crashes with 'out of memory' error after running for 2-3 hours"

Agent finds:
- Root Cause: Memory leak in event listener registration
- Location: src/services/eventBus.js:45
- Problem: Event listeners added but never removed
- Solution: Implement cleanup in component unmount
- Prevention: Add memory profiling to CI/CD
```

### Example 2: Integration Failure
```
Issue: "Third-party API calls failing with 401 Unauthorized after token refresh"

Agent finds:
- Root Cause: Token expiry check uses local time, API expects UTC
- Location: src/auth/tokenManager.js:78
- Problem: Timezone mismatch causes premature expiry
- Solution: Use UTC for all time comparisons
- Prevention: Add timezone test cases
```

### Example 3: Performance Regression
```
Issue: "Dashboard load time increased from 2s to 30s after recent update"

Agent finds:
- Root Cause: N+1 query problem introduced in ORM migration
- Location: src/models/Dashboard.js:122
- Problem: Missing eager loading of related entities
- Solution: Add .include() to query with proper joins
- Prevention: Add performance benchmarks to test suite
```

## Advanced Features

### Multi-Layer Analysis
The agent analyzes multiple layers:
- **Code**: Logic errors, type issues, edge cases
- **System**: Resource contention, timing issues, race conditions
- **Integration**: API contracts, data formats, error handling
- **Environment**: Configuration, dependencies, infrastructure
- **Design**: Architectural flaws, missing requirements

### Forensic Techniques
- Stack trace dissection and call path analysis
- Dependency chain mapping and version conflict detection
- Timeline reconstruction of events leading to failure
- Differential analysis (working vs. broken versions)
- Environmental factor isolation

### Evidence-Based Investigation
- Generates multiple hypotheses
- Tests each with targeted experiments
- Rules out unlikely causes systematically
- Validates root cause explains ALL symptoms
- Provides clear evidence trail

## Best Practices

### Provide Complete Context
✅ Include error messages verbatim
✅ Describe reproduction steps clearly
✅ Mention recent changes (code, config, deploys)
✅ Note any patterns (time-based, load-based, etc.)
✅ Share relevant logs or stack traces

### Don't Pre-Diagnose
❌ Avoid "I think it's a memory leak"
✅ Instead: "App slows down over time and crashes"

Let the agent investigate objectively without bias.

### Follow Up Investigation
If the agent needs more information:
- Run suggested commands or tests
- Provide requested logs or configs
- Test hypotheses in your environment
- Verify findings and solutions

## Integration with SPARC

This skill complements SPARC workflows:
- **Debugging phase**: Find root causes before implementing fixes
- **Refinement phase**: Investigate test failures and edge cases
- **Code review**: Analyze potential issues before deployment
- **Post-deployment**: Investigate production incidents

## Technical Details

### Agent Type
`root-cause-analyzer` - Specialized investigative agent

### Capabilities
- File analysis and code tracing
- Log parsing and pattern recognition
- Hypothesis generation and testing
- Systematic elimination of causes
- Solution design and validation

### Tools Used
- Read, Grep, Glob for code examination
- Bash for environment inspection and testing
- Comparative analysis and differential debugging
- Memory and performance profiling guidance

## Troubleshooting

### Agent needs more context
Provide additional information requested:
- Run diagnostic commands suggested
- Share configuration files
- Provide more detailed logs
- Test specific scenarios

### Multiple root causes found
The agent will prioritize by:
- Impact on users
- Ease of reproduction
- Severity of consequences
- Order of occurrence

### Can't reproduce issue
Provide more details about:
- Specific environment (OS, versions, config)
- Data or state that triggers the issue
- Timing or load conditions
- External dependencies or services

## Related Skills

- `functionality-audit`: Validate code actually works
- `theater-detection-audit`: Find placeholder/incomplete code
- `style-audit`: Ensure code quality after fixes

## Success Indicators

✅ Root cause clearly identified with evidence
✅ Solution addresses cause, not symptoms
✅ Validation plan confirms fix works
✅ Prevention strategy prevents recurrence
✅ Investigation process documented

---

**Remember**: This skill finds THE REAL PROBLEM, not just surface symptoms. It's designed for thorough, systematic investigation when you need to truly understand what went wrong and how to fix it properly.
