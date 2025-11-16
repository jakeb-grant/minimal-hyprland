#!/bin/bash

show_step "Configuring Plymouth boot splash..."
log "Installing Plymouth theme"

# Copy Plymouth theme
THEME_DIR="/usr/share/plymouth/themes/minimal-hyprland"
if [ "$(plymouth-set-default-theme)" != "minimal-hyprland" ]; then
  sudo mkdir -p "$THEME_DIR"
  sudo cp -r "$MINIMAL_HYPRLAND_PATH/default/plymouth/"* "$THEME_DIR/"

  # Rename omarchy theme files to minimal-hyprland
  if [ -f "$THEME_DIR/omarchy.plymouth" ]; then
    sudo mv "$THEME_DIR/omarchy.plymouth" "$THEME_DIR/minimal-hyprland.plymouth"
    sudo sed -i 's/omarchy/minimal-hyprland/g' "$THEME_DIR/minimal-hyprland.plymouth"
  fi

  if [ -f "$THEME_DIR/omarchy.script" ]; then
    sudo mv "$THEME_DIR/omarchy.script" "$THEME_DIR/minimal-hyprland.script"
  fi

  sudo plymouth-set-default-theme minimal-hyprland
  show_success "Plymouth theme installed"
  log "Plymouth theme set to minimal-hyprland"
fi
