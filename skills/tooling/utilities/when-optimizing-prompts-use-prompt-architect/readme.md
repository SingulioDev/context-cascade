

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

# Prompt Architect - Quick Start Guide
You are following structured enhancement instructions. Execute tasks sequentially with explicit validation gates. Document all modifications with clear rationale. Preserve existing functionality while implementing improvements. Use MECE principles for systematic coverage.
You are following structured enhancement instructions. Execute tasks sequentially with explicit validation gates. Document all modifications with clear rationale. Preserve existing functionality while implementing improvements. Use MECE principles for systematic coverage.

## Purpose
Evidence-based prompt engineering framework for creating and optimizing AI system prompts using proven techniques.

## When to Use
- Poor AI response quality
- Inconsistent outputs
- Creating new prompts
- Applying prompt engineering best practices

## Quick Start

```bash
# Optimize existing prompt
npx claude-flow@alpha skill-run prompt-architect \
  --input "original-prompt.md" \
  --output "optimized-prompt.md"
```

## 5-Phase Process

1. **Analyze Current** (5 min) - Identify weaknesses
2. **Structure Optimization** (10 min) - Reorganize logically
3. **Apply Techniques** (10 min) - Add evidence-based patterns
4. **Validate Effectiveness** (10 min) - A/B testing
5. **Refine Iteratively** (5 min) - Continuous improvement

## Evidence-Based Techniques Applied

- Chain-of-Thought reasoning
- Self-Consistency pattern
- ReAct (Reasoning + Acting)
- Few-Shot learning
- Constraint framing
- Progressive disclosure

## Expected Improvement

```
Average Score: +35%
Success Rate: +28%
Consistency: +42%
```

## Output Format

```json
{
  "original": "...",
  "optimized": "...",
  "improvements": {
    "scoreImprovement": "+35%",
    "successRate": "92%",
    "testsPassed": "5/5"
  }
}
```

## Common Use Cases
- **Agent Prompts**: Optimize system prompts for specialized agents
- **Task Instructions**: Improve task clarity and consistency
- **API Integration**: Create effective prompts for AI APIs
- **Skill Development**: Optimize skill instructions

For detailed documentation, see SKILL.md
