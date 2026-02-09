

---
name: pptx-generation
version: 1.0.0
description: |
  Enterprise-grade PowerPoint deck generation system using evidence-based prompting techniques, workflow enforcement, and constraint-based design. Use when creating professional presentations (board dec
category: tooling
tags:
- general
triggers:
  - "when creating presentations"
author: ruv
---

# PowerPoint Generation Skill

## Overview

This skill implements a systematic framework for generating professional-quality PowerPoint presentations using AI. It addresses the unique challenges of PowerPoint as a medium that combines data analysis, narrative structure, visual design, and spatial layout—making it one of the most complex AI generation tasks in corporate knowledge work.

The skill applies evidence-based prompting techniques (plan-and-solve, program-of-thought, self-consistency), structural optimization principles (workflow enforcement, constraint-based design, validation gates), and proven spatial layout patterns to ensure consistent, high-quality outputs.

## Core Principles

### 1. Workflow Enforcement

AI systems exhibit tool degradation—silently switching to suboptimal alternatives when primary tools encounter difficulties. For spatial/visual tasks, this creates unreliable outputs.

**Implementation**: Explicitly specify the html2pptx technical workflow and prohibit alternative approaches. Require documentation review before execution.

**Rationale**: PowerPoint generation requires precise spatial calculations. The html2pptx skill provides reliable pixel-level control. Preventing tool switching eliminates the primary source of layout inconsistencies.

### 2. Constraint-Based Design Over Decorative Specification

Simple visual rules scale reliably; complex decorative elements create brittleness in AI generation.

**Implementation**: Define what NOT to do (negative constraints) before specifying positive behaviors. Prohibit border boxes, outline shapes, and rounded rectangles. Emphasize spacing, typography, and subtle color blocks.

**Rationale**: Visual design has exponentially more failure modes than success modes. Eliminating known problematic patterns focuses generative capacity within reliable boundaries. Clean design enables AI to prioritize content synthesis over visual parsing.

### 3. Pre-Execution Design Planning

Separating planning from execution prevents premature commitment to suboptimal visual approaches.

**Implementation**: Require written design plan specifying layout approach, color palette, typography hierarchy, and visual emphasis strategy before code generation.

**Rationale**: Mimics human design process. Creates audit trail for review. Establishes coherent visual system before implementation begins. Dramatically improves consistency across multi-slide decks.

### 4. Quantified Visual Specifications

Vague instructions ("clean margins") force the AI to guess intent. Precise specifications eliminate ambiguity.

**Implementation**: Convert qualitative requirements to measurable parameters (contrast ratios, font sizes, margin measurements, element counts).

**Rationale**: Spatial relationships are inherently quantitative. Explicit measurements create reproducible results and enable automated validation.

### 5. Multi-Chat Architecture for Complex Decks

Visual elements consume tokens faster than text or data. Single-context generation becomes unreliable beyond ~15 slides.

**Implementation**: Separate architect (narrative structure), generator (slide production), and assembly (consistency validation) into distinct conversations for 30+ slide decks.

**Rationale**: Manages context window limitations. Allows focused expertise in each phase. Enables section-level iteration without full deck regeneration.

## When to Use This Skill

**Primary Use Cases**:
- Board decks and executive presentations requiring professional polish
- Financial reports integrating data from multiple sources
- Strategic analyses combining quantitative and qualitative content
- Project updates demanding consistent visual language
- Any presentation where visual quality impacts stakeholder perception

**Skill Triggers**:
- User requests "create a presentation," "make slides," "build a deck"
- User asks to "analyze [data] and present finding

