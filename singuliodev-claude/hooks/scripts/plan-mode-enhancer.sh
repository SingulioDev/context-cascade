#!/bin/bash
# plan-mode-enhancer.sh
# Hook: UserPromptSubmit
# Purpose: Enhance plan mode with ultrathink and sequential-thinking MCP
#
# Detects plan mode and injects requirements for:
# 1. Extended thinking via <ultrathink> tag
# 2. Sequential-thinking MCP server usage

# Read input from stdin (Claude Code sends JSON with session info)
INPUT_JSON=$(cat 2>/dev/null || echo "{}")
if [ -z "$INPUT_JSON" ]; then
    INPUT_JSON="{}"
fi

# Extract permission_mode and prompt from input
PERMISSION_MODE=$(echo "$INPUT_JSON" | jq -r '.session.permission_mode // .permission_mode // empty' 2>/dev/null)
PROMPT_TEXT=$(echo "$INPUT_JSON" | jq -r '.prompt // empty' 2>/dev/null)

IS_PLANNING=false

# Detect plan mode via permission_mode field
if [ "$PERMISSION_MODE" = "plan" ]; then
    IS_PLANNING=true
fi

# Also detect if user explicitly invoked plan mode or planning keywords
if echo "$PROMPT_TEXT" | grep -iqE "(plan mode|/plan|planning phase|design phase|architecture|strategy)"; then
    IS_PLANNING=true
fi

# If in plan mode, inject enhancement requirements
if [ "$IS_PLANNING" = true ]; then
    cat << 'EOF'

================================================================
!! PLAN MODE ENHANCEMENT ACTIVE !!
================================================================

REQUIRED ENHANCEMENTS FOR PLAN MODE:

1. ULTRATHINK ACTIVATION (AUTO-ENABLED)
   --------------------------------------
   Extended thinking mode is now ACTIVE via the ultrathink keyword.

   You MUST engage deep reasoning for this planning task:
   - Consider ALL angles and edge cases
   - Evaluate trade-offs explicitly
   - Map dependencies and risks
   - Generate multiple alternatives before deciding

   ultrathink

2. SEQUENTIAL-THINKING MCP REQUIRED
   ---------------------------------
   You MUST use the sequential-thinking MCP server for planning:

   mcp__sequential-thinking__sequentialthinking({
     "thought": "Current reasoning step",
     "nextThoughtNeeded": true/false,
     "thoughtNumber": N,
     "totalThoughts": estimated_total
   })

   Use this for:
   - Breaking down complex problems
   - Exploring decision trees
   - Validating architectural choices
   - Risk assessment chains

3. COMBINED PATTERN
   -----------------
   <ultrathink>
   [Initial deep analysis]
   </ultrathink>

   Then call sequential-thinking for structured exploration:
   - Thought 1: Problem decomposition
   - Thought 2: Constraint identification
   - Thought 3: Option generation
   - Thought 4: Trade-off analysis
   - Thought 5: Risk assessment
   - Thought 6: Final recommendation

================================================================
REMEMBER: Plan mode = Maximum reasoning depth
          No shortcuts. No assumptions. Full analysis.
================================================================

EOF
fi

# Always exit 0 (informational only, never block)
exit 0
