#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define installation paths
export MINIMAL_HYPRLAND_PATH="$HOME/.local/share/minimal-hyprland"
export MINIMAL_HYPRLAND_INSTALL="$MINIMAL_HYPRLAND_PATH/install"
export PATH="$MINIMAL_HYPRLAND_PATH/bin:$PATH"

# Run installation pipeline
source "$MINIMAL_HYPRLAND_INSTALL/helpers/all.sh"
source "$MINIMAL_HYPRLAND_INSTALL/preflight/all.sh"
source "$MINIMAL_HYPRLAND_INSTALL/packaging/all.sh"
source "$MINIMAL_HYPRLAND_INSTALL/config/all.sh"
source "$MINIMAL_HYPRLAND_INSTALL/login/all.sh"
source "$MINIMAL_HYPRLAND_INSTALL/post-install/all.sh"
