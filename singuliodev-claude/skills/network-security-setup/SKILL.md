

---
name: network-security-setup
version: 1.0.0
description: |
  Configure Claude Code sandbox network isolation with trusted domains, custom access policies, and environment variables
category: security
tags:
- security
- network
- isolation
- trusted-domains
- configuration
triggers:
  - "when setting network security"
author: ruv
---

## When to Use This Skill

Use this skill when configuring sandbox network isolation, setting up trusted domain whitelists, implementing zero-trust network policies for AI code execution, configuring corporate proxies and internal registries, or preventing data exfiltration through network controls.

## When NOT to Use This Skill

Do NOT use for production network security (use infrastructure-as-code instead), configuring firewall rules on live systems, bypassing organizational network policies, or setting up VPNs and network routing (use networking specialists). Avoid for troubleshooting network connectivity issues unrelated to sandbox security.

## Success Criteria
- Trusted domain whitelist validated (all required domains accessible, untrusted blocked)
- Network isolation prevents data exfiltration attacks (tested with simulated exfil)
- Internal registries accessible through proper proxy configuration
- Environment variables secured (no secrets in config files)
- Zero false positives (legitimate development work unblocked)
- Package installations succeed from approved registries
- Build and deployment commands execute without network errors
- Validation tests pass (npm install, git clone, API calls to approved domains)

## Edge Cases & Challenges

- Corporate proxies requiring NTLM authentication
- Split-tunnel VPNs with mixed internal/external traffic
- CDN domains changing dynamically (*.cloudfront.net wildcards)
- WebSocket connections requiring separate allowlisting
- DNS resolution failures in isolated environments
- IPv6 vs IPv4 routing differences
- Localhost binding restrictions breaking development servers
- Proxy auto-configuration (PAC) files with complex logic

## Guardrails (CRITICAL SECURITY RULES)
- NEVER: disable network isolation without security review
- NEVER: add untrusted domains to whitelist without validation
- NEVER: store secrets (API keys, passwords) in sandbox configuration files
- NEVER: bypass proxy settings to access restricted resources
- NEVER: allow wildcard domain patterns without justification (*.com = insecure)
- ALWAYS: validate domain ownership before whitelisting
- ALWAYS: use HTTPS for external domains (enforce TLS)
- ALWAYS: document why each domain is trusted (justification required)
- ALWAYS: test that untrusted domains are blocked (negative testing)
- ALWAYS: use environment variable references for secrets (not plaintext)
- ALWAYS: maintain audit logs of network policy changes
- ALWAYS: validate network policies after configuration changes

## Evidence-Based Validation

All network security configurations MUST be validate

