#!/bin/bash
# Hook: Triggered when a skill is invoked
# Usage: Reports skill execution to dashboard
# Hierarchy Level 2: Project -> SKILL -> Agents -> Commands

SKILL_NAME="${1:-}"
PROJECT_PATH="${2:-$PWD}"

DASHBOARD_API="http://localhost:8000/api/v1"
PROJECT_NAME=$(basename "$PROJECT_PATH")

# Register/update project
curl -s -X POST "$DASHBOARD_API/projects" \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"$PROJECT_NAME\", \"status\": \"active\", \"project_type\": \"claude-code\"}" \
    >/dev/null 2>&1

# Register skill execution
STARTED_AT=$(date -Iseconds)
RESPONSE=$(curl -s -X POST "$DASHBOARD_API/skills" \
    -H "Content-Type: application/json" \
    -d "{\"project_name\": \"$PROJECT_NAME\", \"skill_name\": \"$SKILL_NAME\", \"status\": \"active\", \"started_at\": \"$STARTED_AT\"}" \
    2>/dev/null)

if [ $? -eq 0 ]; then
    echo "Dashboard: Skill '$SKILL_NAME' registered for project '$PROJECT_NAME'"
else
    echo "Warning: Failed to report skill to dashboard" >&2
fi
