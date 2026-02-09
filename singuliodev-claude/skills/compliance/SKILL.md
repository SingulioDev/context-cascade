

---
name: compliance
version: 1.0.0
description: |
  Regulatory compliance validation and documentation for GDPR, HIPAA, SOC 2, PCI-DSS, and ISO 27001. Use when implementing compliance controls, conducting compliance audits, or preparing for certificati
category: security
tags:
- security
- compliance
- safety
author: ruv
---

## When to Use This Skill

Use this skill when conducting compliance audits, implementing regulatory controls, preparing for certification audits, validating GDPR/HIPAA/SOC2/PCI-DSS/ISO27001 adherence, or documenting security and privacy practices for regulated industries.

## When NOT to Use This Skill

Do NOT use for non-regulated applications, internal tools without compliance requirements, proof-of-concept projects, or general security audits (use security-analyzer instead). Avoid using for unauthorized compliance testing of third-party systems.

## Success Criteria
- All applicable regulatory requirements identified with evidence mapping
- Compliance gaps documented with severity ratings (critical/high/medium/low)
- Controls implemented with validation tests (automated where possible)
- Evidence collection automated with audit trail timestamps
- Remediation plans created for all gaps with assigned owners
- Compliance score >90% for target framework
- Zero critical violations remaining before certification

## Edge Cases & Challenges

- Multi-jurisdiction compliance (GDPR + CCPA + local regulations)
- Legacy systems without compliance documentation
- Third-party services requiring BAA/DPA agreements
- Encrypted data requiring key escrow for compliance
- Real-time compliance monitoring vs periodic audits
- Conflicting requirements between frameworks
- Continuous compliance vs point-in-time certification

## Guardrails (CRITICAL SECURITY RULES)
- NEVER: implement compliance controls on unauthorized systems
- NEVER: collect or store PII/PHI without proper encryption and access controls
- NEVER: bypass security controls to achieve compliance scores
- NEVER: generate false compliance evidence or documentation
- ALWAYS: document evidence collection methods with timestamps
- ALWAYS: validate controls through independent testing
- ALWAYS: obtain legal review for compliance interpretations
- ALWAYS: maintain audit trails for all compliance activities
- ALWAYS: use encryption at rest and in transit for sensitive data
- ALWAYS: implement least-privilege access for compliance tools

## Evidence-Based Validation

All compliance findings MUST be validated through:
1. **Automated scanning** - Use compliance scanning tools with documented results
2. **Manual verification** - Independent review of at least 20% of automated findings
3. **Evidence collection** - Screenshots, logs, configurations with timestamps
4. **Cross-validation** - Multiple methods confirm same finding (tool + manual + audit)
5. **Expert review** - Compliance specialist validates critical findings
6. **Remediation testing** - Verify fixes resolve violations without introducing new gaps

# Compliance - Regulatory Standards Validation

