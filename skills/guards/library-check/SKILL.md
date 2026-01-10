---
name: unnamed-skill
description: Pre-coding guard that checks library catalog, patterns documentation, and existing projects for reusable solutions before allowing custom implementation. Activates before ANY coding task (feature dev, bug fix, implementation). Never blocks, always advises. Follows safe-task-spawn guard pattern with Memory MCP decision logging.
---

# Library Check - Pre-Coding Guard Skill

**Version**: 1.0.0 (Gold Tier)
**Purpose**: Prevent redundant implementation by checking three sources for existing solutions before custom builds
**Pattern**: Safe-Task-Spawn Guard (advisory only, never blocking)

---

## Overview

Library Check is a guard skill that intercepts coding tasks to prevent reinventing the wheel. Before any implementation begins, it searches three sources for existing solutions:

1. **Library Catalog** - Indexed reusable components and utilities
2. **Patterns Documentation** - Prior implementations and established patterns
3. **Project Scanner** - Existing code across user's projects

### The Problem

- Developers rebuild solutions that already exist
- No centralized way to discover reusable code
- Patterns get reimplemented inconsistently
- Time wasted on solved problems
- Technical debt from duplicate implementations

### The Solution

- Advisory pre-check before ALL coding tasks
- Three-tier search (library -> patterns -> projects)
- Decision logging to Memory MCP for learning
- Only allows custom builds when all checks fail
- Builds library over time from approved implementations

---

## Guard Pattern: Advisory Only

**CRITICAL**: This skill follows the safe-task-spawn guard pattern:
- **NEVER blocks** - Always allows task to proceed
- **ALWAYS advises** - Displays findings and recommendations
- **LOGS decisions** - Records choice to Memory MCP for pattern learning
- **RESPECTS autonomy** - User/agent decides whether to reuse or build

---

## When This Skill Activates

Automatically activates when detecting coding intent:
- Feature development: "build", "implement", "create", "develop"
- Bug fixes: "fix", "repair", "patch", "resolve"
- Implementation tasks: "code", "write", "add", "setup"
- Refactoring: "refactor", "improve", "optimize"

**Auto-triggers via PreToolUse hook on**:
- Task() with coding-related descriptions
- Skill("build-feature")
- Skill("fix-bug")
- Skill("code")

---

## When NOT to Use This Skill

Skip library-check when:
- Explicitly told to build from scratch ("implement without checking")
- Working on library catalog itself
- Task is research/analysis only (no implementation)
- Emergency hotfix with known unique solution

---

## Three-Tier Search Strategy

### Tier 1: Library Catalog (Highest Priority)

**Location**: `.claude/library/catalog.json`

- Production-ready components
- Versioned and tested
- Direct drop-in solutions
- 17+ indexed components

**Search Command**:
```bash
grep -i "{keyword}" .claude/library/catalog.json
```

### Tier 2: Patterns Documentation (Medium Priority)

**Location**: `.claude/docs/inventories/LIBRARY-PATTERNS-GUIDE.md`

- Documented implementation patterns
- Proven approaches
- May need adaptation
- 7 pattern categories

**Search Command**:
```bash
grep -i "{keyword}" .claude/docs/inventories/LIBRARY-PATTERNS-GUIDE.md
```

### Tier 3: Project Scanner (Lowest Priority)

**Location**: `D:\Projects\*`

- Existing code in user's projects
- May need extraction/refactoring
- Real implementations to reference

**Search Command**:
```bash
grep -r "{keyword}" D:\Projects\ --include="*.ts" --include="*.py" --include="*.tsx"
```

---

## Workflow

### Phase 1: Task Intent Analysis

```
Input: Coding task description or intent
|- Extract implementation keywords
|- Identify domain/technology
|- Determine task type (feature/fix/refactor)
|- Generate search queries
```

### Phase 2: Library Catalog Search

```
Query Library Catalog:
|- Read: .claude/library/catalog.json
|- Match: Keywords against component descriptions
|- Filter: By domain, language, framework
|- Score: Relevance 0-100
|- Return: Top 3 matches with >70% relevance
```

**Display Format**:
```
============================================================
!! LIBRARY CHECK: CATALOG SEARCH !!
============================================================

Found 2 matching library components:

1. [95%] jwt-auth-middleware (v1.0.0)
   - Purpose: JWT authentication middleware for Express
   - Location: library/auth/jwt-middleware.ts
   - Tests: 20 passing, 90% coverage
   - Used in: 2 projects

2. [78%] fastapi-jwt-auth (v1.0.0)
   - Purpose: JWT authentication for FastAPI
   - Location: library/auth/fastapi-jwt.py
   - Tests: 16 passing, 88% coverage
   - Used in: 3 projects

RECOMMENDATION: Consider using jwt-auth-middleware
============================================================
```

### Phase 3: Patterns Documentation Search

```
Query Patterns:
|- Read: .claude/docs/inventories/LIBRARY-PATTERNS-GUIDE.md
|- Match: Task against pattern descriptions
|- Extract: Implementation guidance
|- Return: Relevant patterns with examples
```

**Display Format**:
```
============================================================
!! LIBRARY CHECK: PATTERN SEARCH !!
============================================================

Found 1 matching implementation pattern:

1. [JWT Token Flow (Express)]
   - Source: nsbu-rpg-app/server/middleware/auth.ts
   - Pattern: Token generation + validation middleware
   - Usage: Express APIs needing stateless authentication

RECOMMENDATION: Follow existing JWT pattern
============================================================
```

### Phase 4: Project Scanner

```
Scan Projects:
|- Search: D:\Projects\* directories
|- Match: Code patterns, function names, imports
|- Exclude: node_modules, .git, __pycache__
|- Return: Relevant files with excerpts
```

**Display Format**:
```
============================================================
!! LIBRARY CHECK: PROJECT SCAN !!
============================================================

Found similar implementations in existing projects:

1. D:\Projects\trader-ai\src\auth\jwt.py
   - Similarity: 82%
   - Purpose: JWT token handling
   - Lines: 45-120

2. D:\Projects\life-os-dashboard\src\auth\security.py
   - Similarity: 75%
   - Purpose: FastAPI authentication
   - Lines: 12-89

RECOMMENDATION: Extract from trader-ai for reuse
============================================================
```

### Phase 5: Synthesis and Recommendation

```
Synthesize Results:
|- Aggregate: All search results
|- Rank: By relevance and reuse effort
|- Generate: Primary recommendation
|- Display: Decision matrix
```

**Decision Matrix**:
```
+------------------+--------------+-------------------+
| Match Quality    | Recommend    | Time Saved        |
+------------------+--------------+-------------------+
| Library >90%     | REUSE        | 8+ hours          |
| Library 70-90%   | ADAPT        | 4-6 hours         |
| Pattern match    | FOLLOW       | 2-4 hours         |
| Project match    | EXTRACT      | 1-2 hours         |
| No matches       | BUILD NEW    | Proceed           |
+------------------+--------------+-------------------+
```

### Phase 6: Memory MCP Logging

```
Log Decision:
|- Namespace: "guards/library-check/{project}/{timestamp}"
|- Tags: WHO, WHEN, PROJECT, WHY
|- Content: Full decision record
|- TTL: 90 days (for pattern analysis)
```

---

## Input Contract

```typescript
interface LibraryCheckInput {
  task_description: string;      // What is being built
  domain?: string;               // Authentication, payments, etc.
  technology?: string[];         // TypeScript, Python, etc.
  project_context?: string;      // Current project path
  force_check?: boolean;         // Run even if recently checked
  verbosity?: "minimal" | "normal" | "verbose";
}
```

---

## Output Contract

```typescript
interface LibraryCheckOutput {
  status: "found_reusable" | "found_patterns" | "found_similar" | "no_matches";
  recommendation: "reuse" | "adapt" | "follow_pattern" | "extract" | "build_new";
  confidence: number;            // 0-100
  search_results: {
    library: LibraryMatch[];
    patterns: PatternMatch[];
    projects: ProjectMatch[];
  };
  decision_logged: boolean;
  memory_key: string;            // Memory MCP reference
  proceed_message: string;       // Advisory message
}
```

---

## Anti-Patterns Table

| Anti-Pattern | Why It Fails | Correct Approach |
|--------------|--------------|------------------|
| Blocking task on no match | Frustrates users, slows work | Always advisory, never blocking |
| Skipping search for "simple" tasks | Simple tasks often have library solutions | Always search, regardless of perceived complexity |
| Not logging "build new" decisions | Misses opportunity to grow library | Log ALL decisions for pattern analysis |
| Searching too broadly | Returns irrelevant noise | Use domain/tech filters |
| Ignoring low-relevance matches | May contain useful partial solutions | Display with appropriate context |
| Not updating catalog after builds | Library never grows | Flag approved builds for catalog addition |

---

## Memory MCP Schema

```yaml
namespace: "guards/library-check/{project_id}/{timestamp}"
key: "{task_hash}-{uuid}"

value:
  task_description: "Implement JWT authentication"
  domain: "authentication"
  technology: ["TypeScript", "Express"]

  library_search:
    matches: [...]
    highest_relevance: 95
    search_time_ms: 45

  pattern_search:
    matches: [...]
    highest_relevance: 88
    search_time_ms: 120

  project_search:
    matches: [...]
    highest_similarity: 82
    search_time_ms: 890

  decision:
    recommendation: "reuse"
    selected_option: "jwt-auth-middleware"
    rationale: "95% relevance, production-tested"
    time_saved_estimate: "8 hours"

tags:
  who: "library-check:1.0.0"
  when: "2026-01-09T14:30:00Z"
  project: "current-project"
  why: "pre-coding-guard"

ttl: 7776000  # 90 days
```

---

## Integration Points

### Hook Configuration

Add to `.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Task|Skill",
        "description": "Library check before coding tasks",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/guards/pre-coding-library-check.sh"
          }
        ]
      }
    ]
  }
}
```

### CLAUDE.md Integration

Add to HOOKS & GUARDRAILS section:
```markdown
### Library Check Guard (Pre-Coding Advisory)

**Purpose**: Prevent redundant implementation
**Pattern**: Safe-task-spawn guard (advisory only)
**Location**: .claude/skills/guards/library-check/SKILL.md

**Three-Tier Search**:
1. Library Catalog (.claude/library/catalog.json)
2. Patterns (.claude/docs/inventories/LIBRARY-PATTERNS-GUIDE.md)
3. Project Scanner (D:\Projects\*)
```

---

## Configuration

### Environment Variables
```bash
LIBRARY_CHECK_ENABLED=true
LIBRARY_CHECK_RELEVANCE_THRESHOLD=70
LIBRARY_CHECK_PROJECT_PATHS="D:\Projects\*"
LIBRARY_CHECK_VERBOSITY=normal
LIBRARY_CHECK_MEMORY_TTL=7776000
```

### Settings.json
```json
{
  "skills": {
    "library-check": {
      "enabled": true,
      "auto_trigger": true,
      "relevance_threshold": 70,
      "project_paths": ["D:\\Projects\\*"],
      "verbosity": "normal"
    }
  }
}
```

---

## Success Metrics

Library Check succeeds when:
- All three tiers searched successfully
- Results displayed clearly to user/agent
- Decision logged to Memory MCP
- Task proceeds without blocking
- Build time savings tracked over time

**KPIs**:
- Reuse rate: % of tasks using existing solutions
- Build time saved: Hours saved by reuse
- Library growth: New components added after builds
- Search accuracy: % of accepted recommendations
- Coverage: % of coding tasks with library-check run

---

## Related Skills

- **safe-task-spawn**: Registry validation pattern (reference)
- **audit-pipeline**: Post-build quality checks
- **expertise-manager**: Patterns documentation
- **skill-forge**: Creating new library components

---

## Changelog

### v1.0.0 (2026-01-09)
- Initial implementation
- Three-tier search (library, patterns, projects)
- Memory MCP logging
- Advisory-only guard pattern
- 17 initial library components

---

**Maintained by**: Claude Code (Opus 4.5)
**Based on**: safe-task-spawn guard pattern
**Last Updated**: 2026-01-09
