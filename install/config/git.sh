#!/bin/bash

# Set git configuration from environment variables
if [[ -n "${MINIMAL_HYPRLAND_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$MINIMAL_HYPRLAND_USER_NAME"
  log "Git user.name set to: $MINIMAL_HYPRLAND_USER_NAME"
fi

if [[ -n "${MINIMAL_HYPRLAND_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$MINIMAL_HYPRLAND_USER_EMAIL"
  log "Git user.email set to: $MINIMAL_HYPRLAND_USER_EMAIL"
fi
