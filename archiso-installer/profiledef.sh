#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="minimal-hyprland"
iso_label="MINIMAL_HYPRLAND_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="Minimal Hyprland <https://github.com/yourusername/minimal-hyprland>"
iso_application="Minimal Hyprland Live/Rescue ISO"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.zlogin"]="0:0:644"
  ["/usr/local/bin/minimal-hyprland-configurator"]="0:0:755"
  ["/etc/NetworkManager/conf.d/wifi-backend.conf"]="0:0:644"
  ["/etc/minimal-hyprland/minimal-base.packages"]="0:0:644"
)
