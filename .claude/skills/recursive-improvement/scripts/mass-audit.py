#!/usr/bin/env python3
"""
Mass Audit Script for Skills, Agents, and Commands
Part of the Recursive Improvement System v2.2.0
"""

import os
import re
import json
import yaml
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Any

# Configuration
SKILLS_PATH = Path(os.path.expanduser("~/.claude/skills"))
AGENTS_PATH = Path(os.path.expanduser("~/claude-code-plugins/ruv-sparc-three-loop-system/agents"))
COMMANDS_PATH = Path(os.path.expanduser("~/.claude"))

class AuditResult:
    def __init__(self, name: str, path: str, category: str):
        self.name = name
        self.path = path
        self.category = category
        self.checks = {}
        self.score = 0.0
        self.priority = "P3"
        self.issues = []
        self.recommendations = []

    def to_dict(self) -> Dict:
        return {
            "name": self.name,
            "path": self.path,
            "category": self.category,
            "checks": self.checks,
            "score": self.score,
            "priority": self.priority,
            "issues": self.issues,
            "recommendations": self.recommendations
        }


def extract_frontmatter(content: str) -> Dict:
    """Extract YAML frontmatter from markdown file."""
    match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
    if match:
        try:
            return yaml.safe_load(match.group(1)) or {}
        except yaml.YAMLError:
            return {}
    return {}


def audit_skill(skill_path: Path) -> AuditResult:
    """Audit a single skill."""
    skill_md = skill_path / "SKILL.md"
    if not skill_md.exists():
        return None

    result = AuditResult(
        name=skill_path.name,
        path=str(skill_path),
        category="skill"
    )

    content = skill_md.read_text(encoding='utf-8', errors='ignore')
    frontmatter = extract_frontmatter(content)

    # Check: Has frontmatter
    result.checks["has_frontmatter"] = bool(frontmatter)
    if not frontmatter:
        result.issues.append("Missing YAML frontmatter")

    # Check: Has name
    result.checks["has_name"] = "name" in frontmatter
    if not result.checks["has_name"]:
        result.issues.append("Missing 'name' in frontmatter")

    # Check: Has version
    result.checks["has_version"] = "version" in frontmatter
    if not result.checks["has_version"]:
        result.issues.append("Missing 'version' in frontmatter")
        result.recommendations.append("Add version field to frontmatter")

    # Check: Has description
    result.checks["has_description"] = "description" in frontmatter
    desc_words = len(frontmatter.get("description", "").split())
    result.checks["description_length"] = desc_words
    if desc_words < 80:
        result.issues.append(f"Description too short ({desc_words} words, need 80-150)")
        result.recommendations.append("Expand description to 80-150 words")

    # Check: Has Phase 0
    result.checks["has_phase_0"] = "Phase 0" in content or "phase 0" in content.lower()
    if not result.checks["has_phase_0"]:
        result.issues.append("Missing Phase 0 (Expertise Loading)")
        result.recommendations.append("Add Phase 0: Expertise Loading section")

    # Check: Has contracts
    result.checks["has_contracts"] = "input" in content.lower() and "output" in content.lower()
    if not result.checks["has_contracts"]:
        result.recommendations.append("Add Input/Output contracts")

    # Check: Has error handling
    result.checks["has_error_handling"] = "error" in content.lower() or "failure" in content.lower()

    # Check: Uses imperative voice (heuristic)
    non_imperative = len(re.findall(r'\byou (should|must|need to|can)\b', content, re.IGNORECASE))
    result.checks["imperative_violations"] = non_imperative
    if non_imperative > 5:
        result.issues.append(f"Non-imperative voice detected ({non_imperative} occurrences)")

    # Check: Has GraphViz diagram
    dot_files = list(skill_path.glob("*.dot"))
    result.checks["has_graphviz"] = len(dot_files) > 0
    if not result.checks["has_graphviz"]:
        result.recommendations.append("Add GraphViz process diagram")

    # Check: Has changelog
    result.checks["has_changelog"] = (skill_path / "CHANGELOG.md").exists()
    if not result.checks["has_changelog"]:
        result.recommendations.append("Add CHANGELOG.md for version history")

    # Calculate score
    checks_passed = sum(1 for v in result.checks.values() if v is True or (isinstance(v, int) and v >= 80))
    total_checks = len([k for k in result.checks if not k.endswith("_violations") and not k.endswith("_length")])
    result.score = round(checks_passed / max(total_checks, 1), 2)

    # Determine priority
    if result.name in ["skill-forge", "agent-creator", "prompt-architect", "bootstrap-loop", "eval-harness"]:
        result.priority = "P0"
    elif result.name in ["intent-analyzer", "cascade-orchestrator", "parallel-swarm-implementation", "functionality-audit"]:
        result.priority = "P1"
    elif "github" in result.name.lower() or "swarm" in result.name.lower():
        result.priority = "P1"
    elif "agentdb" in result.name.lower() or "research" in result.name.lower():
        result.priority = "P2"
    else:
        result.priority = "P3"

    return result


def audit_agent(agent_path: Path) -> AuditResult:
    """Audit a single agent file."""
    result = AuditResult(
        name=agent_path.stem,
        path=str(agent_path),
        category="agent"
    )

    content = agent_path.read_text(encoding='utf-8', errors='ignore')

    # Check: Has identity section
    result.checks["has_identity"] = bool(re.search(r'#.*identity|##.*identity|who i am|i am a', content, re.IGNORECASE))

    # Check: Has methodology
    result.checks["has_methodology"] = bool(re.search(r'methodology|approach|process|workflow', content, re.IGNORECASE))

    # Check: Has failure handling
    result.checks["has_failure_handling"] = bool(re.search(r'failure|error|exception|fallback', content, re.IGNORECASE))

    # Check: Has communication protocol
    result.checks["has_communication"] = bool(re.search(r'output|report|return|deliver', content, re.IGNORECASE))

    # Check: Has evidence-based techniques
    techniques = ["self-consistency", "program-of-thought", "plan-and-solve", "chain-of-thought"]
    result.checks["uses_techniques"] = any(t in content.lower() for t in techniques)

    # Calculate score
    checks_passed = sum(1 for v in result.checks.values() if v is True)
    result.score = round(checks_passed / len(result.checks), 2)

    # Issues and recommendations
    if not result.checks["has_identity"]:
        result.issues.append("Missing identity section")
        result.recommendations.append("Add clear identity/role section")
    if not result.checks["has_methodology"]:
        result.issues.append("Missing methodology section")
        result.recommendations.append("Add step-by-step methodology")
    if not result.checks["uses_techniques"]:
        result.recommendations.append("Add evidence-based prompting techniques")

    return result


def audit_command(command_path: Path) -> AuditResult:
    """Audit a single command file."""
    result = AuditResult(
        name=command_path.stem,
        path=str(command_path),
        category="command"
    )

    content = command_path.read_text(encoding='utf-8', errors='ignore')

    # Check: Has description
    result.checks["has_description"] = len(content) > 100

    # Check: Has usage example
    result.checks["has_example"] = bool(re.search(r'example|usage|```', content, re.IGNORECASE))

    # Check: Has arguments
    result.checks["has_arguments"] = bool(re.search(r'argument|parameter|option|--', content, re.IGNORECASE))

    # Calculate score
    checks_passed = sum(1 for v in result.checks.values() if v is True)
    result.score = round(checks_passed / len(result.checks), 2)

    return result


def run_mass_audit(target: str = "all") -> Dict[str, Any]:
    """Run audit on all items or specific category."""
    report = {
        "timestamp": datetime.now().isoformat(),
        "version": "2.2.0",
        "target": target,
        "summary": {
            "total": 0,
            "by_category": {},
            "by_priority": {"P0": 0, "P1": 0, "P2": 0, "P3": 0},
            "average_score": 0.0
        },
        "items": []
    }

    all_scores = []

    # Audit skills
    if target in ["all", "skills"]:
        print("Auditing skills...")
        skill_count = 0
        for skill_dir in SKILLS_PATH.iterdir():
            if skill_dir.is_dir() and (skill_dir / "SKILL.md").exists():
                result = audit_skill(skill_dir)
                if result:
                    report["items"].append(result.to_dict())
                    all_scores.append(result.score)
                    report["summary"]["by_priority"][result.priority] += 1
                    skill_count += 1
        report["summary"]["by_category"]["skills"] = skill_count
        print(f"  Found {skill_count} skills")

    # Audit agents
    if target in ["all", "agents"] and AGENTS_PATH.exists():
        print("Auditing agents...")
        agent_count = 0
        for agent_file in AGENTS_PATH.rglob("*.md"):
            result = audit_agent(agent_file)
            if result:
                report["items"].append(result.to_dict())
                all_scores.append(result.score)
                agent_count += 1
        report["summary"]["by_category"]["agents"] = agent_count
        print(f"  Found {agent_count} agents")

    # Audit commands
    if target in ["all", "commands"]:
        print("Auditing commands...")
        command_count = 0
        for cmd_dir in COMMANDS_PATH.rglob("commands"):
            if cmd_dir.is_dir():
                for cmd_file in cmd_dir.glob("*.md"):
                    result = audit_command(cmd_file)
                    if result:
                        report["items"].append(result.to_dict())
                        all_scores.append(result.score)
                        command_count += 1
        report["summary"]["by_category"]["commands"] = command_count
        print(f"  Found {command_count} commands")

    # Calculate summary
    report["summary"]["total"] = len(report["items"])
    report["summary"]["average_score"] = round(sum(all_scores) / max(len(all_scores), 1), 2)

    return report


def main():
    import argparse

    parser = argparse.ArgumentParser(description="Mass Audit for Skills, Agents, and Commands")
    parser.add_argument("--target", choices=["all", "skills", "agents", "commands"], default="all")
    parser.add_argument("--output", type=str, default="mass-audit-report.json")
    parser.add_argument("--priority", type=str, help="Filter by priority (P0, P1, P2, P3)")

    args = parser.parse_args()

    print(f"Running mass audit (target: {args.target})...")
    report = run_mass_audit(args.target)

    # Filter by priority if specified
    if args.priority:
        report["items"] = [i for i in report["items"] if i["priority"] == args.priority]
        report["summary"]["total"] = len(report["items"])

    # Save report
    output_path = Path(args.output)
    with open(output_path, 'w') as f:
        json.dump(report, f, indent=2)

    print(f"\nAudit complete!")
    print(f"  Total items: {report['summary']['total']}")
    print(f"  Average score: {report['summary']['average_score']}")
    print(f"  By priority: {report['summary']['by_priority']}")
    print(f"  Report saved to: {output_path}")


if __name__ == "__main__":
    main()
