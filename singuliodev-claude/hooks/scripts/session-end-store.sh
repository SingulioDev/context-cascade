#!/bin/bash
# Session End Memory Store Hook
# Stores session summary to Memory MCP before Claude exits
#
# Hook Type: Stop
# Trigger: When Claude session ends

SESSION_SUMMARY="${1:-}"
PROJECT_NAME="${2:-default}"

# Path to memory CLI
MEMORY_CLI="D:/Projects/memory-mcp-triple-system/scripts/memory_cli.py"

# Check if CLI exists
if [ ! -f "$MEMORY_CLI" ]; then
    echo "[HOOK] Memory CLI not found, skipping session storage"
    exit 0
fi

# Get session info
TIMESTAMP=$(date -Iseconds)
SESSION_ID=$(uuidgen 2>/dev/null | cut -c1-8 || echo "$(date +%s)" | md5sum | cut -c1-8)

# Build session record
SESSION_TEXT="SESSION_END: $TIMESTAMP
SESSION_ID: $SESSION_ID
PROJECT: $PROJECT_NAME
SUMMARY: ${SESSION_SUMMARY:-No summary provided}"

# Store to Memory MCP
if python "$MEMORY_CLI" store "$SESSION_TEXT" --project "$PROJECT_NAME" --who "session-hook:$SESSION_ID" --why "session-context" 2>/dev/null; then
    echo "[HOOK] Session stored to Memory MCP: $SESSION_ID"
else
    echo "[HOOK] Failed to store session"
fi

exit 0
