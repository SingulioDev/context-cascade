---
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
You are executing a specialized skill with domain expertise. Apply evidence-based prompting techniques: plan-and-solve decomposition, program-of-thought reasoning, and self-consistency validation. Prioritize systematic execution over ad-hoc solutions. Validate outputs against success criteria before proceeding.
skill: gemini-extensions
description: Access Gemini's 70+ extensions ecosystem including Figma, Stripe, Postman, Shopify
tags: [gemini, extensions, figma, stripe, integrations, third-party]
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

# Gemini Extensions Skill

## Purpose
Leverage Gemini CLI's ecosystem of 70+ extensions to integrate with Figma, Stripe, Postman, Shopify, and other third-party services that Claude Code cannot directly access.

## Unique Capability
**What Claude Code Can't Do**: Direct integration with design tools (Figma), payment APIs (Stripe), API testing (Postman), e-commerce (Shopify), and 70+ other extensions. Gemini CLI provides native integrations via its extension system.

## When to Use

### Perfect For:
✅ Extracting designs from Figma and generating code
✅ Testing Stripe payment integrations
✅ Running Postman API collections
✅ Querying Shopify store data
✅ Accessing Dynatrace, Elastic, Snyk, Harness data
✅ Any task requiring third-party tool integration

### Available Extensions:
- **Figma**: Extract frames, components, design tokens → generate code
- **Stripe**: Test APIs, query payment data, validate integrations
- **Postman**: Run collections, test endpoints, validate APIs
- **Shopify**: Query products, orders, customer data
- **Dynatrace**: Performance monitoring data
- **Elastic**: Search and analytics queries
- **Snyk**: Security vulnerability scanning
- **Harness**: CD pipeline integration

Plus 60+ community extensions on GitHub.

## Usage

```bash
# Install extension
/gemini-extensions --install figma

# Use Figma
/gemini-extensions "Extract components from Figma frame XYZ and generate React code"

# Use Stripe
/gemini-extensions "Test Stripe payment intent creation with test card"

# Use Postman
/gemini-extensions "Run the 'User API' Postman collection and report results"
```

## Real Examples

### Figma → Code
```
/gemini-extensions "Extract button component from Figma frame 'Components/Buttons' and generate React component with TypeScript and styled-components"
```

### Stripe Testing
```
/gemini-extensions "Create a test payment intent for $50 USD using Stripe test API, verify webhook firing"
```

### API Testing
```
/gemini-extensions "Run my Postman collection 'API Tests v2' and identify any failing endpoints"
```

---

**See full documentation** in `agents/gemini-extensions-agent.md`
