---
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
skill: codex-reasoning
description: Use GPT-5-Codex's specialized reasoning for alternative approaches and second opinions
tags: [codex, openai, gpt-5-codex, reasoning, alternative-solutions]
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

# Codex Reasoning Skill

## Purpose
Leverage OpenAI's GPT-5-Codex model (optimized for agentic coding) to get alternative reasoning approaches, second opinions, and specialized algorithmic solutions that complement Claude's perspective.

## Unique Capability
**What This Adds**: Different AI reasoning patterns. GPT-5-Codex is optimized for agentic coding workflows and may approach problems differently than Claude, providing valuable alternative perspectives and solutions.

## When to Use

### Perfect For:
✅ Getting a second opinion on architecture decisions
✅ Exploring alternative implementation approaches
✅ Algorithmic optimization problems
✅ When stuck on a problem (different perspective helps)
✅ Comparing solution approaches
✅ Code generation with different patterns
✅ Performance-critical implementations

### Don't Use When:
❌ Claude's solution is clearly working (no need for alternatives)
❌ Simple tasks that don't benefit from multiple perspectives
❌ When consistency with existing Claude-generated code matters more

## Usage

### Second Opinion
```
/codex-reasoning "I'm implementing user authentication. What's your approach?"
```

### Algorithm Optimization
```
/codex-reasoning "Optimize this sorting algorithm for large datasets with these constraints..."
```

### Alternative Architecture
```
/codex-reasoning "What's an alternative way to structure this microservices communication?"
```

## Why Use Both Models?

**Claude Strengths:**
- Deep reasoning and problem understanding
- Complex multi-step tasks
- Comprehensive documentation
- Reliability and error rate

**GPT-5-Codex Strengths:**
- Optimized for agentic coding
- Fast prototyping
- Different algorithmic approaches
- Good for one-shot prompting

**Together**: Get best of both worlds!

## Real Examples

### Example: Alternative Architecture
```
Claude suggests: Event-driven with message queue
Codex suggests: REST with polling + webhooks

Result: Hybrid approach combining benefits of both
```

### Example: Algorithm Optimization
```
Claude: Recursive solution with memoization
Codex: Iterative solution with lookup table

Result: Codex approach 2x faster for this use case
```

---

**Uses your ChatGPT Plus subscription.** Use `/model` in Codex to switch to GPT-5-Codex.

See `agents/codex-reasoning-agent.md` for details.
