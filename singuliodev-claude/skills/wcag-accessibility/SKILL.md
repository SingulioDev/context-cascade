

---
name: wcag-accessibility
version: 1.0.0
description: |
  WCAG 2.1 AA/AAA accessibility compliance specialist for ARIA attributes, keyboard navigation, screen reader testing, color contrast validation, semantic HTML, and automated a11y testing with axe-core/
category: Compliance
tags:
- general
author: system
---

# WCAG Accessibility Specialist

Expert web accessibility implementation for WCAG 2.1 AA/AAA compliance and inclusive design.

## Purpose

Comprehensive accessibility expertise including ARIA attributes, keyboard navigation, screen reader compatibility, color contrast, semantic HTML, and automated testing. Ensures web applications are usable by people with disabilities and meet legal requirements.

## When to Use

- Implementing WCAG 2.1 AA or AAA compliance
- Fixing accessibility violations found in audits
- Building accessible components and forms
- Testing with screen readers (NVDA, JAWS, VoiceOver)
- Meeting ADA or Section 508 legal requirements
- Implementing keyboard-only navigation
- Optimizing for assistive technologies

## Prerequisites

**Required**: HTML/CSS, JavaScript basics, understanding of semantic HTML

**Agents**: `tester`, `reviewer`, `code-analyzer`, `coder`

## Core Workflows

### Workflow 1: Accessible Form Implementation

**Step 1: Semantic HTML with Labels**

```html
<!-- ✅ GOOD: Proper labels and structure -->
<form>
  <div class="form-group">
    <label for="email">Email Address *</label>
    <input
      type="email"
      id="email"
      name="email"
      required
      aria-required="true"
      aria-describedby="email-help email-error"
    />
    <small id="email-help">We'll never share your email.</small>
    <span id="email-error" role="alert" aria-live="polite"></span>
  </div>

  <fieldset>
    <legend>Choose your plan</legend>
    <div>
      <input type="radio" id="plan-free" name="plan" value="free" />
      <label for="plan-free">Free</label>
    </div>
    <div>
      <input type="radio" id="plan-pro" name="plan" value="pro" />
      <label for="plan-pro">Pro</label>
    </div>
  </fieldset>

  <button type="submit">Subscribe</button>
</form>

<!-- ❌ BAD: No labels, placeholder only -->
<form>
  <input type="email" placeholder="Email" />
  <input type="text" placeholder="Plan" />
  <button>Submit</button>
</form>
```

**Step 2: Client-Side Validation with Accessibility**

```javascript
const form = document.querySelector('form');
const emailInput = document.getElementById('email');
const emailError = document.getElementById('email-error');

emailInput.addEventListener('blur', () => {
  if (!emailInput.validity.valid) {
    emailError.textContent = 'Please enter a valid email address.';
    emailInput.setAttribute('aria-invalid', 'true');
  } else {
    emailError.textContent = '';
    emailInput.removeAttribute('aria-invalid');
  }
});
```

### Workflow 2: Keyboard Navigation

**Step 1: Focus Management**

```javascript
// Modal with focus trap
class AccessibleModal {
  constructor(modalElement) {
    this.modal = modalElement;
    this.focusableElements = this.modal.querySelectorAll(
      'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    );
    this.firstFocusable = this.focusableElements[0];
    this.lastFocusable = this.focusableElements[this.focusableElements.length - 1];
  }

  open() {
    this.previouslyFocused = document.activeElement;
    this.modal.setAttribute('aria-hidden', 'false');
    this.modal.addEventListener('keydown', this.trapFocus.bind(this));
    this.firstFocusable.focus();
  }

  close() {
    this.modal.setAttribute('aria-hidden', 'true');
    this.modal.removeEventListener('keydown', this.trapFocus);
    this.previouslyFocused.focus();
  }

  trapFocus(e) {
    if (e.key === 'Tab') {
      if (e.shiftKey) {
        if (document.activeElement === this.firstFocusable) {
          e.preventDefault();
          this.lastFocusable.focus();
        }
      } else {
        if (document.activeElement === this.lastFocusable) {
          e.preventDefault();
          this.firstFocusable.focus();
        }
      }
    }
    if (e.key === 'Escape') {
      this.close();
    }
  }
}
```

**Step 2: Skip Links**

```html
<body>
  <a href="#main-content" class="ski

