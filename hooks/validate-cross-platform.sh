#!/bin/bash
# validate-cross-platform.sh
# Checks that all .ps1 hooks have .sh counterparts and vice versa
# Run this before committing hook changes

HOOKS_DIR="$(dirname "$0")"
ERRORS=0

echo "=============================================="
echo "Cross-Platform Hook Validation"
echo "=============================================="

# Find all .ps1 files (excluding node_modules)
echo ""
echo "Checking .ps1 files for .sh counterparts..."
for ps1_file in $(find "$HOOKS_DIR" -name "*.ps1" -type f | grep -v node_modules); do
    sh_file="${ps1_file%.ps1}.sh"
    if [ ! -f "$sh_file" ]; then
        echo "  [MISSING] $sh_file (counterpart for $(basename "$ps1_file"))"
        ERRORS=$((ERRORS + 1))
    fi
done

# Find all .sh files (excluding node_modules)
echo ""
echo "Checking .sh files for .ps1 counterparts..."
for sh_file in $(find "$HOOKS_DIR" -name "*.sh" -type f | grep -v node_modules | grep -v validate-cross-platform.sh); do
    ps1_file="${sh_file%.sh}.ps1"
    if [ ! -f "$ps1_file" ]; then
        echo "  [MISSING] $ps1_file (counterpart for $(basename "$sh_file"))"
        ERRORS=$((ERRORS + 1))
    fi
done

echo ""
echo "=============================================="
if [ $ERRORS -eq 0 ]; then
    echo "PASS: All hooks have cross-platform counterparts"
    exit 0
else
    echo "FAIL: $ERRORS missing counterparts found"
    echo ""
    echo "To fix: Create the missing .sh or .ps1 files"
    echo "Pattern: Each hook should have both .sh (Unix) and .ps1 (Windows)"
    exit 1
fi
