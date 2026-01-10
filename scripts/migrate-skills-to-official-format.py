#!/usr/bin/env python3
"""
Skill Migration Script - Converts skills to official .skill format

Official format (per anthropics/skills spec):
- YAML frontmatter: ONLY name + description
- Directory structure: SKILL.md + optional scripts/, references/, assets/
- Package: .skill file (zip with .skill extension)

Usage:
  python migrate-skills-to-official-format.py --audit          # Audit only
  python migrate-skills-to-official-format.py --migrate        # Migrate all
  python migrate-skills-to-official-format.py --migrate --skill <name>  # Single skill
  python migrate-skills-to-official-format.py --package        # Package as .skill
"""

import argparse
import json
import os
import re
import shutil
import zipfile
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Tuple

# Paths
CONTEXT_CASCADE = Path(r"C:\Users\17175\claude-code-plugins\context-cascade")
SKILLS_DIR = CONTEXT_CASCADE / "skills"
SUPP_SKILLS_DIR = Path(r"C:\Users\17175\.claude\skills")
OUTPUT_DIR = CONTEXT_CASCADE / "dist" / "skills"
BACKUP_DIR = CONTEXT_CASCADE / "backups" / "skills-pre-migration"

# Official allowed frontmatter fields
ALLOWED_FIELDS = {"name", "description"}

# Fields to remove
REMOVE_FIELDS = {
    "allowed-tools", "model", "x-version", "x-category",
    "x-vcl-compliance", "x-cognitive-frames", "x-last-reflection",
    "x-reflection-count"
}


def parse_yaml_frontmatter(content: str) -> Tuple[Dict, str, int, int]:
    """Parse YAML frontmatter from SKILL.md content.
    Returns: (frontmatter_dict, body, start_line, end_line)
    """
    lines = content.split('\n')
    if not lines or lines[0].strip() != '---':
        return {}, content, 0, 0

    # Find closing ---
    end_idx = -1
    for i, line in enumerate(lines[1:], 1):
        if line.strip() == '---':
            end_idx = i
            break

    if end_idx == -1:
        return {}, content, 0, 0

    # Parse YAML (simple key: value parsing)
    frontmatter = {}
    current_key = None
    current_value = []

    for line in lines[1:end_idx]:
        # Check for new key
        if ':' in line and not line.startswith(' ') and not line.startswith('\t'):
            # Save previous key if exists
            if current_key:
                val = '\n'.join(current_value).strip()
                if val.startswith('|'):
                    val = '\n'.join(current_value[1:])
                frontmatter[current_key] = val

            key, _, value = line.partition(':')
            current_key = key.strip()
            current_value = [value.strip()] if value.strip() else []
        elif current_key:
            current_value.append(line)

    # Save last key
    if current_key:
        val = '\n'.join(current_value).strip()
        if val.startswith('|'):
            val = '\n'.join(current_value[1:])
        frontmatter[current_key] = val

    body = '\n'.join(lines[end_idx + 1:])
    return frontmatter, body, 0, end_idx


def clean_frontmatter(frontmatter: Dict) -> Dict:
    """Remove non-allowed fields from frontmatter."""
    return {k: v for k, v in frontmatter.items() if k in ALLOWED_FIELDS}


def generate_clean_skill_md(frontmatter: Dict, body: str) -> str:
    """Generate clean SKILL.md with only allowed frontmatter."""
    clean_fm = clean_frontmatter(frontmatter)

    # Build new content
    lines = ["---"]
    lines.append(f"name: {clean_fm.get('name', 'unnamed-skill')}")

    desc = clean_fm.get('description', '')
    if '\n' in desc:
        lines.append("description: |")
        for dline in desc.split('\n'):
            lines.append(f"  {dline}")
    else:
        lines.append(f"description: {desc}")

    lines.append("---")
    lines.append(body)

    return '\n'.join(lines)


def audit_skill(skill_path: Path) -> Dict:
    """Audit a single skill for compliance."""
    result = {
        "path": str(skill_path),
        "name": skill_path.name,
        "compliant": True,
        "issues": [],
        "has_examples": (skill_path / "examples").exists(),
        "has_tests": (skill_path / "tests").exists(),
        "has_resources": (skill_path / "resources").exists(),
        "has_references": (skill_path / "references").exists(),
    }

    skill_md = skill_path / "SKILL.md"
    if not skill_md.exists():
        result["compliant"] = False
        result["issues"].append("Missing SKILL.md")
        return result

    content = skill_md.read_text(encoding='utf-8')
    frontmatter, body, _, _ = parse_yaml_frontmatter(content)

    # Check for extra fields
    extra_fields = set(frontmatter.keys()) - ALLOWED_FIELDS
    if extra_fields:
        result["compliant"] = False
        result["issues"].append(f"Extra frontmatter fields: {extra_fields}")
        result["extra_fields"] = list(extra_fields)

    # Check for disallowed files
    disallowed = ["readme.md", "README.md", "CHANGELOG.md", "INSTALLATION_GUIDE.md"]
    for f in disallowed:
        if (skill_path / f).exists():
            result["issues"].append(f"Disallowed file: {f}")

    # Check SKILL.md line count
    line_count = len(content.split('\n'))
    if line_count > 500:
        result["issues"].append(f"SKILL.md too long: {line_count} lines (max 500)")

    return result


def migrate_skill(skill_path: Path, dry_run: bool = False) -> Dict:
    """Migrate a single skill to official format."""
    result = audit_skill(skill_path)

    if result["compliant"]:
        result["action"] = "already_compliant"
        return result

    skill_md = skill_path / "SKILL.md"
    if not skill_md.exists():
        result["action"] = "skipped_no_skill_md"
        return result

    # Read and parse
    content = skill_md.read_text(encoding='utf-8')
    frontmatter, body, _, _ = parse_yaml_frontmatter(content)

    # Generate clean content
    clean_content = generate_clean_skill_md(frontmatter, body)

    if dry_run:
        result["action"] = "would_migrate"
        result["preview"] = clean_content[:500] + "..."
    else:
        # Backup original
        try:
            backup_path = BACKUP_DIR / skill_path.relative_to(SKILLS_DIR.parent)
        except ValueError:
            # Handle supplementary skills
            backup_path = BACKUP_DIR / "supplementary" / skill_path.name
        backup_path.mkdir(parents=True, exist_ok=True)
        shutil.copy2(skill_md, backup_path / "SKILL.md.backup")

        # Write clean version
        skill_md.write_text(clean_content, encoding='utf-8')
        result["action"] = "migrated"
        result["backup"] = str(backup_path)

    return result


def package_skill(skill_path: Path, output_dir: Path = None) -> Path:
    """Package skill as .skill file (zip with .skill extension)."""
    output_dir = output_dir or OUTPUT_DIR
    output_dir.mkdir(parents=True, exist_ok=True)

    skill_name = skill_path.name
    output_file = output_dir / f"{skill_name}.skill"

    with zipfile.ZipFile(output_file, 'w', zipfile.ZIP_DEFLATED) as zf:
        for file_path in skill_path.rglob("*"):
            if file_path.is_file():
                # Skip unwanted files
                if "__pycache__" in str(file_path):
                    continue
                if file_path.name.startswith("."):
                    continue
                if file_path.suffix == ".backup":
                    continue

                arcname = file_path.relative_to(skill_path.parent)
                zf.write(file_path, arcname)

    return output_file


def main():
    parser = argparse.ArgumentParser(description="Migrate skills to official format")
    parser.add_argument("--audit", action="store_true", help="Audit skills only")
    parser.add_argument("--migrate", action="store_true", help="Migrate skills")
    parser.add_argument("--package", action="store_true", help="Package as .skill files")
    parser.add_argument("--skill", help="Process single skill by name")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be done")
    parser.add_argument("--supp", action="store_true", help="Process supplementary skills")

    args = parser.parse_args()

    # Determine which skills to process
    skills_dir = SUPP_SKILLS_DIR if args.supp else SKILLS_DIR

    if args.skill:
        # Find specific skill
        matches = list(skills_dir.rglob(f"{args.skill}/SKILL.md"))
        if not matches:
            print(f"Skill not found: {args.skill}")
            return 1
        skill_dirs = [m.parent for m in matches]
    else:
        # All skills
        skill_dirs = [p.parent for p in skills_dir.rglob("SKILL.md")]

    print(f"\n{'='*60}")
    print(f"SKILL MIGRATION TOOL - {len(skill_dirs)} skills")
    print(f"{'='*60}\n")

    results = {"compliant": 0, "needs_migration": 0, "migrated": 0, "packaged": 0}

    for skill_path in skill_dirs:
        if args.audit or args.migrate:
            result = audit_skill(skill_path) if args.audit else migrate_skill(skill_path, args.dry_run)

            if result.get("compliant"):
                results["compliant"] += 1
                status = "[OK]"
            else:
                results["needs_migration"] += 1
                status = "[NEEDS WORK]"

            if result.get("action") == "migrated":
                results["migrated"] += 1
                status = "[MIGRATED]"

            print(f"{status} {skill_path.name}")
            if result.get("issues"):
                for issue in result["issues"][:3]:
                    print(f"    - {issue}")

        if args.package:
            output = package_skill(skill_path)
            results["packaged"] += 1
            print(f"[PACKAGED] {skill_path.name} -> {output.name}")

    print(f"\n{'='*60}")
    print("SUMMARY:")
    print(f"  Compliant: {results['compliant']}")
    print(f"  Needs migration: {results['needs_migration']}")
    if args.migrate:
        print(f"  Migrated: {results['migrated']}")
    if args.package:
        print(f"  Packaged: {results['packaged']}")
    print(f"{'='*60}\n")

    return 0


if __name__ == "__main__":
    exit(main())
