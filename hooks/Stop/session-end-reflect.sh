#!/bin/bash
# Hook: Stop (session end) - Unix shell version
# Part of Loop 1.5 -> Loop 3 pipeline
#
# Triggers reflect_to_memory.py when session ends if:
# 1. reflect-enabled state file exists
# 2. Memory MCP scripts are available
#
# This hook stores session learnings to Memory MCP for
# aggregation by the 3-day meta-loop.

REFLECT_STATE_FILE="$HOME/.claude/reflect-enabled"
REFLECT_SCRIPT="D:/Projects/memory-mcp-triple-system/scripts/reflect_to_memory.py"
LEARNINGS_DIR="$HOME/.claude/reflect-output"

# Check if reflection is enabled
if [ ! -f "$REFLECT_STATE_FILE" ]; then
    # Reflection not enabled, skip silently
    exit 0
fi

# Check if script exists
if [ ! -f "$REFLECT_SCRIPT" ]; then
    echo "[reflect-hook] Warning: reflect_to_memory.py not found" >&2
    exit 0
fi

# Get session ID and project from environment or generate
SESSION_ID="${CLAUDE_SESSION_ID:-session_$(date +%Y%m%d_%H%M%S)}"
PROJECT="${MEMORY_MCP_PROJECT:-general}"

# Check for recent learnings file (created by /reflect skill)
RECENT_LEARNINGS=""
if [ -d "$LEARNINGS_DIR" ]; then
    RECENT_LEARNINGS=$(find "$LEARNINGS_DIR" -name "*.json" -mmin -30 -type f 2>/dev/null | sort -r | head -1)
fi

if [ -n "$RECENT_LEARNINGS" ]; then
    echo "[reflect-hook] Storing session learnings to Memory MCP..."

    if python "$REFLECT_SCRIPT" --session-id "$SESSION_ID" --project "$PROJECT" --from-file "$RECENT_LEARNINGS"; then
        echo "[reflect-hook] Learnings stored successfully"
        # Archive the processed file
        mv "$RECENT_LEARNINGS" "${RECENT_LEARNINGS}.processed"
    else
        echo "[reflect-hook] Warning: Failed to store learnings" >&2
    fi
else
    echo "[reflect-hook] No recent learnings to store"
fi

exit 0
