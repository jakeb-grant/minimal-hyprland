#!/bin/bash

log "Installation complete!"
echo

show_success "Minimal Hyprland installation completed successfully!"
echo
gum style --foreground 6 "Next steps:"
echo "  1. Reboot your system"
echo "  2. Login to Hyprland via SDDM"
echo "  3. Press SUPER+SPACE for app launcher"
echo "  4. Press SUPER+RETURN for terminal"
echo "  5. Customize ~/.config/hypr/ to your liking"
echo
gum confirm "Reboot now?" && sudo reboot || echo "Reboot cancelled. Run 'sudo reboot' when ready."
