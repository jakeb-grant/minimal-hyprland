#!/bin/bash

show_step "Configuring SDDM display manager..."
log "Configuring SDDM"

# Enable SDDM service
sudo systemctl enable sddm

# Configure SDDM to use Hyprland
sudo mkdir -p /etc/sddm.conf.d

sudo tee /etc/sddm.conf.d/minimal-hyprland.conf >/dev/null <<EOF
[General]
# Set Hyprland as default session
Session=hyprland-uwsm

[Theme]
Current=breeze

[Autologin]
# Autologin is disabled by default
# To enable, uncomment and set your username:
# User=$USER
# Session=hyprland-uwsm
EOF

show_success "SDDM configured"
log "SDDM configuration complete"
