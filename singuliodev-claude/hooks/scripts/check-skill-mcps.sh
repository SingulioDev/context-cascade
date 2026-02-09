#!/bin/bash
# Check-Skill-MCPs.sh
# Validates that required MCPs are active for a given skill

SKILL_NAME="${1:-}"

# MCP dependency mapping (top skills)
# Bash associative arrays not available in all shells, using case statement
get_required_mcps() {
    case "$1" in
        "flow-nexus-platform") echo "flow-nexus" ;;
        "flow-nexus-swarm") echo "flow-nexus claude-flow" ;;
        "flow-nexus-neural") echo "flow-nexus" ;;
        "code-review-assistant") echo "claude-flow connascence-analyzer memory-mcp" ;;
        "sop-dogfooding-quality-detection") echo "claude-flow connascence-analyzer memory-mcp" ;;
        "sop-dogfooding-continuous-improvement") echo "claude-flow connascence-analyzer focused-changes memory-mcp" ;;
        "sop-code-review") echo "connascence-analyzer memory-mcp ruv-swarm" ;;
        "research-driven-planning") echo "claude-flow memory-mcp ruv-swarm" ;;
        "deep-research-orchestrator") echo "claude-flow memory-mcp" ;;
        "sparc-methodology") echo "claude-flow" ;;
        "agent-creator") echo "claude-flow memory-mcp" ;;
        "smart-bug-fix") echo "claude-flow flow-nexus memory-mcp" ;;
        "deployment-readiness") echo "claude-flow flow-nexus memory-mcp" ;;
        "github-code-review") echo "claude-flow ruv-swarm" ;;
        "swarm-advanced") echo "claude-flow ruv-swarm" ;;
        "agentdb-advanced") echo "agentdb" ;;
        "agentdb-learning") echo "agentdb" ;;
        "agentdb-vector-search") echo "agentdb" ;;
        *) echo "" ;;
    esac
}

# Read current .mcp.json
MCP_CONFIG_PATH="$HOME/.mcp.json"
ACTIVE_MCPS=""

if [ -f "$MCP_CONFIG_PATH" ]; then
    ACTIVE_MCPS=$(jq -r '.mcpServers | keys[]' "$MCP_CONFIG_PATH" 2>/dev/null | tr '\n' ' ')
fi

# Check if skill has MCP requirements
REQUIRED_MCPS=$(get_required_mcps "$SKILL_NAME")

if [ -n "$REQUIRED_MCPS" ]; then
    MISSING_MCPS=""

    for mcp in $REQUIRED_MCPS; do
        if ! echo "$ACTIVE_MCPS" | grep -qw "$mcp"; then
            MISSING_MCPS="$MISSING_MCPS $mcp"
        fi
    done

    if [ -n "$MISSING_MCPS" ]; then
        echo "!! MCP WARNING for skill: $SKILL_NAME !!"
        echo "Missing MCPs:$MISSING_MCPS"
        echo ""
        echo "To activate, run:"
        echo "  powershell -File C:/Users/17175/ADD-MCP.ps1 code-quality"
        echo "  (then restart Claude Desktop)"
        echo ""
    else
        echo "[OK] All required MCPs active for: $SKILL_NAME"
    fi
else
    echo "[INFO] Skill '$SKILL_NAME' has no special MCP requirements"
fi
