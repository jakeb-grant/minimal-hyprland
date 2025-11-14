# Auto-launch the Minimal Hyprland configurator on login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  minimal-hyprland-configurator
fi
