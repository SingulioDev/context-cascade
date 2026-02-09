

---
name: prompt-architect
version: 3.0.0
description: |
  Meta-loop skill for prompt optimization using VERILINGUA x VERIX
category: foundry
tags:
- general
triggers:
  - "when optimizing prompts"
author: system
---

  name: "prompt-architect",
  role: "meta-loop-optimizer",
  phase: 2,
  layer: L1
)

  cascade: commands -> agents -> skills -> playbooks,
  method: dogfooding,
  validation: self-application
)

  (intent = agent_system_prompt) -> route(agent-creator) AND
  (intent = improve_system_prompt) -> route(prompt-forge) AND
  (intent = create_skill) -> route(skill-creator-agent) AND
  (intent = improve_this) -> route(skill-forge) AND
  (intent = user_prompt) -> route(prompt-architect)
)

  source: "Turkish -mis/-di",
  force: "How do you know?",
  markers: {
    witnessed: "directly observed/verified",
    reported: "learned from source",
    inferred: "deduced logically",
    assumed: "explicit assumption with confidence"
  },
  weight: 0.15,
  immutable_minimum: 0.30
}

  source: "Russian perfective/imperfective",
  force: "Complete or ongoing?",
  markers: {
    complete: "action finished",
    ongoing: "action in progress",
    habitual: "repeating regularly",
    attempted: "tried, outcome pending"
  },
  weight: 0.12
}

  source: "Arabic trilateral roots",
  force: "What are the root components?",
  markers: {
    root: "semantic kernel",
    derived: "concept derived from root",
    composed: "components combined"
  },
  weight: 0.10
}

  source: "German compounding",
  force: "Build from primitives?",
  markers: {
    primitive: "basic building block",
    compound: "primitives combined",
    builds: "compositional hierarchy"
  },
  weight: 0.10
}

  source: "Japanese keigo",
  force: "Who is the audience?",
  markers: {
    audience

