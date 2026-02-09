

---
name: reverse-engineering-firmware-analysis
version: 1.0.0
description: |
  Firmware extraction and IoT security analysis (RE Level 5) for routers and embedded systems. Use when analyzing IoT firmware, extracting embedded filesystems (SquashFS/JFFS2/CramFS), finding hardcoded
category: IoT Security, Embedded Systems, Firmware Reverse Engineering
tags:
- security
- compliance
- safety
author: ruv
---

## When to Use This Skill

Use this skill when analyzing malware samples, reverse engineering binaries for security research, conducting vulnerability assessments, extracting IOCs from suspicious files, validating software for supply chain security, or performing CTF challenges and binary exploitation research.

## When NOT to Use This Skill

Do NOT use for unauthorized reverse engineering of commercial software, analyzing binaries on production systems, reversing software without legal authorization, violating terms of service or EULAs, or analyzing malware outside isolated environments. Avoid for simple string extraction (use basic tools instead).

## Success Criteria
- All security-relevant behaviors identified (network, file, registry, process activity)
- Malicious indicators extracted with confidence scores (IOCs, C2 domains, encryption keys)
- Vulnerabilities documented with CVE mapping where applicable
- Analysis completed within sandbox environment (VM/container with snapshots)
- Findings validated through multiple analysis methods (static + dynamic + symbolic)
- Complete IOC report generated (STIX/MISP format for threat intelligence sharing)
- Zero false positives in vulnerability assessments
- Exploitation proof-of-concept created (if vulnerability research)

## Edge Cases & Challenges

- Anti-analysis techniques (debugger detection, VM detection, timing checks)
- Obfuscated or packed binaries requiring unpacking
- Multi-stage malware with encrypted payloads
- Kernel-mode rootkits requiring specialized analysis
- Symbolic execution state explosion (>10,000 paths)
- Binary analysis timeout on complex programs (>24 hours)
- False positives from legitimate software behavior
- Encrypted network traffic requiring SSL interception

## Guardrails (CRITICAL SECURITY RULES)
- NEVER: execute unknown binaries on host systems (ONLY in isolated VM/sandbox)
- NEVER: analyze malware without proper containment (air-gapped lab preferred)
- NEVER: reverse engineer software without legal authorization
- NEVER: share extracted credentials or encryption keys publicly
- NEVER: bypass licensing mechanisms for unauthorized use
- ALWAYS: use sandboxed environments with network monitoring
- ALWAYS: take VM snapshots before executing suspicious binaries
- ALWAYS: validate findings through multiple analysis methods
- ALWAYS: document analysis methodology with timestamps
- ALWAYS: assume binaries are malicious until proven safe
- ALWAYS: use network isolation to prevent malware communication
- ALWAYS: sanitize IOCs before sharing (redact internal IP addresses)

## Evidence-Based Validati

