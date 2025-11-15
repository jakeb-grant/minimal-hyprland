#!/bin/bash

show_step "Installing AUR helper (yay)..."
log "Building and installing yay"

# Clone and build yay
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

# Clean up
cd ~
rm -rf "$TEMP_DIR"

show_success "Yay installed"
log "Yay installation complete"

# Install AUR packages
if [ -f "$MINIMAL_HYPRLAND_INSTALL/minimal-aur.packages" ]; then
  show_step "Installing AUR packages..."
  log "Installing AUR packages from minimal-aur.packages"
  
  # Read package list and install
  AUR_PACKAGES=$(grep -v '^#' "$MINIMAL_HYPRLAND_INSTALL/minimal-aur.packages" | grep -v '^$' | tr '\n' ' ')
  
  echo "Installing AUR packages (this may take a while)..."
  yay -S --needed --noconfirm $AUR_PACKAGES
  
  show_success "AUR packages installed"
  log "AUR package installation complete"
fi
