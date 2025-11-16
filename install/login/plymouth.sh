#!/bin/bash

show_step "Configuring Plymouth boot splash..."
log "Installing Plymouth theme"

# Copy Plymouth theme
if [ "$(plymouth-set-default-theme)" != "minimal-hyprland" ]; then
  sudo mkdir -p /usr/share/plymouth/themes/minimal-hyprland
  sudo cp -r "$MINIMAL_HYPRLAND_PATH/default/plymouth/"* /usr/share/plymouth/themes/minimal-hyprland/
  sudo plymouth-set-default-theme minimal-hyprland
  show_success "Plymouth theme installed"
  log "Plymouth theme set to minimal-hyprland"
fi
