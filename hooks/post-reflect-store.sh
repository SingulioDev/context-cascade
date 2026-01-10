#!/bin/bash
# Hook: Post-Reflect Store - Unix shell version
# Triggers after /reflect skill completes to store learnings
#
# This hook is designed to be called after the reflect skill outputs
# a JSON learnings file to the reflect-output directory.

LEARNINGS_FILE="${1:-}"
SESSION_ID="${2:-}"
PROJECT="${3:-general}"

REFLECT_SCRIPT="D:/Projects/memory-mcp-triple-system/scripts/reflect_to_memory.py"
LEARNINGS_DIR="$HOME/.claude/reflect-output"

# Ensure learnings directory exists
mkdir -p "$LEARNINGS_DIR"

# Generate session ID if not provided
if [ -z "$SESSION_ID" ]; then
    SESSION_ID="session_$(date +%Y%m%d_%H%M%S)"
fi

# If no specific file provided, find most recent
if [ -z "$LEARNINGS_FILE" ] || [ ! -f "$LEARNINGS_FILE" ]; then
    LEARNINGS_FILE=$(find "$LEARNINGS_DIR" -name "*.json" -type f 2>/dev/null | sort -r | head -1)
fi

if [ -z "$LEARNINGS_FILE" ]; then
    echo "[post-reflect] No learnings file found"
    exit 0
fi

echo "=============================================="
echo "Post-Reflect Memory Storage"
echo "=============================================="
echo "Session ID: $SESSION_ID"
echo "Project: $PROJECT"
echo "Learnings: $LEARNINGS_FILE"
echo ""

# Run the reflect_to_memory.py script
if python "$REFLECT_SCRIPT" --session-id "$SESSION_ID" --project "$PROJECT" --from-file "$LEARNINGS_FILE"; then
    echo ""
    echo "[post-reflect] SUCCESS: Learnings stored to Memory MCP"

    # Archive the processed file
    ARCHIVE_DIR="$LEARNINGS_DIR/archive"
    mkdir -p "$ARCHIVE_DIR"
    BASENAME=$(basename "$LEARNINGS_FILE" .json)
    mv "$LEARNINGS_FILE" "$ARCHIVE_DIR/${BASENAME}-$(date +%Y%m%d_%H%M%S).json"
else
    echo "[post-reflect] FAILED: Could not store learnings" >&2
    exit 1
fi

exit 0
