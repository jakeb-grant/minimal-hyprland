#!/bin/bash
#
# Validate Package List
# Checks that all packages in minimal-base.packages exist in Arch repositories
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Find package list file (support both nested and flattened structure)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

if [ -f "$PROJECT_ROOT/install/minimal-base.packages" ]; then
    PACKAGE_FILE="$PROJECT_ROOT/install/minimal-base.packages"
elif [ -f "$PROJECT_ROOT/minimal-hyprland/install/minimal-base.packages" ]; then
    PACKAGE_FILE="$PROJECT_ROOT/minimal-hyprland/install/minimal-base.packages"
else
    echo -e "${RED}Error: Cannot find minimal-base.packages${NC}"
    exit 1
fi

echo -e "${BLUE}Validating Package List${NC}"
echo "Package file: $PACKAGE_FILE"
echo

# Read packages (skip comments and empty lines)
PACKAGES=$(grep -v '^#' "$PACKAGE_FILE" | grep -v '^$' | tr '\n' ' ')
PACKAGE_COUNT=$(echo "$PACKAGES" | wc -w)

echo -e "${YELLOW}Checking $PACKAGE_COUNT packages...${NC}"
echo

# Track valid and invalid packages
VALID_PACKAGES=()
INVALID_PACKAGES=()
CHECKED=0

# Check each package
for pkg in $PACKAGES; do
    CHECKED=$((CHECKED + 1))
    printf "  [%3d/%3d] %-30s ... " "$CHECKED" "$PACKAGE_COUNT" "$pkg"

    if pacman -Si "$pkg" &>/dev/null; then
        echo -e "${GREEN}✓${NC}"
        VALID_PACKAGES+=("$pkg")
    else
        echo -e "${RED}✗ NOT FOUND${NC}"
        INVALID_PACKAGES+=("$pkg")
    fi
done

echo

# Summary
if [ ${#INVALID_PACKAGES[@]} -eq 0 ]; then
    echo -e "${GREEN}════════════════════════════════════════${NC}"
    echo -e "${GREEN}✓ All packages valid!${NC}"
    echo -e "${GREEN}════════════════════════════════════════${NC}"
    echo
    echo "  Valid packages: ${#VALID_PACKAGES[@]}"
    exit 0
else
    echo -e "${RED}════════════════════════════════════════${NC}"
    echo -e "${RED}✗ Validation failed!${NC}"
    echo -e "${RED}════════════════════════════════════════${NC}"
    echo
    echo "  Valid packages:   ${#VALID_PACKAGES[@]}"
    echo "  Invalid packages: ${#INVALID_PACKAGES[@]}"
    echo
    echo -e "${YELLOW}Invalid packages:${NC}"
    for pkg in "${INVALID_PACKAGES[@]}"; do
        echo "  - $pkg"
    done
    echo
    echo -e "${YELLOW}Suggestions:${NC}"
    echo "  1. Check package name spelling"
    echo "  2. Verify package exists in official Arch repos"
    echo "  3. Check if package moved to AUR"
    echo "  4. Update package list with correct names"
    exit 1
fi
