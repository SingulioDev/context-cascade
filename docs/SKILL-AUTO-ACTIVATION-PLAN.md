# Skill Auto-Activation System Plan

## Problem Statement

The Context Cascade plugin has 226 skills, but they don't auto-activate. Current issues:

1. **Brute-force hook** - Lists ALL skills in every prompt, overwhelming and ineffective
2. **No intelligent matching** - Skills aren't matched to user intent
3. **Partial loading** - Only SKILL.md read, not anti-patterns/examples
4. **Same small group** - Claude picks from familiar ~10 skills, ignoring 216 others
5. **Manual triggering** - User must explicitly invoke skills

## Solution Architecture

```
USER REQUEST
     |
     v
+---------------------------+
| PRE-HOOK: skill-router    |
|   1. Tokenize request     |
|   2. Query skill-index    |
|   3. Score matches        |
|   4. Return top 5 skills  |
+---------------------------+
     |
     v
+---------------------------+
| CLAUDE receives context:  |
|   - Matched skill names   |
|   - Categories            |
|   - Match confidence      |
|   - Full folder paths     |
+---------------------------+
     |
     v
+---------------------------+
| SKILL LOADING:            |
|   - SKILL.md (SOP)        |
|   - ANTI-PATTERNS.md      |
|   - README.md             |
|   - examples/*.md         |
+---------------------------+
     |
     v
+---------------------------+
| EXECUTION with full       |
| skill context loaded      |
+---------------------------+
```

## Component 1: Skill Index Generator

### Purpose
Extract trigger keywords from all 226 SKILL.md files and build a searchable index.

### Script: `scripts/skill-index/generate-index.js`

### What to Extract from Each SKILL.md

```yaml
frontmatter:
  - name
  - description
  - x-category / category
  - x-tags
  - allowed-tools

body_sections:
  - TRIGGER_POSITIVE keywords (if exists)
  - "When to Use" section
  - "When NOT to Use" section (for negative matching)

derived:
  - category (from directory path)
  - supporting_files (anti-patterns, examples, etc.)
```

### Index Structure (skill-index.json)

```json
{
  "version": "1.0.0",
  "generated": "2025-12-30T...",
  "total_skills": 226,

  "categories": {
    "delivery": {
      "description": "Feature and product implementation",
      "skills": ["feature-dev-complete", "smart-bug-fix", ...]
    },
    "quality": {
      "description": "Testing, auditing, verification",
      "skills": ["functionality-audit", "theater-detection", ...]
    },
    ...
  },

  "skills": {
    "feature-dev-complete": {
      "name": "feature-dev-complete",
      "path": "skills/delivery/feature-dev-complete/",
      "category": "delivery",
      "description": "12-stage feature lifecycle with research/testing",
      "triggers": ["feature", "implement", "develop", "build", "new functionality"],
      "negative_triggers": ["bug", "fix", "debug"],
      "files": ["SKILL.md", "ANTI-PATTERNS.md", "examples/"],
      "complexity": "high",
      "agents_used": ["planner", "coder", "tester"]
    },
    ...
  },

  "keyword_index": {
    "auth": ["feature-dev-complete", "security-audit", "network-security-setup"],
    "test": ["testing-quality", "functionality-audit", "tdd-workflow"],
    "debug": ["smart-bug-fix", "debugging", "root-cause-analysis"],
    "deploy": ["deployment-readiness", "cicd-intelligent-recovery", "infrastructure"],
    "research": ["deep-research-orchestrator", "literature-synthesis", "multi-model-discovery"],
    ...
  },

  "category_keywords": {
    "delivery": ["feature", "implement", "build", "develop", "create", "add"],
    "quality": ["test", "audit", "review", "verify", "validate", "check"],
    "security": ["security", "auth", "permission", "vulnerability", "pentest"],
    "research": ["research", "find", "discover", "analyze", "investigate"],
    "orchestration": ["coordinate", "orchestrate", "swarm", "parallel", "workflow"],
    ...
  }
}
```

### Algorithm

```
1. SCAN: Find all SKILL.md files
   find skills/ -name "SKILL.md"

2. PARSE: For each SKILL.md
   - Extract YAML frontmatter (js-yaml)
   - Parse markdown body for trigger sections
   - Extract keywords from description
   - Identify supporting files in same directory

3. TOKENIZE: Extract keywords
   - Split description into words
   - Filter stopwords (the, a, is, etc.)
   - Stem words (implementing -> implement)
   - Extract from TRIGGER_POSITIVE if present

4. INDEX: Build reverse index
   - keyword -> [skill1, skill2, ...]
   - category -> [skill1, skill2, ...]

5. OUTPUT: Write skill-index.json
```

## Component 2: Category Router

### Purpose
Match user intent to skill category first, then find specific skills within category.

### Script: `scripts/skill-index/route-skill.sh`

### Routing Algorithm

```
INPUT: User request text
OUTPUT: Top 5 matching skills with confidence scores

STEP 1: TOKENIZE REQUEST
  - Split into words
  - Lowercase
  - Filter stopwords
  - Extract key phrases

STEP 2: CATEGORY MATCHING
  - Compare tokens against category_keywords
  - Score each category by overlap count
  - Identify top 2-3 categories

STEP 3: SKILL MATCHING (within matched categories)
  - Compare tokens against skill triggers
  - Score by:
    - Keyword overlap (50%)
    - Category match (30%)
    - Negative trigger absence (20%)

STEP 4: RANK AND RETURN
  - Sort by score descending
  - Return top 5 with:
    - Skill name
    - Category
    - Match score (0-100)
    - Full path
    - Key trigger matches
```

### Example

```
INPUT: "I need to add user authentication to my app"

TOKENIZE: ["add", "user", "authentication", "app"]

CATEGORY MATCH:
  - delivery: 1 (add)
  - security: 1 (authentication)
  - platforms: 0

SKILL MATCH:
  1. feature-dev-complete (score: 85)
     - triggers: [add, new, feature, implement]
     - category: delivery (bonus)

  2. network-security-setup (score: 72)
     - triggers: [security, auth, network]
     - category: security (bonus)

  3. multi-model-discovery (score: 65)
     - triggers: [find, existing, solutions]
     - reason: research before implement

OUTPUT:
  MATCHED_SKILLS:
  1. feature-dev-complete (85%) - delivery - Full feature lifecycle
  2. network-security-setup (72%) - security - Auth/security setup
  3. multi-model-discovery (65%) - platforms - Find existing solutions
```

## Component 3: Smarter Hook

### Purpose
Replace brute-force skill listing with intelligent routing.

### Hook: `hooks/pre-prompt/skill-router-hook.sh`

### Hook Flow

```bash
#!/bin/bash
# Runs BEFORE user prompt is processed
# Receives user input, outputs skill context

USER_REQUEST="$1"
PLUGIN_DIR="C:/Users/17175/claude-code-plugins/context-cascade"

# Run the router
MATCHES=$("$PLUGIN_DIR/scripts/skill-index/route-skill.sh" "$USER_REQUEST")

# If matches found, format for Claude
if [ -n "$MATCHES" ]; then
  cat <<EOF
!! SKILL ROUTER RESULTS !!

Based on your request, these skills are most relevant:

$MATCHES

INSTRUCTIONS:
- If a skill matches with >70% confidence, LOAD IT FULLY
- Loading means: Read SKILL.md + ANTI-PATTERNS.md + README.md
- Use the skill's SOP to guide your approach
- Check examples/ for practical usage patterns

EOF
fi
```

### Integration with Existing 5-Phase Hook

Current hook location: `hooks/UserPromptSubmit/`

Changes needed:
1. Run skill-router BEFORE the 5-phase evaluation
2. Replace hardcoded skill list with router output
3. Only show skills that matched (not all 226)

### New Hook Structure

```
hooks/
  UserPromptSubmit/
    00-skill-router.sh       # NEW: Runs first, outputs matched skills
    01-five-phase-workflow.sh  # MODIFIED: Uses router output, not hardcoded list
```

## Implementation Phases

### Phase 1: Index Generator (2 hours)

```
1. Create scripts/skill-index/ directory
2. Write generate-index.js:
   - YAML parsing with js-yaml
   - Markdown section extraction
   - Keyword tokenization
   - Index building
3. Run and generate skill-index.json
4. Verify index accuracy
```

### Phase 2: Router Script (1 hour)

```
1. Write route-skill.sh:
   - Read index with jq
   - Tokenize input
   - Score matches
   - Output top 5
2. Test with sample requests
3. Tune scoring weights
```

### Phase 3: Hook Integration (1 hour)

```
1. Create 00-skill-router.sh
2. Modify existing hook to use router output
3. Test full flow
4. Verify skills load correctly
```

### Phase 4: Refinement (ongoing)

```
1. Add synonym support (auth = authentication = login)
2. Track skill usage for feedback
3. Auto-regenerate index on skill changes
4. Improve matching algorithm based on usage data
```

## File Structure

```
context-cascade/
  scripts/
    skill-index/
      generate-index.js      # Build the index
      route-skill.sh         # Query the index
      skill-index.json       # Generated index (gitignored?)
      stopwords.txt          # Words to filter
      synonyms.json          # Word equivalencies

  hooks/
    UserPromptSubmit/
      00-skill-router.sh     # Pre-routing hook
      01-five-phase.sh       # Modified workflow hook
```

## Success Criteria

1. **Index completeness**: All 226 skills indexed with triggers
2. **Routing accuracy**: >80% of requests match relevant skill
3. **Load time**: <100ms for routing lookup
4. **Full loading**: Matched skills load SKILL.md + anti-patterns + examples
5. **Usage diversity**: Different skills used based on context, not habit

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Poor keyword extraction | Use description + tags + section headers |
| Too many matches | Limit to top 5, require >50% confidence |
| Missing synonyms | Build synonym dictionary incrementally |
| Index staleness | Re-run generator after skill changes |
| Hook performance | Cache index in memory, optimize jq queries |

## Next Steps

1. [ ] Create `scripts/skill-index/` directory
2. [ ] Write `generate-index.js` with YAML/MD parsing
3. [ ] Generate initial `skill-index.json`
4. [ ] Write `route-skill.sh` router
5. [ ] Create `00-skill-router.sh` hook
6. [ ] Modify 5-phase hook to use router output
7. [ ] Test end-to-end flow
8. [ ] Document usage

---

**Plan Status**: READY FOR IMPLEMENTATION
**Estimated Effort**: 4-5 hours
**Dependencies**: js-yaml (npm), jq (bash)
