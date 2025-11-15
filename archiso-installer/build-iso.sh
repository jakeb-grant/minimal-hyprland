#!/bin/bash
#
# Build Minimal Hyprland ISO
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo " ╦ ╦┬ ┬┌─┐┬─┐┬  ┌─┐┌┐┌┌┬┐"
echo " ╠═╣└┬┘├─┘├┬┘│  ├─┤│││ ││"
echo " ╩ ╩ ┴ ┴  ┴└─┴─┘┴ ┴┘└┘─┴┘"
echo " ISO Builder"
echo -e "${NC}"

# Check if archiso is installed
if ! command -v mkarchiso &> /dev/null; then
    echo -e "${RED}Error: archiso is not installed${NC}"
    echo "Install it with: sudo pacman -S archiso"
    exit 1
fi

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    echo "Run with: sudo ./build-iso.sh"
    exit 1
fi

# Validate package list
echo
echo -e "${YELLOW}Validating package list...${NC}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

if ! "$PROJECT_ROOT/scripts/validate-packages.sh"; then
    echo -e "${RED}Package validation failed!${NC}"
    echo "Fix package errors before building ISO."
    exit 1
fi
echo

# Configuration
WORK_DIR="${WORK_DIR:-/tmp/archiso-work}"
OUTPUT_DIR="${OUTPUT_DIR:-$(pwd)/output}"
PROFILE_DIR="$(pwd)"

echo -e "${YELLOW}Build Configuration:${NC}"
echo "  Profile: $PROFILE_DIR"
echo "  Work directory: $WORK_DIR"
echo "  Output directory: $OUTPUT_DIR"
echo

# Confirm
read -p "Proceed with build? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Build cancelled."
    exit 0
fi

# Clean previous build
if [ -d "$WORK_DIR" ]; then
    echo -e "${YELLOW}Cleaning previous build...${NC}"
    rm -rf "$WORK_DIR"
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Build
echo -e "${GREEN}Building ISO...${NC}"
echo "This may take 10-30 minutes depending on your system..."
echo

if mkarchiso -v -w "$WORK_DIR" -o "$OUTPUT_DIR" "$PROFILE_DIR"; then
    echo
    echo -e "${GREEN}═══════════════════════════════════════${NC}"
    echo -e "${GREEN}Build successful!${NC}"
    echo -e "${GREEN}═══════════════════════════════════════${NC}"
    echo
    echo "ISO location: $OUTPUT_DIR"
    ls -lh "$OUTPUT_DIR"/*.iso
    echo
    echo -e "${BLUE}Next steps:${NC}"
    echo "  1. Write to USB: sudo dd if=$OUTPUT_DIR/*.iso of=/dev/sdX bs=4M status=progress"
    echo "  2. Or use balenaEtcher for a GUI experience"
    echo "  3. Boot from USB and follow the installer"
else
    echo
    echo -e "${RED}Build failed!${NC}"
    echo "Check the output above for errors."
    exit 1
fi
