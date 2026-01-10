#!/bin/bash
# Hook: Triggered when a slash command or tool is executed
# Usage: Reports command execution to dashboard
# Hierarchy Level 4: Project -> Skill -> Agent -> COMMAND

COMMAND_TYPE="${1:-}"   # "slash_command" or "tool"
COMMAND_NAME="${2:-}"   # "/review-pr" or "Bash"
COMMAND_ARGS="${3:-}"
AGENT_NAME="${4:-claude-code}"
PROJECT_PATH="${5:-$PWD}"

DASHBOARD_API="http://localhost:8000/api/v1"
PROJECT_NAME=$(basename "$PROJECT_PATH")
STARTED_AT=$(date -Iseconds)

# Register command execution
RESPONSE=$(curl -s -X POST "$DASHBOARD_API/commands" \
    -H "Content-Type: application/json" \
    -d "{\"command_type\": \"$COMMAND_TYPE\", \"command_name\": \"$COMMAND_NAME\", \"command_args\": \"$COMMAND_ARGS\", \"agent_name\": \"$AGENT_NAME\", \"project_name\": \"$PROJECT_NAME\", \"status\": \"running\", \"started_at\": \"$STARTED_AT\"}" \
    2>/dev/null)

if [ $? -eq 0 ]; then
    echo "Dashboard: Command '$COMMAND_NAME' executing in project '$PROJECT_NAME'"
else
    echo "Warning: Failed to report command to dashboard" >&2
fi
