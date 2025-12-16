

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

# Intent Analyzer - Quick Start Guide
You are following structured enhancement instructions. Execute tasks sequentially with explicit validation gates. Document all modifications with clear rationale. Preserve existing functionality while implementing improvements. Use MECE principles for systematic coverage.
You are following structured enhancement instructions. Execute tasks sequentially with explicit validation gates. Document all modifications with clear rationale. Preserve existing functionality while implementing improvements. Use MECE principles for systematic coverage.

## Purpose
Advanced intent interpretation system that disambiguates user requests using cognitive science principles and probabilistic reasoning.

## When to Use
- Ambiguous or vague requests
- Complex multi-part instructions
- High-stakes decisions requiring clarity
- User may not know exactly what they need

## Quick Start

```bash
# Run intent analyzer skill
npx claude-flow@alpha skill-run intent-analyzer \
  --input "user-request.txt" \
  --output "/tmp/intent-brief.json"
```

## 5-Phase Process

1. **Capture Input** (2 min) - Gather request and context
2. **Decompose Intent** (5 min) - Break into components
3. **Map Probabilities** (5 min) - Rank interpretations
4. **Clarify Ambiguities** (10 min) - Ask targeted questions
5. **Synthesize Understanding** (8 min) - Create action plan

## Expected Output

```json
{
  "userIntent": {
    "original": "Create an API with security",
    "interpreted": "Build REST API with JWT authentication",
    "confidence": 0.87
  },
  "actionPlan": {
    "phases": ["Design schema", "Implement endpoints", "Add auth", "Test"],
    "agents": ["backend-dev", "security-reviewer", "tester"],
    "estimatedDuration": "4-6 hours"
  }
}
```

## Success Criteria
- Confidence score > 0.8
- User confirmation obtained
- Clear action plan generated
- Ready for execution handoff

## Common Use Cases
- **Before SPARC**: Clarify requirements before specification phase
- **Before Development**: Ensure clear understanding before coding
- **User Onboarding**: Help users articulate what they need

## Integration
```bash
# With SPARC
intent-analyzer → SPARC spec-pseudocode → implementation

# With Feature Development
intent-analyzer → feature-dev-complete

# Standalone
intent-analyzer → manual execution
```

## Tips
- Provide as much context as possible
- Answer clarifying questions thoughtfully
- Review interpretation before confirming
- Update if understanding changes

For detailed documentation, see SKILL.md
