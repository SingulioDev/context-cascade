

---
name: ml
version: 2.0.0
description: |
  Machine Learning development workflow with experiment tracking, hyperparameter optimization, and MLOps integration
category: specialized-development
tags:
- machine-learning
- mlops
- experiment-tracking
- hyperparameter-tuning
- model-registry
author: ruv
---

# ML Development Skill

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

Comprehensive machine learning development workflow with enterprise-grade experiment tracking, automated hyperparameter optimization, model registry management, and production MLOps pipelines.

## Overview

This Gold-tier skill provides a complete ML development lifecycle with:
- **Experiment Tracking**: MLflow/W&B integration for reproducible experiments
- **Hyperparameter Optimization**: Optuna/Ray Tune for automated tuning
- **Model Registry**: Centralized model versioning and deployment
- **MLOps Pipeline**: Production-ready model serving and monitoring

## Quick Start

```bash
# Initialize ML project
npx claude-flow sparc run ml "Create ML project for image classification"

# Track experiment
python resources/scripts/experiment-tracker.py --config experiment-config.yaml

# Optimize hyperparameters
node resources/scripts/hyperparameter-tuner.js --space hyperparameter-space.json

# Deploy model
bash resources/scripts/model-registry.sh deploy production latest
```

## Workflow Phases

### 1. Experiment Design
- Define hypothesis and metrics
- Configure experiment tracking
- Set up data pipelines
- Validate data quality

### 2. Model Development
- Implement model architecture
- Configure training pipeline
- Set up validation strategy
- Enable experiment logging

### 3. Hyperparameter Optimization
- Define search space
- Select optimization algorithm
- Run distributed trials
- Analyze results

### 4. Model Evaluation
- Comprehensive metrics analysis
-

