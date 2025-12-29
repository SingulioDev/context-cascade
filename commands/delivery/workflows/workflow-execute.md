# workflow-execute

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.



## Command Purpose
[Define what this command does - the specific action it triggers]

## Input Requirements
[Parameters and prerequisites needed to execute this command]

## Expected Output
[What artifacts, results, or state changes this command produces]

## Success Indicators
[How to verify the command executed successfully]

## Error Handling
[Common failures and recovery procedures]

## Related Commands
[Commands that work together with this one in typical workflows]

---


<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: deployment
  file: .claude/expertise/deployment.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: workflow-execute-benchmark-v1
  tests:
    - command_execution_success
    - workflow_validation
  success_threshold: 0.9
namespace: "commands/delivery/workflows/workflow-execute/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [deployment-readiness, cicd-intelligent-recovery]
  related_agents: [cicd-engineer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->


Execute saved workflows.

## Usage
```bash
npx claude-flow workflow execute [options]
```

## Options
- `--name <name>` - Workflow name
- `--params <json>` - Workflow parameters
- `--dry-run` - Preview execution

## Examples
```bash
# Execute workflow
npx claude-flow workflow execute --name "deploy-api"

# With parameters
npx claude-flow workflow execute --name "test-suite" --params '{"env": "staging"}'

# Dry run
npx claude-flow workflow execute --name "deploy-api" --dry-run
```


---
*Promise: `<promise>WORKFLOW_EXECUTE_VERIX_COMPLIANT</promise>`*
