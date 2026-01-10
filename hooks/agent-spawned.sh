#!/bin/bash
# Hook: Triggered when an agent is spawned via Task tool
# Usage: Reports agent creation to dashboard
# Hierarchy Level 3: Project -> Skill -> AGENT -> Commands

AGENT_TYPE="${1:-}"
DESCRIPTION="${2:-}"
SKILL_NAME="${3:-}"
PROJECT_PATH="${4:-$PWD}"

DASHBOARD_API="http://localhost:8000/api/v1"
PROJECT_NAME=$(basename "$PROJECT_PATH")
AGENT_NAME="$AGENT_TYPE-$RANDOM"
STARTED_AT=$(date -Iseconds)

# Create agent record
RESPONSE=$(curl -s -X POST "$DASHBOARD_API/agents" \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"$AGENT_NAME\", \"type\": \"$AGENT_TYPE\", \"status\": \"busy\", \"description\": \"$DESCRIPTION\", \"project_name\": \"$PROJECT_NAME\", \"skill_name\": \"$SKILL_NAME\"}" \
    2>/dev/null)

if [ $? -eq 0 ]; then
    echo "Dashboard: Agent '$AGENT_TYPE' spawned for skill '$SKILL_NAME' in project '$PROJECT_NAME'"
else
    echo "Warning: Failed to report agent to dashboard" >&2
fi
