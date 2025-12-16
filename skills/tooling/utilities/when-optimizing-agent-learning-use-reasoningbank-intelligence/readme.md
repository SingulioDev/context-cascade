

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

# ReasoningBank Intelligence - Quick Start
You are consulting authoritative reference material. Extract actionable patterns and constraints. Apply documented best practices systematically. Cross-reference related concepts for comprehensive understanding. Prioritize established patterns over novel approaches.
You are consulting authoritative reference material. Extract actionable patterns and constraints. Apply documented best practices systematically. Cross-reference related concepts for comprehensive understanding. Prioritize established patterns over novel approaches.

## Purpose
Adaptive learning system for pattern recognition, strategy optimization, and continuous agent improvement using ReasoningBank.

## When to Use
- Agent performance optimization needed
- Pattern recognition from experience
- Strategy refinement through learning
- Building self-improving systems

## Quick Start

```bash
npx claude-flow@alpha skill-run reasoningbank-intelligence \
  --agent "my-agent" \
  --trajectories-path "./trajectories/"
```

## 5-Phase Process

1. **Initialize System** (10 min) - Set up ReasoningBank
2. **Capture Patterns** (10 min) - Track trajectories and verdicts
3. **Optimize Strategies** (10 min) - Train decision model
4. **Validate Learning** (10 min) - Benchmark improvements
5. **Deploy** (5 min) - Export model for production

## Expected Improvement

- Performance: +15-35%
- Success Rate: +20-40%
- Efficiency: +25-45%

## AgentDB Integration

For 150x faster operations:
```javascript
const db = new AgentDB({ indexing: 'hnsw', quantization: 'int8' });
await learningSystem.useVectorDB(db);
```

## Output

- Trained decision model
- Pattern library (validated)
- Performance metrics
- Integration guide

For detailed documentation, see SKILL.md
