#!/bin/bash

log "Configuring pacman..."

# Enable parallel downloads and color
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf

# Update package databases
sudo pacman -Sy
