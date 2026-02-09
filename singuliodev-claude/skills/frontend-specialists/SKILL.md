

---
name: frontend-specialists
version: 1.0.0
description: |
  Comprehensive frontend development system with specialist agents for React, Vue, UI components, CSS styling, accessibility, and performance optimization. Use when building modern web applications, com
category: Frontend Development
tags:
- specialists
- domain-expert
author: ruv
---

# Frontend Specialists

## When to Use This Skill

- **React/Vue/Angular Development**: Building modern frontend applications
- **Component Development**: Creating reusable UI components
- **State Management**: Implementing Redux, Zustand, Pinia, or other state solutions
- **Performance Optimization**: Improving render performance or bundle size
- **Accessibility**: Implementing WCAG-compliant interfaces
- **Responsive Design**: Building mobile-first or adaptive layouts

## When NOT to Use This Skill

- **Backend APIs**: Server-side logic or database operations
- **Static Sites**: Simple HTML/CSS without framework complexity
- **Native Mobile**: React Native, Flutter, Swift, Kotlin (use mobile specialist)
- **Design Work**: Visual design or UI/UX research (use designer)

## Success Criteria

- [ ] Components render correctly across browsers (Chrome, Firefox, Safari, Edge)
- [ ] Responsive design works on mobile, tablet, desktop
- [ ] Accessibility score >90 (axe-core, Lighthouse)
- [ ] Performance budget met (FCP <2s, LCP <2.5s, CLS <0.1)
- [ ] Unit tests passing for components
- [ ] E2E tests passing for user flows
- [ ] TypeScript types accurate with no any types
- [ ] Bundle size within limits

## Edge Cases to Handle

- **Hydration Mismatches**: SSR/SSG content differing from client render
- **Browser Differences**: Vendor prefixes, polyfills, or feature detection
- **Offline Support**: Service workers or offline-first functionality
- **Memory Leaks**: Event listeners, subscriptions, or timers not cleaned up
- **Large Lists**: Virtualization for rendering 1000+ items
- **Form Validation**: Complex multi-step forms with async validation

## Guardrails

- **NEVER** mutate state directly (use immutable updates)
- **ALWAYS** clean up effects (removeEventListener, unsubscribe)
- **NEVER** store sensitive data in localStorage
- **ALWAYS** sanitize user input before rendering (prevent XSS)
- **NEVER** skip key prop on list items
- **ALWAYS** use semantic HTML and ARIA labels
- **NEVER** block main thread with heavy computation (use Web Workers)

## Evidence-Based Validation

- [ ] Lighthouse audit score >90 in all categories
- [ ] React DevTools Profiler shows no unnecessary re-renders
- [ ] Bundle analyzer shows no duplicate dependencies
- [ ] axe-core accessibility scan passes
- [ ] Visual regression tests pass (Percy, Chromatic)
- [ ] Cross-browser testing (BrowserStack, Playwright)
- [ ] Console shows no errors or warnings

A comprehensive frontend development system combining specialized agents, production scripts, and reusable templates for modern web application development.

## Purpose

Provide complete frontend development capabilities through specialized agents and tools. Each specialist focuses on a specific domain (React, Vue, UI components, CSS, accessibility, performance) while sharing common scripts and templates for rapid development.

## System Architecture

```
frontend-specialists/
├── skill.md (this file)
├── react-specialist/      # React 18+ specialist
├── vue-specialist/        # Vue 3 specialist (future)
├── ui-component-builder/  # Component library specialist (future)
├── resources/
│   ├── scripts/           # Production automation scripts
│   │   ├── component-generator.js
│   │   ├── bundle-analyzer.js
│   │   ├── a11y-checker.js
│   │   └── performance-profiler.js
│   └── templates/         # Reusable component templates
│       ├── react-component.tsx
│       ├── vue-component.vue
│       └── component.config.json
└── tests/                 # Comprehensive test suites
    ├── component-generator.test.js
    ├── bundle-analyzer.test.js
    └── a11y-checker.test.js
```

## Available Specialists

### 1. React Specialist (`react-specialist`)
**Triggers**: "React", "React 18", "Next.js", "hooks", "server components"

**Capabilities**:
- React 18+ with concurrent rendering
- Next.js 13+ App Router with Server Components
- S

