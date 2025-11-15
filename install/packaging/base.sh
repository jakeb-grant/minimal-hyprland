#!/bin/bash

show_step "Installing base packages..."
log "Installing base packages from minimal-base.packages"

# Read package list and install
PACKAGES=$(grep -v '^#' "$MINIMAL_HYPRLAND_INSTALL/minimal-base.packages" | grep -v '^$' | tr '\n' ' ')

gum spin --spinner dot --title "Installing packages (this may take a while)..." -- \
  sudo pacman -S --needed --noconfirm $PACKAGES

show_success "Base packages installed"
log "Base package installation complete"
