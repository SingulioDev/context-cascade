

---
name: ml-training-debugger
version: 1.0.0
description: |
  **Version**: 1.0.0
category: specialists
tags:
- specialists
- domain-expert
triggers:
  - "when debugging ml training"
  - "when debugging ml training"
author: ruv
---

# ML Training Debugger

## When to Use This Skill

- **Model Training**: Training neural networks or ML models
- **Hyperparameter Tuning**: Optimizing model performance
- **Model Debugging**: Diagnosing training issues (overfitting, vanishing gradients)
- **Data Pipeline**: Building training/validation data pipelines
- **Experiment Tracking**: Managing ML experiments and metrics
- **Model Deployment**: Serving models in production

## When NOT to Use This Skill

- **Data Analysis**: Exploratory data analysis or statistics (use data scientist)
- **Data Engineering**: Large-scale ETL or data warehouse (use data engineer)
- **Research**: Novel algorithm development (use research specialist)
- **Simple Rules**: Heuristic-based logic without ML

## Success Criteria

- [ ] Model achieves target accuracy/F1/RMSE on validation set
- [ ] Training/validation curves show healthy convergence
- [ ] No overfitting (train/val gap <5%)
- [ ] Inference latency meets production requirements
- [ ] Model size within deployment constraints
- [ ] Experiment tracked with metrics and artifacts (MLflow, Weights & Biases)
- [ ] Reproducible results (fixed random seeds, versioned data)

## Edge Cases to Handle

- **Class Imbalance**: Unequal class distribution requiring resampling
- **Data Leakage**: Information from validation/test leaking into training
- **Catastrophic Forgetting**: Model forgetting old tasks when learning new ones
- **Adversarial Examples**: Model vulnerable to adversarial attacks
- **Distribution Shift**: Training data differs from production data
- **Hardware Constraints**: GPU memory limitations or mixed precision training

## Guardrails

- **NEVER** evaluate on training data
- **ALWAYS** use separate train/validation/test splits
- **NEVER** touch test set until final evaluation
- **ALWAYS** version datasets and models
- **NEVER** deploy without monitoring for data drift
- **ALWAYS** document model assumptions and limitations
- **NEVER** train on biased or unrepresentative data

## Evidence-Based Validation

- [ ] Confusion matrix reviewed for class-wise performance
- [ ] Learning curves plotted (loss vs epochs)
- [ ] Validation metrics tracked across experiments
- [ ] Model profiled for inference time (TensorBoard, PyTorch Profiler)
- [ ] Ablation studies conducted for architecture choices
- [ ] Cross-validation performed for robust evaluation
- [ ] Statistical significance tested (t-test, bootstrap)

**Version**: 1.0.0
**Type**: Agent-based skill with SDK implementation
**Domain**: Machine learning training diagnostics

## Description

Diagnose machine learning training failures including loss divergence, mode collapse, gradient issues, architecture problems, and optimization failures. This skill spawns a specialist ML debugging agent that systematically analyzes training artifacts to identify root causes and propose evidence-based fixes.

Use this skill when encountering training failures, when loss curves exhibit pathological behavior, when models produce degenerate outputs, when experiencing GPU memory issues, or when hyperparameter tuning produces inconsistent results.

## Triggers

This skill activates when users request:
- "Debug my training run"
- "Why is my loss diverging?"
- "Model outputs are all the same token"
- "Training failed at epoch X"
- "Help diagnose mode collapse"
- "Why are gradients exploding/vanishing?"
- "Model not learning anything"

## Skill Architecture

### Skill Layer (Lightweight)
The skill handles:
1. **Detection**: Identify ML training debugging requests
2. **Context Gathering**: Collect training logs, loss curves, model code
3. **Agent Spawning**: Invoke ML debugging specialist with context
4. **Result Processing**: Format diagnosis and fixes for user

### Agent Layer (Specialist)
The ML debugging agent handles:
1. **Systematic Analysis**: Apply debugging methodology to artifacts
2. **Root Cause Identification**: D

