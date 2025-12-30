# Image Prompt Engineering Lessons Learned

## Production Standard: 95% Threshold

All generated images MUST pass a 95% quality audit before publishing.

## Key Lessons from Blog Image Generation

### 1. CLIP Token Limit (Critical)

**Problem**: CLIP model has a 77-token maximum. Longer prompts get truncated.

**Solution**: Keep prompts under 77 tokens. Front-load the most important instructions.

**Anti-Pattern**:
```
Professional LinkedIn banner (1200x630px aspect ratio) visualizing 'the gap between theorizing about AI agents and actually building production infrastructure'.

SPATIAL: asymmetric_tension - dynamic imbalance between stasis and motion
COLOR: symbolic_coded - muted grays for theory (left), vibrant electric blues...
[...200+ more tokens that get truncated...]
```

**Good Pattern**:
```
Abstract LinkedIn banner. LEFT HALF: gray mist, scattered fading hexagons. RIGHT HALF: vibrant blue and orange crystalline grid, glowing core. NO PEOPLE NO FACES NO TEXT. Modern minimalist professional.
```

### 2. Forbidden Elements Must Be Explicit

**Problem**: Saying "NOT: faces" at the end often gets truncated or ignored.

**Solution**: Put "NO PEOPLE NO FACES NO TEXT" early in the prompt where it won't be truncated.

**Anti-Pattern**:
```
Visual concept: [long description]...
NOT: faces, people, text, cartoonish elements.
```

**Good Pattern**:
```
[Core concept]. NO PEOPLE NO FACES NO TEXT NO HANDS. [Visual description].
```

### 3. Abstract vs Literal

**Problem**: AI models default to literal interpretations. "Infrastructure" becomes server racks.

**Solution**: Explicitly state "ABSTRACT ONLY" or "PURELY ABSTRACT geometric".

**Anti-Pattern**:
```
Visualizing AI infrastructure with memory persistence.
```

**Good Pattern**:
```
PURELY ABSTRACT geometric visualization. Interlocking hexagonal grid representing infrastructure. NO literal objects.
```

### 4. Left-Right Composition

**Problem**: AI models often interpret "left" and "right" loosely, creating diagonal splits.

**Solution**: Use explicit terms like "LEFT HALF" and "RIGHT HALF" or accept diagonal as valid.

**Good Pattern**:
```
LEFT HALF: gray fog, diffuse shapes. RIGHT HALF: vibrant crystalline forms.
```

### 5. Color Specification

**What Works**:
- Explicit colors: "blue", "orange", "gray"
- Gradient descriptions: "transition from gray to vibrant orange"
- Mood-to-color mapping: "muted for passive, vibrant for active"

### 6. Professional Quality Signals

**Keywords that improve LinkedIn-appropriateness**:
- "Professional"
- "Modern minimalist"
- "Clean geometric"
- "Sophisticated"
- "LinkedIn banner"

### 7. Prompt Structure (Optimized for CLIP)

```
[Format + Context]. [Core visual concept]. [Color scheme]. [FORBIDDEN ELEMENTS]. [Quality modifiers].
```

**Example**:
```
Abstract LinkedIn banner. Interlocking hexagonal crystalline grid with glowing core. Blue and orange on gray background. NO PEOPLE NO FACES NO TEXT. Modern professional minimalist.
```

## Audit Rubric (95% Threshold)

| Category | Weight | Auto-Fail Triggers |
|----------|--------|-------------------|
| Text Artifacts | N/A | Any visible text |
| Forbidden Elements | N/A | People, faces, hands |
| Concept Alignment | 30% | Score < 7 |
| Professional Quality | 25% | Obvious AI artifacts |
| Color Palette | 15% | Wrong colors |
| Aesthetic Coherence | 15% | No focal point |
| Technical Quality | 15% | Pixelation/aliasing |

## Iteration Strategy

1. **First Pass**: Full visual-art-composition prompt (may truncate)
2. **If Score < 95%**: Shorten to < 77 tokens, front-load critical constraints
3. **If Still Failing**: Focus on the specific failing category

## Files Updated

- `image_auditor.py`: Default threshold changed from 70% to 95%
- `generate-blog-images.py`: Prompts updated with MANDATORY ABSTRACT ONLY sections
