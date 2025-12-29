# workflow-select

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.



## Command Context
- GitHub API integration requirements: May require GitHub CLI or API for repository operations and workflow management
- Authentication/token requirements: GITHUB_TOKEN for API access, service account credentials for automated operations
- Expected PR/issue/workflow outputs: Automation logs, agent spawn confirmations, workflow execution results, health check statuses
- Automation trigger conditions: System events, threshold violations, scheduled intervals, manual triggers, agent lifecycle events
<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: deployment
  file: .claude/expertise/deployment.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: workflow-select-benchmark-v1
  tests:
    - github_integration_success
    - automation_validation
  success_threshold: 0.9
namespace: "commands/operations/automation/workflow-select/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [github-workflow-automation, github-release-management]
  related_agents: [github-actions-specialist, release-orchestration-agent]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->


Automatically select optimal workflow based on task type.

## Usage
```bash
npx claude-flow automation workflow-select [options]
```

## Options
- `--task <description>` - Task description
- `--constraints <list>` - Workflow constraints
- `--preview` - Preview without executing

## Examples
```bash
# Select workflow for task
npx claude-flow automation workflow-select --task "Deploy to production"

# With constraints
npx claude-flow automation workflow-select --constraints "no-downtime,rollback"

# Preview mode
npx claude-flow automation workflow-select --task "Database migration" --preview
```


---
*Promise: `<promise>WORKFLOW_SELECT_VERIX_COMPLIANT</promise>`*
