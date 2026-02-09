#!/usr/bin/env bash
# verify-plugin.sh - Verify singuliodev-claude plugin structure and integrity
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"
PLUGIN="$ROOT/singuliodev-claude"

PASS=0
FAIL=0
WARN=0

pass() { echo "  [PASS] $1"; PASS=$((PASS + 1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL + 1)); }
warn() { echo "  [WARN] $1"; WARN=$((WARN + 1)); }

echo "=== singuliodev-claude Plugin Verification ==="
echo ""

# ============================================================
# Structural checks
# ============================================================
echo "--- Structural Checks ---"

# plugin.json exists and valid
if [ -f "$PLUGIN/.claude-plugin/plugin.json" ]; then
  if python3 -c "import json; json.load(open('$PLUGIN/.claude-plugin/plugin.json'))" 2>/dev/null; then
    name=$(python3 -c "import json; print(json.load(open('$PLUGIN/.claude-plugin/plugin.json'))['name'])")
    if [ "$name" = "singuliodev-claude" ]; then
      pass "plugin.json valid with correct name"
    else
      fail "plugin.json name is '$name', expected 'singuliodev-claude'"
    fi
  else
    fail "plugin.json is not valid JSON"
  fi
else
  fail "plugin.json not found"
fi

# Every skills/<name>/ has SKILL.md
skill_dirs_without_md=0
for d in "$PLUGIN/skills"/*/; do
  if [ ! -f "$d/SKILL.md" ]; then
    skill_dirs_without_md=$((skill_dirs_without_md + 1))
    warn "Missing SKILL.md in $d"
  fi
done
if [ "$skill_dirs_without_md" -eq 0 ]; then
  pass "All skill directories have SKILL.md"
else
  fail "$skill_dirs_without_md skill directories missing SKILL.md"
fi

# No subdirectories in agents/
agent_subdirs=$(find "$PLUGIN/agents" -mindepth 1 -type d 2>/dev/null | wc -l)
if [ "$agent_subdirs" -eq 0 ]; then
  pass "No subdirectories in agents/"
else
  fail "$agent_subdirs subdirectories found in agents/"
fi

# No subdirectories in commands/
cmd_subdirs=$(find "$PLUGIN/commands" -mindepth 1 -type d 2>/dev/null | wc -l)
if [ "$cmd_subdirs" -eq 0 ]; then
  pass "No subdirectories in commands/"
else
  fail "$cmd_subdirs subdirectories found in commands/"
fi

# No duplicate basenames in agents/
agent_dupes=$(find "$PLUGIN/agents" -name "*.md" -exec basename {} \; | sort | uniq -d | wc -l)
if [ "$agent_dupes" -eq 0 ]; then
  pass "No duplicate agent filenames"
else
  fail "$agent_dupes duplicate agent filenames found"
fi

# No duplicate basenames in skills/
skill_dupes=$(find "$PLUGIN/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort | uniq -d | wc -l)
if [ "$skill_dupes" -eq 0 ]; then
  pass "No duplicate skill directory names"
else
  fail "$skill_dupes duplicate skill directory names found"
fi

# hooks.json valid
if [ -f "$PLUGIN/hooks/hooks.json" ]; then
  if python3 -c "import json; json.load(open('$PLUGIN/hooks/hooks.json'))" 2>/dev/null; then
    pass "hooks.json is valid JSON"
  else
    fail "hooks.json is not valid JSON"
  fi
else
  fail "hooks.json not found"
fi

# All hook scripts referenced in hooks.json exist
echo ""
echo "--- Hook Script Checks ---"
missing_hooks=0
while IFS= read -r script_name; do
  if [ -n "$script_name" ] && [ ! -f "$PLUGIN/hooks/scripts/$script_name" ]; then
    warn "Referenced hook script not found: $script_name"
    missing_hooks=$((missing_hooks + 1))
  fi
done < <(python3 -c "
import json, re
with open('$PLUGIN/hooks/hooks.json') as f:
    data = json.load(f)
for event, groups in data.get('hooks', {}).items():
    for group in groups:
        for hook in group.get('hooks', []):
            cmd = hook.get('command', '')
            m = re.search(r'scripts/([^\"]+)', cmd)
            if m:
                print(m.group(1))
")

if [ "$missing_hooks" -eq 0 ]; then
  pass "All referenced hook scripts exist"
else
  fail "$missing_hooks referenced hook scripts missing"
fi

# No .ps1 files
ps1_count=$(find "$PLUGIN" -name "*.ps1" 2>/dev/null | wc -l)
if [ "$ps1_count" -eq 0 ]; then
  pass "No .ps1 files found"
else
  fail "$ps1_count .ps1 files found"
fi

# No symlinks
symlink_count=$(find "$PLUGIN" -type l 2>/dev/null | wc -l)
if [ "$symlink_count" -eq 0 ]; then
  pass "No symlinks found"
else
  fail "$symlink_count symlinks found"
fi

# ============================================================
# Content checks - use python to avoid shell escaping issues
# ============================================================
echo ""
echo "--- Content Checks ---"

# Check for Windows paths and VCL markers using python to avoid shell escaping
eval "$(PLUGIN="$PLUGIN" python3 << 'PYPARSE'
import os
import re

plugin = os.environ['PLUGIN']
win_count = 0
vcl_count = 0
win_files = []
vcl_files = []

win_patterns = [r'C:\\Users', r'D:\\Projects']
vcl_patterns = [r'\[assert\|', r'Kanitsal Cerceve', r'\[define\|neutral\]', r'\[direct\|emphatic\]', r'\[commit\|confident\]']

for root, dirs, files in os.walk(plugin):
    for f in files:
        if not f.endswith(('.md', '.json')):
            continue
        fpath = os.path.join(root, f)
        try:
            with open(fpath, 'r', errors='ignore') as fh:
                content = fh.read()
        except:
            continue

        for wp in win_patterns:
            if re.search(wp, content):
                win_count += 1
                win_files.append(fpath)
                break

        if '/scripts/' in fpath:
            continue
        for vp in vcl_patterns:
            if re.search(vp, content):
                vcl_count += 1
                vcl_files.append(fpath)
                break

print(f'WIN_PATHS={win_count}')
print(f'VCL_MARKERS={vcl_count}')
PYPARSE
)"

if [ "$WIN_PATHS" -eq 0 ]; then
  pass "No Windows paths found"
else
  warn "$WIN_PATHS files contain Windows paths"
fi

if [ "$VCL_MARKERS" -eq 0 ]; then
  pass "No VCL markers found"
else
  warn "$VCL_MARKERS files still contain VCL markers (in content, not boilerplate)"
fi

# ============================================================
# Coverage checks
# ============================================================
echo ""
echo "--- Coverage Checks ---"

skill_count=$(find "$PLUGIN/skills" -mindepth 1 -maxdepth 1 -type d | wc -l)
if [ "$skill_count" -ge 170 ]; then
  pass "Skill count: $skill_count (>= 170)"
else
  warn "Skill count: $skill_count (target: >= 170)"
fi

agent_count=$(find "$PLUGIN/agents" -name "*.md" | wc -l)
if [ "$agent_count" -ge 220 ]; then
  pass "Agent count: $agent_count (>= 220)"
else
  warn "Agent count: $agent_count (target: >= 220)"
fi

cmd_count=$(find "$PLUGIN/commands" -name "*.md" | wc -l)
echo "  [INFO] Command count: $cmd_count"

hook_count=$(find "$PLUGIN/hooks/scripts" -name "*.sh" | wc -l)
echo "  [INFO] Hook script count: $hook_count"

# Bash syntax check on hook scripts
echo ""
echo "--- Hook Syntax Checks ---"
syntax_fails=0
for sh_file in "$PLUGIN/hooks/scripts"/*.sh; do
  if [ -f "$sh_file" ]; then
    if bash -n "$sh_file" 2>/dev/null; then
      : # silent pass
    else
      fail "Syntax error in $(basename "$sh_file")"
      syntax_fails=$((syntax_fails + 1))
    fi
  fi
done
if [ "$syntax_fails" -eq 0 ]; then
  pass "All hook scripts pass bash -n syntax check"
fi

# ============================================================
# Summary
# ============================================================
echo ""
echo "=== Verification Summary ==="
echo "  PASS: $PASS"
echo "  FAIL: $FAIL"
echo "  WARN: $WARN"
echo ""

if [ "$FAIL" -gt 0 ]; then
  echo "RESULT: FAILED - $FAIL issues need fixing"
  exit 1
else
  echo "RESULT: PASSED"
  exit 0
fi
