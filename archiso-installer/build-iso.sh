#!/bin/bash
#
# Minimal Hyprland ISO Builder
# Based on Omarchy's build approach - uses official Arch releng profile as foundation
#

set -e

echo "==> Building Minimal Hyprland ISO"

# Setup build locations
build_dir="/tmp/archiso-build"
mkdir -p "$build_dir"

# Copy the official Arch releng profile as our base
# This provides all the working archiso infrastructure
echo "==> Copying official Arch releng profile..."
cp -r /usr/share/archiso/configs/releng/* "$build_dir/"

# Remove releng-specific files we don't want
echo "==> Removing releng-specific files..."
rm -f "$build_dir/airootfs/etc/motd"
rm -f "$build_dir/airootfs/etc/systemd/system/multi-user.target.wants/reflector.service" 2>/dev/null || true
rm -rf "$build_dir/airootfs/etc/systemd/system/reflector.service.d" 2>/dev/null || true
rm -rf "$build_dir/airootfs/etc/xdg/reflector" 2>/dev/null || true

# Overlay our customizations on top of releng
echo "==> Overlaying Minimal Hyprland customizations..."
cp -r /workspace/archiso-installer/airootfs/* "$build_dir/airootfs/" 2>/dev/null || true
cp -r /workspace/archiso-installer/efiboot/* "$build_dir/efiboot/" 2>/dev/null || true
cp -r /workspace/archiso-installer/syslinux/* "$build_dir/syslinux/" 2>/dev/null || true
cp /workspace/archiso-installer/profiledef.sh "$build_dir/"
cp /workspace/archiso-installer/pacman.conf "$build_dir/" 2>/dev/null || true

# Copy package lists from minimal-hyprland to the ISO
echo "==> Copying package lists..."
mkdir -p "$build_dir/airootfs/etc/minimal-hyprland"
cp /workspace/install/minimal-base.packages "$build_dir/airootfs/etc/minimal-hyprland/" 2>/dev/null || true

# Append our additional packages to releng's packages.x86_64
echo "==> Adding Minimal Hyprland packages..."
if [ -f /workspace/archiso-installer/packages.x86_64 ]; then
    # Extract our custom packages (skip comments and empties, skip archiso since releng has it)
    grep -v '^#' /workspace/archiso-installer/packages.x86_64 | \
    grep -v '^$' | \
    grep -v '^archiso$' >> "$build_dir/packages.x86_64"
fi

# Show what we're building with
echo "==> Package count: $(grep -v '^#' "$build_dir/packages.x86_64" | grep -v '^$' | wc -l) packages"

# Download packages for offline installation
echo "==> Populating package cache for offline installation..."
mkdir -p "$build_dir/airootfs/var/cache/pacman/pkg"

# Read all packages from minimal-base.packages for offline installation
echo "==> Reading package list from minimal-base.packages..."
HYPRLAND_PACKAGES=$(grep -v '^#' /workspace/install/minimal-base.packages | grep -v '^$' | tr '\n' ' ')

# Download all packages archinstall will need:
# - Essential base system packages
# - All Hyprland packages from minimal-base.packages
# This ensures completely offline installation (except git clone)
echo "==> Downloading all packages to cache..."
pacman -Syw --noconfirm --cachedir "$build_dir/airootfs/var/cache/pacman/pkg" \
    base base-devel linux linux-firmware \
    grub efibootmgr os-prober mtools \
    dosfstools e2fsprogs cryptsetup sudo \
    $HYPRLAND_PACKAGES

echo "==> Package cache populated with $(ls "$build_dir/airootfs/var/cache/pacman/pkg" | wc -l) packages"

# Build the ISO
echo "==> Running mkarchiso..."
mkarchiso -v -w "$build_dir/work" -o /workspace/archiso-installer/output "$build_dir"

echo "==> Build complete!"
ls -lh /workspace/archiso-installer/output/
