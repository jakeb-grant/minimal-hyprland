#!/bin/bash

# Ensure we have gum available
if ! command -v gum &>/dev/null; then
  sudo pacman -S --needed --noconfirm gum
fi

# Simple presentation helpers
clear_screen() {
  clear
}

show_header() {
  gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 60 --margin "1 2" --padding "2 4" \
    "$1"
}

show_step() {
  gum style --foreground 2 --bold "→ $1"
}

show_success() {
  gum style --foreground 2 "✓ $1"
}

show_error() {
  gum style --foreground 1 "✗ $1"
}
