#!/bin/bash
# Security Skill Prompt Improvements
# Applies evidence-based prompting patterns to all security skills

SKILL_DIR="C:/Users/17175/claude-code-plugins/ruv-sparc-three-loop-system/skills/security"
PROCESSED=0

# Function to detect skill type from filename and content
detect_skill_type() {
    local file="$1"
    local filename=$(basename "$file")
    local dir=$(dirname "$file")

    # Check filename patterns
    if [[ "$filename" == "SKILL.md" ]]; then
        if [[ "$dir" =~ compliance ]]; then
            echo "compliance"
        elif [[ "$dir" =~ reverse-engineering-deep ]]; then
            echo "reverse-engineering-deep"
        elif [[ "$dir" =~ reverse-engineering-firmware ]]; then
            echo "reverse-engineering-firmware"
        elif [[ "$dir" =~ reverse-engineering-quick ]]; then
            echo "reverse-engineering-quick"
        elif [[ "$dir" =~ network-security-setup ]]; then
            echo "network-security"
        elif [[ "$dir" =~ sandbox-configurator ]]; then
            echo "sandbox-security"
        elif [[ "$dir" =~ security-analyzer ]]; then
            echo "security-audit"
        else
            echo "general-security"
        fi
    elif [[ "$dir" =~ wcag-accessibility ]]; then
        echo "accessibility"
    elif [[ "$dir" =~ examples ]]; then
        echo "example"
    elif [[ "$dir" =~ references ]]; then
        echo "reference"
    elif [[ "$dir" =~ tests ]]; then
        echo "test"
    elif [[ "$dir" =~ resources ]]; then
        echo "resource"
    else
        echo "documentation"
    fi
}

# Function to generate security-specific content
generate_security_content() {
    local skill_type="$1"

    case "$skill_type" in
        compliance)
            cat <<'EOF'

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

- NEVER implement compliance controls on unauthorized systems
- NEVER collect or store PII/PHI without proper encryption and access controls
- NEVER bypass security controls to achieve compliance scores
- NEVER generate false compliance evidence or documentation
- ALWAYS document evidence collection methods with timestamps
- ALWAYS validate controls through independent testing
- ALWAYS obtain legal review for compliance interpretations
- ALWAYS maintain audit trails for all compliance activities
- ALWAYS use encryption at rest and in transit for sensitive data
- ALWAYS implement least-privilege access for compliance tools

## Evidence-Based Validation

All compliance findings MUST be validated through:
1. **Automated scanning** - Use compliance scanning tools with documented results
2. **Manual verification** - Independent review of at least 20% of automated findings
3. **Evidence collection** - Screenshots, logs, configurations with timestamps
4. **Cross-validation** - Multiple methods confirm same finding (tool + manual + audit)
5. **Expert review** - Compliance specialist validates critical findings
6. **Remediation testing** - Verify fixes resolve violations without introducing new gaps
EOF
            ;;
        reverse-engineering-deep|reverse-engineering-firmware|reverse-engineering-quick)
            cat <<'EOF'

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

- NEVER execute unknown binaries on host systems (ONLY in isolated VM/sandbox)
- NEVER analyze malware without proper containment (air-gapped lab preferred)
- NEVER reverse engineer software without legal authorization
- NEVER share extracted credentials or encryption keys publicly
- NEVER bypass licensing mechanisms for unauthorized use
- ALWAYS use sandboxed environments with network monitoring
- ALWAYS take VM snapshots before executing suspicious binaries
- ALWAYS validate findings through multiple analysis methods
- ALWAYS document analysis methodology with timestamps
- ALWAYS assume binaries are malicious until proven safe
- ALWAYS use network isolation to prevent malware communication
- ALWAYS sanitize IOCs before sharing (redact internal IP addresses)

## Evidence-Based Validation

All reverse engineering findings MUST be validated through:
1. **Multi-method analysis** - Static + dynamic + symbolic execution confirm same behavior
2. **Sandbox validation** - Execute in isolated environment, capture all activity
3. **Network monitoring** - Packet capture validates network-based findings
4. **Memory forensics** - Validate runtime secrets through memory dumps
5. **Behavioral correlation** - Cross-reference with known malware signatures (YARA, ClamAV)
6. **Reproducibility** - Second analyst can replicate findings from analysis artifacts
EOF
            ;;
        network-security|sandbox-security)
            cat <<'EOF'

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

- NEVER disable network isolation without security review
- NEVER add untrusted domains to whitelist without validation
- NEVER store secrets (API keys, passwords) in sandbox configuration files
- NEVER bypass proxy settings to access restricted resources
- NEVER allow wildcard domain patterns without justification (*.com = insecure)
- ALWAYS validate domain ownership before whitelisting
- ALWAYS use HTTPS for external domains (enforce TLS)
- ALWAYS document why each domain is trusted (justification required)
- ALWAYS test that untrusted domains are blocked (negative testing)
- ALWAYS use environment variable references for secrets (not plaintext)
- ALWAYS maintain audit logs of network policy changes
- ALWAYS validate network policies after configuration changes

## Evidence-Based Validation

All network security configurations MUST be validated through:
1. **Positive testing** - Verify approved domains accessible (npm install, git clone)
2. **Negative testing** - Verify untrusted domains blocked (curl random-website.com fails)
3. **Proxy validation** - Confirm traffic routes through corporate proxy where required
4. **Secret scanning** - Automated scan for credentials in configuration files
5. **Build validation** - End-to-end build succeeds with network policy applied
6. **Penetration testing** - Attempt data exfiltration to verify isolation
EOF
            ;;
        security-audit)
            cat <<'EOF'

## When to Use This Skill

Use this skill when conducting comprehensive security audits, performing vulnerability assessments, analyzing application security posture, identifying security misconfigurations, validating security controls, or preparing for penetration testing engagements.

## When NOT to Use This Skill

Do NOT use for compliance audits (use compliance skill instead), unauthorized security testing, production system scanning without approval, vulnerability exploitation (only identification), or automated scanning without manual validation. Avoid for code quality audits unrelated to security.

## Success Criteria

- All security vulnerabilities identified with CVSS scores and remediation guidance
- Security misconfigurations documented with severity ratings
- Attack surface mapped (exposed services, authentication mechanisms, data flows)
- Security controls validated (authentication, authorization, encryption, logging)
- Vulnerability remediation plan created with prioritization
- Zero critical/high vulnerabilities remaining after remediation
- Security findings validated through manual testing (not just automated scans)
- Penetration testing readiness achieved (all low-hanging fruit addressed)

## Edge Cases & Challenges

- False positives from automated security scanners
- Zero-day vulnerabilities without CVE mappings
- Business logic vulnerabilities requiring manual analysis
- Authentication bypass through indirect paths
- Encrypted communications requiring SSL interception
- Cloud-specific security misconfigurations (S3 buckets, IAM roles)
- Supply chain vulnerabilities in dependencies
- Time-of-check to time-of-use (TOCTOU) race conditions

## Guardrails (CRITICAL SECURITY RULES)

- NEVER exploit vulnerabilities beyond proof-of-concept validation
- NEVER conduct security testing on unauthorized systems
- NEVER exfiltrate sensitive data during security assessments
- NEVER cause denial-of-service or system instability
- NEVER share vulnerability details publicly before responsible disclosure
- ALWAYS obtain written authorization before security testing
- ALWAYS document findings with remediation guidance
- ALWAYS validate vulnerabilities through manual testing
- ALWAYS follow responsible disclosure timelines (90 days standard)
- ALWAYS maintain confidentiality of security findings
- ALWAYS use non-destructive testing methods where possible
- ALWAYS preserve audit trails of security testing activities

## Evidence-Based Validation

All security findings MUST be validated through:
1. **Automated scanning** - Multiple tools confirm vulnerability (Nessus, Burp, OWASP ZAP)
2. **Manual validation** - Security analyst reproduces finding independently
3. **Proof-of-concept** - Demonstrate exploitability without causing harm
4. **Code review** - Validate vulnerability at source code level
5. **Attack path analysis** - Document complete attack chain from entry to impact
6. **Remediation testing** - Verify fix resolves vulnerability without introducing new issues
EOF
            ;;
        accessibility)
            cat <<'EOF'

## When to Use This Skill

Use this skill when validating WCAG 2.1/2.2 compliance, implementing accessibility features (screen reader support, keyboard navigation), conducting accessibility audits, remediating accessibility violations, or preparing for accessibility certification (Section 508, ADA compliance).

## When NOT to Use This Skill

Do NOT use for general UI/UX design (use frontend specialists instead), performance optimization unrelated to accessibility, compliance audits for non-accessibility regulations, or browser compatibility testing (use cross-browser testing tools). Avoid for backend API accessibility (focus on frontend).

## Success Criteria

- WCAG compliance level achieved (A, AA, or AAA with 100% pass rate)
- All accessibility violations remediated with validation tests
- Screen reader compatibility validated (JAWS, NVDA, VoiceOver)
- Keyboard navigation complete (no mouse-only interactions)
- Color contrast ratios meet WCAG standards (4.5:1 for normal text, 3:1 for large)
- Automated accessibility testing integrated into CI/CD pipeline
- Accessibility documentation created for developers
- Manual accessibility testing completed by users with disabilities

## Edge Cases & Challenges

- Dynamic content (modals, tooltips) requiring ARIA live regions
- Complex interactive widgets (drag-and-drop, sliders) requiring custom ARIA
- Single-page applications (SPAs) with client-side routing
- Infinite scroll and lazy loading accessibility
- Video and audio content requiring captions/transcripts
- Third-party components without accessibility support
- Mobile accessibility (touch targets, screen reader gestures)
- Internationalization affecting accessibility (RTL languages)

## Guardrails (CRITICAL ACCESSIBILITY RULES)

- NEVER use automated testing alone (manual validation required)
- NEVER assume compliance without user testing (involve people with disabilities)
- NEVER hide content from screen readers for aesthetic reasons
- NEVER rely solely on color to convey information
- NEVER create keyboard traps (focus must be escapable)
- ALWAYS provide text alternatives for non-text content
- ALWAYS ensure keyboard accessibility for all functionality
- ALWAYS maintain logical focus order and visual focus indicators
- ALWAYS test with actual assistive technologies (not just simulators)
- ALWAYS provide captions and transcripts for multimedia
- ALWAYS validate HTML semantics (use semantic elements correctly)
- ALWAYS document accessibility features and testing methodology

## Evidence-Based Validation

All accessibility implementations MUST be validated through:
1. **Automated testing** - axe DevTools, WAVE, Lighthouse confirm WCAG compliance
2. **Manual testing** - Navigate entire application with keyboard only
3. **Screen reader testing** - Test with JAWS, NVDA, VoiceOver on all major features
4. **User testing** - People with disabilities validate usability
5. **Code review** - Validate proper ARIA usage and semantic HTML
6. **Contrast analysis** - All color combinations meet WCAG contrast ratios
EOF
            ;;
        example|test)
            cat <<'EOF'

## Purpose

This file provides example implementations and test cases for security skills, demonstrating proper usage patterns, validation methods, and expected outcomes.

## Guardrails

- NEVER use example configurations in production without customization
- NEVER store real credentials or sensitive data in example files
- ALWAYS validate examples against current security best practices
- ALWAYS update examples when security standards change
- ALWAYS include comments explaining security-critical sections
EOF
            ;;
        reference|resource|documentation)
            cat <<'EOF'

## Purpose

This reference material provides supporting documentation for security skills, including compliance frameworks, security standards, tool documentation, and best practices.

## Guardrails

- NEVER rely solely on reference material without validating current standards
- NEVER assume reference material is complete (cross-check with official sources)
- ALWAYS verify reference material is up-to-date (security standards evolve)
- ALWAYS link to authoritative sources for compliance requirements
- ALWAYS note publication dates and version numbers for standards
EOF
            ;;
        *)
            cat <<'EOF'

## When to Use

Use this for security-related tasks requiring specialized domain knowledge, threat modeling, vulnerability assessment, or secure configuration management.

## When NOT to Use

Do NOT use for unauthorized security testing, production systems without approval, or tasks outside security domain.

## Success Criteria

- Security objectives achieved with validation evidence
- Vulnerabilities identified and remediated
- Security controls implemented and tested
- Documentation complete with audit trails

## Edge Cases

- Environment-specific security requirements
- Legacy system constraints
- Compliance framework conflicts
- Third-party security dependencies

## Guardrails (CRITICAL SECURITY RULES)

- NEVER conduct unauthorized security testing
- NEVER store credentials in configuration files
- NEVER bypass security controls without documented justification
- ALWAYS validate findings through multiple methods
- ALWAYS maintain audit trails of security activities
- ALWAYS follow responsible disclosure for vulnerabilities
- ALWAYS obtain proper authorization before security testing

## Evidence-Based Validation

All security findings MUST be validated through multiple independent methods with documented evidence and reproducible test cases.
EOF
            ;;
    esac
}

# Process each markdown file
find "$SKILL_DIR" -name "*.md" -type f | while read -r file; do
    echo "Processing: $file"

    # Detect skill type
    skill_type=$(detect_skill_type "$file")
    echo "  Detected type: $skill_type"

    # Check if file has YAML frontmatter
    if head -n 1 "$file" | grep -q '^---$'; then
        # Find end of YAML frontmatter
        frontmatter_end=$(awk '/^---$/{if(NR>1){print NR; exit}}' "$file")

        if [ -n "$frontmatter_end" ] && [ "$frontmatter_end" -gt 1 ]; then
            # Create temporary file with improvements
            temp_file="${file}.tmp"

            # Extract frontmatter
            head -n "$frontmatter_end" "$file" > "$temp_file"

            # Add security-specific content
            generate_security_content "$skill_type" >> "$temp_file"

            # Add original content after frontmatter
            tail -n +$((frontmatter_end + 1)) "$file" >> "$temp_file"

            # Replace original file
            mv "$temp_file" "$file"

            ((PROCESSED++))
            echo "  ✓ Applied improvements (type: $skill_type)"
        else
            echo "  ✗ Could not find frontmatter end"
        fi
    else
        echo "  ✗ No YAML frontmatter found, skipping"
    fi
done

echo ""
echo "========================================="
echo "Processing complete!"
echo "Total files processed: $PROCESSED"
echo "========================================="
