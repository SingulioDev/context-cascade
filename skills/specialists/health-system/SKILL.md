# Health System Skill



---

## LIBRARY-FIRST PROTOCOL (MANDATORY)

**Before writing ANY code, you MUST check:**

### Step 1: Library Catalog
- Location: `.claude/library/catalog.json`
- If match >70%: REUSE or ADAPT

### Step 2: Patterns Guide
- Location: `.claude/docs/inventories/LIBRARY-PATTERNS-GUIDE.md`
- If pattern exists: FOLLOW documented approach

### Step 3: Existing Projects
- Location: `D:\Projects\*`
- If found: EXTRACT and adapt

### Decision Matrix
| Match | Action |
|-------|--------|
| Library >90% | REUSE directly |
| Library 70-90% | ADAPT minimally |
| Pattern exists | FOLLOW pattern |
| In project | EXTRACT |
| No match | BUILD (add to library after) |

---

## Overview

Comprehensive health and productivity optimization system with specialized subagents for each domain. Integrates with the habit tracker pipeline and meta-loop system for continuous improvement.

## Trigger Conditions

- User mentions: health, fitness, workout, gym, nutrition, sleep, recovery, flexibility, strength
- User asks about: exercise routines, meal planning, sleep optimization, productivity
- Habit tracker shows: gym sessions behind target, low health habit completion

## Architecture

```
                    +-------------------+
                    | HEALTH ORCHESTRATOR |
                    | (This Skill)       |
                    +---------+---------+
                              |
        +---------------------+---------------------+
        |           |           |           |       |
        v           v           v           v       v
+-------+---+ +-----+-----+ +---+-------+ +-+-----+ +-----+-----+
| STRENGTH  | | ENDURANCE | | FLEXIBILITY| |TOUGH | | NUTRITION |
| Agent     | | Agent     | | Agent     | |Agent | | Agent     |
+-----------+ +-----------+ +-----------+ +------+ +-----------+
        |           |           |           |           |
        +---------------------+---------------------+---+
                              |
                    +---------+---------+
                    | RECOVERY & SLEEP  |
                    | Agent             |
                    +-------------------+
```

## The 4 Pillars of Physical Conditioning

Based on resources from `C:\Users\17175\Downloads\conditioning-extracted\`:

### 1. Strength (Muscle)
- **Source**: RP Scientific Principles of Hypertrophy, Greg Nuckols 28 Programs
- **Focus**: Muscle hypertrophy, strength gains
- **Agent**: `strength-training-agent`

### 2. Endurance (Aerobic)
- **Source**: Diamond of Aerobic Health
- **Focus**: Cardiovascular health, zone training
- **Agent**: `endurance-cardio-agent`

### 3. Flexibility (Tendons)
- **Source**: Kelly Starrett - Becoming a Supple Leopard
- **Focus**: Mobility, injury prevention, joint health
- **Agent**: `flexibility-mobility-agent`

### 4. Toughness (Bone Density)
- **Source**: Iron Body Training, IronShirt QiGong
- **Focus**: Bone conditioning, resilience
- **Agent**: `toughness-conditioning-agent`

## Supporting Agents

### 5. Nutrition
- **Focus**: Macros, meal timing, supplements
- **Agent**: `nutrition-planning-agent`

### 6. Recovery & Sleep
- **Focus**: Sleep optimization, rest days, stress management
- **Agent**: `recovery-sleep-agent`

### 7. Productivity
- **Focus**: Mental performance, focus, energy management
- **Agent**: `productivity-optimization-agent`

## Integration Points

### Habit Tracker
```python
# Automatic triggers from habit_tracker.py
if gym_sessions < target:
    invoke("strength-training-agent", "suggest_workout")
if sleep_habit.streak < 3:
    invoke("recovery-sleep-agent", "sleep_optimization_tips")
```

### Meta-Loop
- Mode: `balanced` for general queries
- Mode: `research` for program design
- Mode: `audit` for form checks and safety

### Memory MCP Storage
```
C:\Users\17175\.claude\memory-mcp-data\health-system\
    strength\          <- Workout logs, PRs
    nutrition\         <- Meal logs, macros
    recovery\          <- Sleep data, HRV
    programs\          <- Active training programs
```

## Commands

| Command | Description |
|---------|-------------|
| `health status` | Current health metrics summary |
| `health workout` | Generate today's workout |
| `health meal` | Suggest next meal based on macros |
| `health sleep` | Sleep optimization recommendations |
| `health program` | Design multi-week training program |

## Usage Examples

### Get Workout Recommendation
```
User: I need a workout for today, focusing on upper body
Skill: Invokes strength-training-agent with context from habit tracker
Output: Structured workout with sets, reps, rest periods
```

### Optimize Sleep
```
User: I've been sleeping poorly, what should I change?
Skill: Invokes recovery-sleep-agent with recent habit data
Output: Personalized sleep optimization plan
```

### Full Health Check
```
User: Give me a health status report
Skill: Aggregates data from all agents
Output: Dashboard showing all pillars with recommendations
```

## Resources Reference

| Category | File | Location |
|----------|------|----------|
| Strength | RP Scientific Principles | `conditioning\Strength - Muscle\` |
| Strength | Greg Nuckols 28 Programs | `conditioning\Strength - Muscle\` |
| Endurance | Diamond of Aerobic Health | `conditioning\Endurance - Aerobic conditioning\` |
| Flexibility | Becoming a Supple Leopard | `conditioning\Flexibility - Tendons\` |
| Toughness | Iron Body Training | `conditioning\Toughness - Bone Density\` |
| Nutrition | Physical Health Nutrition | `conditioning\` |

## Meta-Loop Integration

```python
from metaloop_integration import UniversalPipelineHook

hook = UniversalPipelineHook("health-system", mode="balanced")

# Track all health recommendations
with hook.track_execution("health-query", prompt, "recommendation"):
    response = agent.generate_recommendation()
    ctx.record_response(response)
```

## Version

- **Version**: 1.0.0
- **Created**: 2025-12-29
- **Author**: Context Cascade Health System
