# workflow-export

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
benchmark: workflow-export-benchmark-v1
  tests:
    - command_execution_success
    - workflow_validation
  success_threshold: 0.9
namespace: "commands/delivery/workflows/workflow-export/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [deployment-readiness, cicd-intelligent-recovery]
  related_agents: [cicd-engineer, tester]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->


Export workflows for sharing.

## Usage
```bash
npx claude-flow workflow export [options]
```

## Options
- `--name <name>` - Workflow to export
- `--format <type>` - Export format
- `--include-history` - Include execution history

## Examples
```bash
# Export workflow
npx claude-flow workflow export --name "deploy-api"

# As YAML
npx claude-flow workflow export --name "test-suite" --format yaml

# With history
npx claude-flow workflow export --name "deploy-api" --include-history
```
