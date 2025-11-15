#!/bin/bash

# Simple logging helper
export LOG_FILE="/var/log/minimal-hyprland-install.log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | sudo tee -a "$LOG_FILE" >/dev/null
}

log_error() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $*" | sudo tee -a "$LOG_FILE" >&2
}

start_install_log() {
  sudo mkdir -p "$(dirname "$LOG_FILE")"
  log "=== Minimal Hyprland Installation Started ==="
  log "User: $USER"
  log "Hostname: $(hostname)"
  log "Kernel: $(uname -r)"
}
