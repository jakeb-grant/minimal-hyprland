#!/bin/bash

show_step "Copying configuration files..."
log "Copying Hyprland and application configs"

# Copy Hyprland configs
mkdir -p ~/.config/hypr
cp -r "$MINIMAL_HYPRLAND_PATH/config/hypr/"* ~/.config/hypr/

# Create placeholder wallpaper
mkdir -p ~/.config/hypr
if [ ! -f ~/.config/hypr/wallpaper.jpg ]; then
  # Download a simple wallpaper or create a solid color image
  convert -size 1920x1080 xc:'#1a1b26' ~/.config/hypr/wallpaper.jpg 2>/dev/null || true
fi

show_success "Configuration files copied"
log "Configuration copy complete"
