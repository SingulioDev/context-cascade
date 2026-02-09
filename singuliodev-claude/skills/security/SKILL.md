

---
name: security
version: 2.2.0
description: |
  Security specialists hub for application security, vulnerability assessment, and secure coding. Routes to specialists for OWASP, penetration testing, and security hardening. Use for security audits, v
category: security
tags:
- general
author: system
---

# Security

Central hub for application security, vulnerability assessment, and secure coding practices.

## Phase 0: Expertise Loading

```yaml
expertise_check:
  domain: security
  file: .claude/expertise/security.yaml

  if_exists:
    - Load vulnerability patterns
    - Load OWASP guidelines
    - Apply security baselines

  if_not_exists:
    - Flag discovery mode
    - Document patterns learned
```

## Cognitive Frame Activation

### Kanitsal Guvenlik Denetimi (Evidential Security Audit)

Every security finding MUST include evidence. No vulnerabilities without proof.

**Evidence Structure**:
```yaml
vulnerability:
  id: VULN-001
  cve_cwe: "CWE-89 (SQL Injection)" or "CVE-2024-12345"
  lokasyon: "[file:line] src/api/users.js:42"
  kanit: |
    Proof of concept:
    curl -X POST /api/login -d "username=admin' OR '1'='1"
    Result: Bypassed authentication
  siddet: "CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H (Score: 9.8)"
  evidence_type: "[DOGRUDAN]"
```

**Evidence Type Taxonomy**:
- **[DOGRUDAN]** (Direct): Vulnerability directly exploited in testing
  - Example: Successfully injected SQL, achieved RCE
- **[CIKARIM]** (Inferred): Pattern analysis suggests vulnerability
  - Example: User input concatenated to query without sanitization
- **[BILDIRILEN]** (Reported): Scanner/tool detected issue
  - Example: npm audit flagged CVE-2024-12345

**Mandatory Fields**:
1. **CVE/CWE**: Standard vulnerability reference
2. **LOKASYON**: Exact code location [file:line]
3. **KANIT**: Proof of concept or exploit evidence
4. **SIDDET**: CVSS score with vector breakdown

### Al-Itar al-Sarfi lil-Amn (Security Attack Morphology)

Decompose attack vectors into root causes. Fix the ROOT, not symptoms.

**Attack Vector Decomposition Template**:
```yaml
attack_morphology:
  vector: "SQL Injection (A03:2021)"

  decomposition:
    ROOT:
      type: "Insufficient Input Validation"
      location: "src/db/queries.js"
      pattern: "String concatenation in SQL queries"

    DERIVED_1:
      from: ROOT
      type: "User-Controlled Query Parameter"
      location: "req.body.username (unvalidated)"

    DERIVED_2:
      from: ROOT
      type: "Missing Parameterized Queries"
      location: "db.query() uses template literals"

    DERIVED_3:
      from: DERIVED_1
      type: "No Allowlist Validation"
      location: "Username accepts special characters"

  remediation:
    target: ROOT
    fix: "Implement parameterized queries (prepared statements)"
    cascading_fixes:
      - "Add input validation schema (Joi/Yup)"
      - "Implement allowlist for usernames"
      - "Remove string concatenation in all queries"

    why_not_symptom: |
      Escaping special characters (DERIVED_3) treats symptom.
      Using parameterized queries (ROOT) prevents vulnerability class.
```

**Morphological Rules**:
1. **Identify ROOT cause** (the fundamental flaw)
2. **Map DERIVED vulnerabilities** (cascading from ROOT)
3. **Target ROOT in remediation** (fix once, prevent many)
4. **Explain why not symptom** (justify root cause focus)

## When to Use This Skill

Use security when:
- Auditing code for vulnerabilities
- Fixing security issues
- Implementing authentication/authorization
- Hardening infrastructure
- Security code review

## Security Finding Template (Evidence-Based)

Use this template for ALL security findings:

```yaml
finding:
  id: "VULN-{number}"
  title: "{Vulnerability Name}"

  # EVIDENTIAL REQUIREMENTS (Turkish Frame)
  evidence:
    cve_cwe: "CWE-{number} ({Name})" # or CVE-YYYY-NNNNN
    lokasyon: "[file:line] {path}:{line_number}"
    kanit: |
      {Proof of concept exploit}
      {Test results showing vulnerability}
    siddet: "CVSS:3.1/{vector_string} (Score: {0.0-10.0})"
    evidence_type: "[DOGRUDAN|CIKARIM|BILDIRILEN]"

  # MORPHOLOGICAL ANALYSIS (Arabic Frame)
  attack_morphology:
    vector: "{Attack Type} (OWASP {category})"
    decomposition:
      R

