# code-review

## Kanitsal Cerceve (Evidential Frame Activation)
Kaynak dogrulama modu etkin.



## Command Context
- GitHub API integration requirements: Requires GitHub CLI (gh) or GitHub API token for authentication
- Authentication/token requirements: Use GITHUB_TOKEN env var or gh auth login for GitHub operations
- Expected PR/issue/workflow outputs: JSON responses, PR/issue URLs, workflow run IDs, status codes
- Automation trigger conditions: Webhook events, schedule triggers, manual dispatch, PR/issue state changes
<!-- META-LOOP v2.1 INTEGRATION -->
## Phase 0: Expertise Loading
expertise_check:
  domain: deployment
  file: .claude/expertise/deployment.yaml
  fallback: discovery_mode

## Recursive Improvement Integration (v2.1)
benchmark: code-review-benchmark-v1
  tests:
    - github_integration_success
    - automation_validation
  success_threshold: 0.9
namespace: "commands/operations/github/code-review/{project}/{timestamp}"
uncertainty_threshold: 0.85
coordination:
  related_skills: [github-workflow-automation, github-release-management]
  related_agents: [github-actions-specialist, release-orchestration-agent]

## COMMAND COMPLETION VERIFICATION
success_metrics:
  execution_success: ">95%"
<!-- END META-LOOP -->


Automated code review with swarm intelligence.

## Usage
```bash
npx claude-flow github code-review [options]
```

## Options
- `--pr-number <n>` - Pull request to review
- `--focus <areas>` - Review focus (security, performance, style)
- `--suggest-fixes` - Suggest code fixes

## Examples
```bash
# Review PR
npx claude-flow github code-review --pr-number 456

# Security focus
npx claude-flow github code-review --pr-number 456 --focus security

# With fix suggestions
npx claude-flow github code-review --pr-number 456 --suggest-fixes
```


---
*Promise: `<promise>CODE_REVIEW_VERIX_COMPLIANT</promise>`*
