#!/usr/bin/env bash
# migrate-to-singuliodev.sh - Migrate Context Cascade into singuliodev-claude plugin
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"
PLUGIN="$ROOT/singuliodev-claude"
STRIP_VCL="$SCRIPT_DIR/strip-vcl.sh"

echo "=== Context Cascade -> singuliodev-claude Migration ==="
echo "Source: $ROOT"
echo "Target: $PLUGIN"
echo ""

# ============================================================
# Step 1: Create scaffold
# ============================================================
echo "[1/10] Creating plugin scaffold..."
mkdir -p "$PLUGIN/.claude-plugin"
mkdir -p "$PLUGIN/skills"
mkdir -p "$PLUGIN/agents"
mkdir -p "$PLUGIN/commands"
mkdir -p "$PLUGIN/hooks/scripts"
mkdir -p "$PLUGIN/docs"
mkdir -p "$PLUGIN/scripts"

# ============================================================
# Step 2: plugin.json
# ============================================================
echo "[2/10] Writing plugin.json..."
cat > "$PLUGIN/.claude-plugin/plugin.json" << 'PJSON'
{
  "name": "singuliodev-claude",
  "version": "4.0.0",
  "description": "Cognitive architecture plugin with skills, agents, SPARC methodology, and multi-agent swarm coordination",
  "author": {
    "name": "DNYoussef",
    "url": "https://github.com/DNYoussef"
  },
  "license": "Apache-2.0",
  "keywords": ["sparc", "swarm", "agents", "skills", "cognitive-architecture"]
}
PJSON

# ============================================================
# Step 3: Migrate skills (251 -> ~175)
# ============================================================
echo "[3/10] Migrating skills..."

SKILL_COUNT=0
WHEN_COUNT=0
SKIP_COUNT=0
COLLISION_COUNT=0

# Track seen skill names for collision detection
declare -A SEEN_SKILLS
declare -A SKILL_SIZES

# First pass: collect all non-when skills and their sizes
while IFS= read -r skill_md; do
  skill_dir="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_dir")"

  # Skip when-* skills
  if [[ "$skill_name" == when-* ]]; then
    continue
  fi

  # Skip packaged/temp skills
  if [[ "$skill_dir" == *"/packaged/"* ]]; then
    continue
  fi

  size=$(wc -c < "$skill_md")

  if [ -n "${SEEN_SKILLS[$skill_name]+x}" ]; then
    # Collision: keep whichever is larger
    prev_size="${SKILL_SIZES[$skill_name]}"
    if [ "$size" -gt "$prev_size" ]; then
      SEEN_SKILLS[$skill_name]="$skill_dir"
      SKILL_SIZES[$skill_name]="$size"
    fi
    COLLISION_COUNT=$((COLLISION_COUNT + 1))
  else
    SEEN_SKILLS[$skill_name]="$skill_dir"
    SKILL_SIZES[$skill_name]="$size"
  fi
done < <(find "$ROOT/skills" -name "SKILL.md" -not -path "*/when-*")

# Second pass: copy winners
for skill_name in "${!SEEN_SKILLS[@]}"; do
  src_dir="${SEEN_SKILLS[$skill_name]}"
  dst_dir="$PLUGIN/skills/$skill_name"
  mkdir -p "$dst_dir"
  cp "$src_dir/SKILL.md" "$dst_dir/SKILL.md"

  # Strip VCL
  "$STRIP_VCL" "$dst_dir/SKILL.md"

  SKILL_COUNT=$((SKILL_COUNT + 1))
done

echo "  Skills copied: $SKILL_COUNT (resolved $COLLISION_COUNT collisions)"

# Third pass: convert when-* triggers into target skill frontmatter
echo "  Processing when-* trigger skills..."
while IFS= read -r skill_md; do
  skill_dir="$(dirname "$skill_md")"
  when_name="$(basename "$skill_dir")"
  WHEN_COUNT=$((WHEN_COUNT + 1))

  # Parse trigger phrase from directory name
  # Pattern: when-<trigger>-use-<target>
  # Extract trigger and target
  trigger_phrase=$(echo "$when_name" | sed 's/^when-//' | sed 's/-use-.*$//' | tr '-' ' ')
  target_skill=$(echo "$when_name" | sed 's/.*-use-//' | tr '-' ' ')
  target_dir=$(echo "$when_name" | sed 's/.*-use-//')

  # Find matching skill in plugin
  if [ -d "$PLUGIN/skills/$target_dir" ]; then
    target_file="$PLUGIN/skills/$target_dir/SKILL.md"
    # Check if triggers: already exists in frontmatter
    if ! grep -q "^triggers:" "$target_file" 2>/dev/null; then
      # Add triggers field after tags block in frontmatter
      sed -i "/^tags:/,/^[a-z]/ {
        /^[a-z]/ {
          /^tags:/! i\\
triggers:\\
  - \"when $trigger_phrase\"
        }
      }" "$target_file"
    else
      # Append to existing triggers
      sed -i "/^triggers:/a\\  - \"when $trigger_phrase\"" "$target_file"
    fi
  fi
done < <(find "$ROOT/skills" -name "SKILL.md" -path "*/when-*")

echo "  When-* triggers processed: $WHEN_COUNT"

# ============================================================
# Step 4: Migrate agents (260 -> ~224)
# ============================================================
echo "[4/10] Migrating agents..."

AGENT_COUNT=0
AGENT_COLLISION=0
declare -A SEEN_AGENTS
declare -A AGENT_SIZES

# Prefix mapping for known collision groups
declare -A PREFIX_MAP
PREFIX_MAP[delivery/sparc/architecture]="sparc"
PREFIX_MAP[delivery/sparc/pseudocode]="sparc"
PREFIX_MAP[delivery/sparc/refinement]="sparc"
PREFIX_MAP[delivery/sparc/specification]="sparc"

# Collect all agent files
while IFS= read -r agent_md; do
  base_name="$(basename "$agent_md" .md)"
  rel_path="${agent_md#$ROOT/agents/}"
  size=$(wc -c < "$agent_md")

  # Determine final name with prefix for known groups
  final_name="$base_name"

  # Check if this is a root-level file vs category file
  dir_part="$(dirname "$rel_path")"

  if [ "$dir_part" = "." ]; then
    # Root-level agent
    is_root=true
  else
    is_root=false

    # Apply prefix rules for specific collision groups
    case "$dir_part" in
      */sparc|delivery/sparc)
        if [[ "$base_name" =~ ^(architecture|pseudocode|refinement|specification)$ ]]; then
          final_name="sparc-$base_name"
        fi
        ;;
      */consensus|orchestration/consensus)
        if [[ "$base_name" =~ ^(byzantine-coordinator|crdt-synchronizer|gossip-coordinator|quorum-manager|raft-manager|performance-benchmarker|security-manager)$ ]]; then
          final_name="consensus-$base_name"
        fi
        ;;
      */swarm-topologies|orchestration/swarm-topologies)
        if [[ "$base_name" =~ ^(adaptive-coordinator|hierarchical-coordinator|mesh-coordinator)$ ]]; then
          final_name="swarm-$base_name"
        fi
        ;;
      */hive-mind|orchestration/hive-mind)
        if [[ "$base_name" =~ ^(collective-intelligence-coordinator|queen-coordinator|scout-explorer|swarm-memory-manager|worker-specialist)$ ]]; then
          final_name="hive-$base_name"
        fi
        ;;
      */github|orchestration/github)
        if [[ "$base_name" =~ ^(code-review-swarm|multi-repo-swarm)$ ]]; then
          final_name="github-$base_name"
        fi
        ;;
      */flow-nexus|platforms/flow-nexus)
        if [[ "$base_name" =~ ^(codex-auto-agent|gemini-search-agent)$ ]]; then
          final_name="flow-nexus-$base_name"
        fi
        ;;
      quality/*)
        if [ "$base_name" = "production-validator" ]; then
          final_name="quality-$base_name"
        fi
        ;;
      research/reasoning)
        if [ "$base_name" = "goal-planner" ]; then
          final_name="research-$base_name"
        fi
        ;;
    esac
  fi

  if [ -n "${SEEN_AGENTS[$final_name]+x}" ]; then
    # Collision
    prev_size="${AGENT_SIZES[$final_name]}"
    prev_root="${SEEN_AGENTS[$final_name]%%|*}"

    if [ "$is_root" = true ] && [ "$prev_root" = false ]; then
      # Root collides with category: keep category (richer)
      AGENT_COLLISION=$((AGENT_COLLISION + 1))
      continue
    elif [ "$is_root" = false ] && [ "$prev_root" = true ]; then
      # Category replaces root
      SEEN_AGENTS[$final_name]="$is_root|$agent_md"
      AGENT_SIZES[$final_name]="$size"
      AGENT_COLLISION=$((AGENT_COLLISION + 1))
      continue
    fi

    # Same level: keep larger
    if [ "$size" -gt "$prev_size" ]; then
      SEEN_AGENTS[$final_name]="$is_root|$agent_md"
      AGENT_SIZES[$final_name]="$size"
    fi
    AGENT_COLLISION=$((AGENT_COLLISION + 1))
  else
    SEEN_AGENTS[$final_name]="$is_root|$agent_md"
    AGENT_SIZES[$final_name]="$size"
  fi
done < <(find "$ROOT/agents" -name "*.md" ! -name "README.md")

# Copy winners
for final_name in "${!SEEN_AGENTS[@]}"; do
  src_file="${SEEN_AGENTS[$final_name]#*|}"
  cp "$src_file" "$PLUGIN/agents/$final_name.md"

  # Strip VCL from agents
  "$STRIP_VCL" "$PLUGIN/agents/$final_name.md"

  AGENT_COUNT=$((AGENT_COUNT + 1))
done

echo "  Agents copied: $AGENT_COUNT (resolved $AGENT_COLLISION collisions)"

# ============================================================
# Step 5: Migrate commands (249 -> ~20)
# ============================================================
echo "[5/10] Creating minimal commands..."

# Extract LEARNED PATTERNS from commands into corresponding skills
echo "  Extracting LEARNED PATTERNS from commands..."
LEARNED_COUNT=0

while IFS= read -r cmd_md; do
  cmd_name="$(basename "$cmd_md" .md)"

  # Check if command has LEARNED PATTERNS
  if grep -q "LEARNED PATTERNS" "$cmd_md" 2>/dev/null; then
    # Extract the LEARNED PATTERNS section
    learned=$(sed -n '/### LEARNED PATTERNS/,/^### [^L]/p' "$cmd_md" | head -n -1)
    if [ -n "$learned" ]; then
      # Find matching skill
      for skill_dir in "$PLUGIN/skills"/*/; do
        skill_name="$(basename "$skill_dir")"
        # Match command name to skill (try exact, then partial)
        if [ "$cmd_name" = "$skill_name" ] || echo "$cmd_name" | grep -q "$skill_name"; then
          echo "" >> "$skill_dir/SKILL.md"
          echo "$learned" >> "$skill_dir/SKILL.md"
          LEARNED_COUNT=$((LEARNED_COUNT + 1))
          break
        fi
      done
    fi
  fi
done < <(find "$ROOT/commands" -name "*.md" ! -name "README.md" ! -name "VERIX-COMMAND-TEMPLATE.md")

echo "  LEARNED PATTERNS extracted: $LEARNED_COUNT"

# Create essential user-invocable commands
declare -A COMMANDS
COMMANDS[build-feature]="Build a complete feature using the feature development workflow"
COMMANDS[fix-bug]="Fix a bug using systematic debugging methodology"
COMMANDS[code]="Implement code changes with best practices"
COMMANDS[debug]="Debug and troubleshoot code issues"
COMMANDS[code-review]="Review code for quality, security, and best practices"
COMMANDS[architect]="Design system architecture and technical plans"
COMMANDS[tester]="Write and run comprehensive tests"
COMMANDS[reviewer]="Review and improve code quality"
COMMANDS[reflect]="Reflect on session learnings and extract patterns"
COMMANDS[reflect-status]="Check reflection state and history"
COMMANDS[reflect-on]="Enable auto-reflection on session end"
COMMANDS[reflect-off]="Disable auto-reflection"
COMMANDS[sparc]="Execute SPARC methodology workflow"
COMMANDS[deep-research]="Run deep multi-pipeline research"
COMMANDS[swarm-init]="Initialize a multi-agent swarm"
COMMANDS[cascade-orchestrator]="Orchestrate multi-skill pipelines"
COMMANDS[deploy-check]="Validate deployment readiness"
COMMANDS[security-review]="Run security analysis and vulnerability checks"
COMMANDS[performance-analysis]="Analyze and optimize performance"
COMMANDS[improve]="Improve and refactor existing code"

for cmd in "${!COMMANDS[@]}"; do
  desc="${COMMANDS[$cmd]}"
  cat > "$PLUGIN/commands/$cmd.md" << EOF
---
description: $desc
---

$desc for: \$ARGUMENTS
EOF
done

echo "  Commands created: ${#COMMANDS[@]}"

# ============================================================
# Step 6: Migrate hooks
# ============================================================
echo "[6/10] Creating hooks..."

# Copy kept .sh scripts
HOOK_SCRIPTS_KEPT=0

declare -A HOOK_COPIES
HOOK_COPIES[plan-mode-enhancer]="$ROOT/hooks/enforcement/plan-mode-enhancer.sh"
HOOK_COPIES[five-phase-enforcer]="$ROOT/hooks/five-phase-enforcer.sh"
HOOK_COPIES[skill-router-hook]="$ROOT/hooks/skill-router-hook.sh"
HOOK_COPIES[check-skill-mcps]="$ROOT/hooks/check-skill-mcps.sh"
HOOK_COPIES[pre-task-memory-check]="$ROOT/hooks/memory-mcp/pre-task-memory-check.sh"
HOOK_COPIES[model-router-pretool]="$ROOT/hooks/multi-model/model-router-pretool.sh"
HOOK_COPIES[post-task-memory-store]="$ROOT/hooks/memory-mcp/post-task-memory-store.sh"
HOOK_COPIES[run-audit]="$ROOT/hooks/connascence-audit/run-audit.sh"
HOOK_COPIES[pattern-retention-precompact]="$ROOT/hooks/pattern-retention-precompact.sh"
HOOK_COPIES[session-end-reflect]="$ROOT/hooks/Stop/session-end-reflect.sh"
HOOK_COPIES[session-end-store]="$ROOT/hooks/memory-mcp/session-end-store.sh"
HOOK_COPIES[mcp-session-cleanup]="$ROOT/hooks/mcp-session-cleanup.sh"
HOOK_COPIES[ralph-loop-stop-hook]="$ROOT/hooks/ralph-wiggum/ralph-loop-stop-hook.sh"
HOOK_COPIES[recursive-improvement-gate]="$ROOT/hooks/recursive-improvement-gate.sh"
HOOK_COPIES[session-start-plugin-check]="$ROOT/hooks/session-start-plugin-check.sh"
HOOK_COPIES[memory-trigger-patterns]="$ROOT/hooks/memory-mcp/memory-trigger-patterns.sh"

for hook_name in "${!HOOK_COPIES[@]}"; do
  src="${HOOK_COPIES[$hook_name]}"
  if [ -f "$src" ]; then
    cp "$src" "$PLUGIN/hooks/scripts/$hook_name.sh"
    chmod +x "$PLUGIN/hooks/scripts/$hook_name.sh"

    # Clean Windows paths from hook scripts
    sed -i 's|C:\\Users\\[^"]*||g' "$PLUGIN/hooks/scripts/$hook_name.sh"
    sed -i 's|D:\\Projects\\[^"]*||g' "$PLUGIN/hooks/scripts/$hook_name.sh"
    sed -i 's|powershell -ExecutionPolicy Bypass -File ||g' "$PLUGIN/hooks/scripts/$hook_name.sh"

    HOOK_SCRIPTS_KEPT=$((HOOK_SCRIPTS_KEPT + 1))
  else
    echo "  WARNING: Hook script not found: $src"
  fi
done

echo "  Hook scripts copied: $HOOK_SCRIPTS_KEPT"

# Generate hooks.json (bash-based)
cat > "$PLUGIN/hooks/hooks.json" << 'HJSON'
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/plan-mode-enhancer.sh\"",
            "timeout": 30000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/five-phase-enforcer.sh\"",
            "timeout": 30000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/skill-router-hook.sh\"",
            "timeout": 15000
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Skill",
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/check-skill-mcps.sh\"",
            "timeout": 30000
          }
        ]
      },
      {
        "matcher": "Task",
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/pre-task-memory-check.sh\"",
            "timeout": 120000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/model-router-pretool.sh\"",
            "timeout": 15000
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Task",
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/post-task-memory-store.sh\"",
            "timeout": 60000
          }
        ]
      },
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/run-audit.sh\"",
            "timeout": 300000
          }
        ]
      }
    ],
    "PreCompact": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/pattern-retention-precompact.sh\"",
            "timeout": 120000
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/session-end-reflect.sh\"",
            "timeout": 300000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/ralph-loop-stop-hook.sh\"",
            "timeout": 120000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/session-end-store.sh\"",
            "timeout": 120000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/recursive-improvement-gate.sh\"",
            "timeout": 60000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/mcp-session-cleanup.sh\"",
            "timeout": 30000
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/session-start-plugin-check.sh\"",
            "timeout": 15000
          },
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks/scripts/memory-trigger-patterns.sh\"",
            "timeout": 30000
          }
        ]
      }
    ]
  }
}
HJSON

echo "  hooks.json created with $(grep -c '"command":' "$PLUGIN/hooks/hooks.json") hook bindings"

# ============================================================
# Step 7: Copy essential documentation
# ============================================================
echo "[7/10] Copying documentation..."

DOC_COUNT=0
for doc in AGENT-SUBAGENT-MAPPING.md MULTI-MODEL-INVOCATION-GUIDE.md COGNITIVE-ARCHITECTURE.md; do
  if [ -f "$ROOT/docs/$doc" ]; then
    cp "$ROOT/docs/$doc" "$PLUGIN/docs/$doc"
    DOC_COUNT=$((DOC_COUNT + 1))
  fi
done

echo "  Docs copied: $DOC_COUNT"

# ============================================================
# Step 8: Create .mcp.json.template
# ============================================================
echo "[8/10] Creating .mcp.json.template..."

cat > "$PLUGIN/.mcp.json.template" << 'MCPJSON'
{
  "$comment": "MCP server configuration template for singuliodev-claude plugin. Copy to .mcp.json and adjust paths.",
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "playwright": {
      "command": "npx",
      "args": ["@anthropic-ai/mcp-playwright@latest"]
    },
    "memory-mcp": {
      "$comment": "Optional: Custom memory MCP server. Set MEMORY_MCP_PATH to your installation.",
      "command": "node",
      "args": ["${MEMORY_MCP_PATH}/index.js"],
      "env": {
        "MEMORY_DIR": "${HOME}/.claude/memory"
      }
    }
  }
}
MCPJSON

echo "  .mcp.json.template created"

# ============================================================
# Step 9: Create CLAUDE.md
# ============================================================
echo "[9/10] Creating CLAUDE.md..."

cat > "$PLUGIN/CLAUDE.md" << 'CLAUDEMD'
# singuliodev-claude Plugin

Cognitive architecture plugin providing skills, agents, and multi-agent coordination for Claude Code.

## Quick Reference

| Component | Count | Location |
|-----------|-------|----------|
| Skills | ~175 | `skills/<name>/SKILL.md` |
| Agents | ~224 | `agents/<name>.md` |
| Commands | ~20 | `commands/<name>.md` |
| Hook scripts | ~16 | `hooks/scripts/*.sh` |

## 5-Phase Workflow

Every non-trivial request follows this pipeline:

1. **Intent Analysis** - Understand what the user needs
2. **Prompt Optimization** - Refine the request with context
3. **Strategic Planning** - Break into tasks with dependencies
4. **Routing** - Match tasks to appropriate skills/agents
5. **Execution** - Run tasks in parallel where possible

**Golden Rule:** 1 message = all parallel operations.

## Agent Invocation Pattern

Agents are conceptual personas embedded in Task prompts. Only these subagent_types are valid:

| subagent_type | Use For |
|---------------|---------|
| `general-purpose` | Multi-step tasks, research, coding (DEFAULT) |
| `Explore` | Fast codebase search |
| `Plan` | Architecture and planning |
| `Bash` | Shell command execution |

```
Task("Fix auth bug",
  "Acting as a bug-fixer agent: Analyze and fix the auth issue in auth.js",
  "general-purpose")
```

## Top Skills

| Skill | Purpose | Invoke |
|-------|---------|--------|
| `build-feature` | Feature development lifecycle | `/singuliodev-claude:build-feature` |
| `fix-bug` | Systematic debugging | `/singuliodev-claude:fix-bug` |
| `code` | Code implementation | `/singuliodev-claude:code` |
| `debug` | Troubleshooting | `/singuliodev-claude:debug` |
| `code-review` | Code quality review | `/singuliodev-claude:code-review` |
| `architect` | System design | `/singuliodev-claude:architect` |
| `sparc` | SPARC methodology | `/singuliodev-claude:sparc` |
| `deep-research` | Multi-pipeline research | `/singuliodev-claude:deep-research` |
| `swarm-init` | Multi-agent swarm | `/singuliodev-claude:swarm-init` |
| `deploy-check` | Deployment validation | `/singuliodev-claude:deploy-check` |
| `security-review` | Security analysis | `/singuliodev-claude:security-review` |
| `performance-analysis` | Performance optimization | `/singuliodev-claude:performance-analysis` |
| `reflect` | Session learning | `/singuliodev-claude:reflect` |
| `improve` | Code improvement | `/singuliodev-claude:improve` |
| `cascade-orchestrator` | Multi-skill pipelines | `/singuliodev-claude:cascade-orchestrator` |

## Key Rules

1. Batch parallel operations in a single message
2. All user-facing output in plain English
3. Use only registered agents (see `agents/` directory)
4. Track progress with task lists
5. Validate work before marking complete
CLAUDEMD

echo "  CLAUDE.md created"

# ============================================================
# Step 10: Copy migration/verify scripts
# ============================================================
echo "[10/10] Copying utility scripts..."

cp "$SCRIPT_DIR/strip-vcl.sh" "$PLUGIN/scripts/strip-vcl.sh"
cp "$SCRIPT_DIR/verify-plugin.sh" "$PLUGIN/scripts/verify-plugin.sh" 2>/dev/null || true

echo ""
echo "=== Migration Complete ==="
echo ""
echo "Summary:"
echo "  Skills:   $SKILL_COUNT"
echo "  Agents:   $AGENT_COUNT"
echo "  Commands: ${#COMMANDS[@]}"
echo "  Hooks:    $HOOK_SCRIPTS_KEPT scripts"
echo "  Docs:     $DOC_COUNT"
echo ""
echo "Plugin location: $PLUGIN"
echo "Run verify-plugin.sh to validate the result."
