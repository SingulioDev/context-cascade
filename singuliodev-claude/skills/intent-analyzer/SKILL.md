

---
name: SKILL
version: 1.0.0
description: |
  SKILL skill for research workflows
category: research
tags:
- general
triggers:
  - "when analyzing user intent"
author: system
---

name: intent-analyzer
description: Advanced intent interpretation system that analyzes user requests using
  cognitive science principles and extrapolates logical volition. Use when user requests
  are ambiguous, when deeper understanding would improve response quality, or when
  helping users clarify what they truly need. Applies probabilistic intent mapping,
  first principles decomposition, and Socratic clarification to transform vague requests
  into well-understood goals.
version: 1.0.0
category: research
tags:
- research
- analysis
- planning
triggers:
  - "when analyzing user intent"
author: ruv
---

# Intent Analyzer

An advanced system for deeply understanding user intent by going beyond surface-level requests to discover underlying goals, unstated constraints, and true needs.

## Overview

Intent Analyzer represents a sophisticated approach to understanding what users really want. Rather than taking requests at face value, it employs cognitive science principles to examine underlying intent, identify implicit assumptions, recognize unstated constraints, and help users articulate their true goals clearly.

This skill draws inspiration from coherent extrapolated volition in AI alignment theory—determining what someone would want if they "knew more, thought faster, and were more the person they wished they were." Applied practically, this means understanding not just what the user explicitly requested, but what they would have requested with complete knowledge of possibilities, perfect clarity about their goals, and full awareness of relevant constraints.

## When to Use This Skill

Apply Intent Analyzer when:
- User requests are ambiguous or could be interpreted multiple ways
- Deeper understanding of goals would significantly improve response quality
- The stated request might be a proxy for an unstated underlying need
- Critical information appears to be missing or assumed
- Multiple reasonable interpretations exist and choosing wrong would waste effort
- Helping users clarify complex or poorly-defined problems
- Teaching or mentoring where understanding motivation improves guidance

This skill is particularly valuable for complex, open-ended, or high-stakes requests where misunderstanding intent could lead to significant wasted effort or poor outcomes.

## Core Principles

Intent Analyzer operates on five fundamental principles:

### First Principles Decomposition

Break down every request to its most fundamental goals. Question surface-level assumptions about what is being asked. Often, the stated request is a proxy for a deeper underlying need.

For example:
- "Summarize this document" might actually mean: seeking specific information within it, preparing for a meeting, evaluating whether to read it fully, or extracting key decisions
- "Help me write code" might actually mean: learning programming concepts, completing a specific project, debugging existing code, or understanding best practices

Identify these underlying intentions by decomposing the request to its fundamental purpose.

### Probabilistic Intent Mapping

Every user message carries multiple possible interpretations with varying probabilities. Construct a probability distribution over potential intents considering:
- Context clues in the phrasing
- Domain patterns and common use cases
- Explicit and implicit information provided
- What's left unsaid or assumed

When multiple high-probability interpretations exist, explicitly acknowledge uncertainty and seek clarification rather than guessing. When one interpretation is clearly dominant (>80% confidence), proceed while remaining open to correction.

### Evidence-Based Pattern Recognition

Recognize which category of request this represents based on established taxonomies:
- Creative task (writing, design, ideation)
- Analytical task (evaluation, comparison, assessment)
- Technical task (coding, configuration, troubleshooting)
- Learning query (explanation, teachin

