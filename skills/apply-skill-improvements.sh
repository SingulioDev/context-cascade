#!/bin/bash

# Apply SKILL-SPECIFIC prompt improvements to all .md files in tooling/, references/, and _pipeline-automation/

BASE_DIR="/c/Users/17175/claude-code-plugins/ruv-sparc-three-loop-system/skills"
PROCESSED_COUNT=0
SKIPPED_COUNT=0
ERROR_COUNT=0

# Define the improvement text to insert
IMPROVEMENT_TEXT='

## When to Use This Skill

- **Tool Usage**: When you need to execute specific tools, lookup reference materials, or run automation pipelines
- **Reference Lookup**: When you need to access documented patterns, best practices, or technical specifications
- **Automation Needs**: When you need to run standardized workflows or pipeline processes

## When NOT to Use This Skill

- **Manual Processes**: Avoid when manual intervention is more appropriate than automated tools
- **Non-Standard Tools**: Do not use when tools are deprecated, unsupported, or outside standard toolkit

## Success Criteria

- **Tool Executed Correctly**: Verify tool runs without errors and produces expected output
- **Reference Accurate**: Confirm reference material is current and applicable
- **Pipeline Complete**: Ensure automation pipeline completes all stages successfully

## Edge Cases

- **Tool Unavailable**: Handle scenarios where required tool is not installed or accessible
- **Outdated References**: Detect when reference material is obsolete or superseded
- **Pipeline Failures**: Recover gracefully from mid-pipeline failures with clear error messages

## Guardrails

- **NEVER use deprecated tools**: Always verify tool versions and support status before execution
- **ALWAYS verify outputs**: Validate tool outputs match expected format and content
- **ALWAYS check health**: Run tool health checks before critical operations

## Evidence-Based Validation

- **Tool Health Checks**: Execute diagnostic commands to verify tool functionality before use
- **Output Validation**: Compare actual outputs against expected schemas or patterns
- **Pipeline Monitoring**: Track pipeline execution metrics and success rates
'

echo "Starting skill improvement process..."
echo "Base directory: $BASE_DIR"
echo ""

# Function to process a single file
process_file() {
    local file="$1"
    local relative_path="${file#$BASE_DIR/}"
    
    # Check if file already contains improvement text
    if grep -q "## When to Use This Skill" "$file" 2>/dev/null; then
        echo "[SKIP] Already enhanced: $relative_path"
        ((SKIPPED_COUNT++))
        return
    fi
    
    # Detect YAML frontmatter and insert after it
    # Look for lines starting with "---" or "name:" or "skill:" or "description:" or "You are executing"
    
    # Create temporary file
    temp_file=$(mktemp)
    
    # Use awk to insert after frontmatter
    awk -v improvement="$IMPROVEMENT_TEXT" '
    BEGIN { 
        frontmatter_ended = 0
        inserted = 0
        in_yaml = 0
    }
    
    # Detect start of YAML frontmatter
    /^---$/ && NR <= 5 && !in_yaml {
        in_yaml = 1
        print
        next
    }
    
    # Detect end of YAML frontmatter (second ---)
    /^---$/ && in_yaml && !frontmatter_ended {
        frontmatter_ended = 1
        print
        print improvement
        inserted = 1
        next
    }
    
    # Detect "You are executing" pattern (alternative frontmatter style)
    /^You are executing/ && NR <= 5 && !frontmatter_ended {
        print
        getline
        print
        # Find first empty line or markdown header after frontmatter
        while (getline > 0) {
            print
            if (/^$/ || /^#/) {
                print improvement
                inserted = 1
                frontmatter_ended = 1
                break
            }
        }
        next
    }
    
    # Detect frontmatter without --- markers
    /^(name|skill|description|tags|version|category|author):/ && NR <= 10 && !frontmatter_ended {
        print
        # Continue printing until we find blank line or markdown header
        while (getline > 0) {
            if (/^$/ || /^#/) {
                print
                print improvement
                inserted = 1
                frontmatter_ended = 1
                break
            }
            print
        }
        next
    }
    
    # If no frontmatter detected and we are past line 10, insert at top
    NR == 1 && !/^---$/ && !/^You are executing/ && !/^(name|skill|description):/ {
        print improvement
        print
        inserted = 1
        frontmatter_ended = 1
        next
    }
    
    # Default: print the line
    { print }
    
    # If we reach end and havent inserted, insert at end
    END {
        if (!inserted) {
            print improvement
        }
    }
    ' "$file" > "$temp_file"
    
    # Check if awk succeeded
    if [ $? -eq 0 ] && [ -s "$temp_file" ]; then
        # Backup original
        cp "$file" "${file}.backup"
        # Replace with enhanced version
        mv "$temp_file" "$file"
        echo "[OK] Enhanced: $relative_path"
        ((PROCESSED_COUNT++))
    else
        echo "[ERROR] Failed to process: $relative_path"
        rm -f "$temp_file"
        ((ERROR_COUNT++))
    fi
}

# Process all .md files in the three directories
for dir in tooling references _pipeline-automation; do
    full_dir="$BASE_DIR/$dir"
    if [ -d "$full_dir" ]; then
        echo ""
        echo "Processing directory: $dir/"
        echo "----------------------------------------"
        
        # Find all .md files
        while IFS= read -r file; do
            process_file "$file"
        done < <(find "$full_dir" -name "*.md" -type f)
    else
        echo "[WARN] Directory not found: $dir/"
    fi
done

echo ""
echo "========================================"
echo "SKILL IMPROVEMENT COMPLETE"
echo "========================================"
echo "Processed: $PROCESSED_COUNT files"
echo "Skipped:   $SKIPPED_COUNT files (already enhanced)"
echo "Errors:    $ERROR_COUNT files"
echo "Total:     $((PROCESSED_COUNT + SKIPPED_COUNT + ERROR_COUNT)) files"
echo ""
echo "Backups saved with .backup extension"
echo "========================================"

