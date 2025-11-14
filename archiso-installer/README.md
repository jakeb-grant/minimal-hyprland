# Minimal Hyprland ISO Builder

This directory contains an **archiso** configuration for building a custom Arch Linux ISO with a beautiful, gum-based installer that automatically sets up Minimal Hyprland.

## Features

### Beautiful Installation Experience
- 🎨 **Gum-powered TUI** - Gorgeous terminal UI prompts
- 🚀 **Automated workflow** - Auto-launches on boot
- ⚙️ **archinstall integration** - Wraps archinstall with custom config
- 🔐 **Disk encryption** - Optional LUKS encryption
- 🎯 **Zero manual steps** - From boot to desktop automatically

### What It Asks
1. **User info** - Name, email, username
2. **Disk selection** - Which drive to install to
3. **Encryption** - Enable/disable disk encryption
4. **System settings** - Timezone, locale, keyboard
5. **Confirmation** - Review before installing

### What It Does
1. Runs archinstall with your choices
2. Clones minimal-hyprland repository
3. Runs the Minimal Hyprland installer
4. Configures SDDM + Plymouth
5. Enables NetworkManager
6. Reboots to your new system

## Building the ISO

### Prerequisites

Install archiso on Arch Linux:

```bash
sudo pacman -S archiso
```

### Build Process

1. **Clone this repository:**

```bash
git clone <your-repo> ~/minimal-hyprland-project
cd ~/minimal-hyprland-project/archiso-installer
```

2. **Customize (optional):**

Edit these variables in `airootfs/usr/local/bin/minimal-hyprland-configurator`:

```bash
MINIMAL_HYPRLAND_REPO="yourusername/minimal-hyprland"
MINIMAL_HYPRLAND_BRANCH="main"
```

3. **Build the ISO:**

```bash
sudo mkarchiso -v -w /tmp/archiso-work -o ~/iso-output .
```

This creates: `~/iso-output/minimal-hyprland-YYYYMM-x86_64.iso`

4. **Write to USB:**

```bash
# Linux
sudo dd if=~/iso-output/minimal-hyprland-*.iso of=/dev/sdX bs=4M status=progress && sync

# Or use balenaEtcher (cross-platform)
```

## ISO Structure

```
archiso-installer/
├── profiledef.sh                              # ISO metadata & config
├── pacman.conf                                # Package manager config
├── packages.x86_64                            # Packages for live ISO
└── airootfs/                                  # Files copied to ISO
    ├── root/
    │   └── .zlogin                           # Auto-launch configurator
    └── usr/local/bin/
        └── minimal-hyprland-configurator     # Gum-based installer
```

## Customization

### Change Minimal Hyprland Source

By default, the configurator clones from `yourusername/minimal-hyprland`. To use a different repo or branch:

**Option 1: Edit the configurator**

Edit `airootfs/usr/local/bin/minimal-hyprland-configurator`:

```bash
MINIMAL_HYPRLAND_REPO="your-github-username/your-fork"
MINIMAL_HYPRLAND_BRANCH="your-branch"
```

**Option 2: Environment variables at boot**

At the ISO boot prompt, pass:

```
MINIMAL_HYPRLAND_REPO=username/repo MINIMAL_HYPRLAND_BRANCH=branch
```

### Add Packages to ISO

Edit `packages.x86_64` to include additional packages in the live environment:

```
# Add your packages here
your-package-name
another-package
```

**Note:** These are for the *live ISO*, not the installed system. To add packages to the final system, edit `minimal-hyprland/install/minimal-base.packages`.

### Modify Installation Steps

The configurator script (`airootfs/usr/local/bin/minimal-hyprland-configurator`) contains the full installation logic. Key sections:

- **Lines 30-50:** User information prompts
- **Lines 70-100:** Disk selection & encryption
- **Lines 120-150:** System configuration
- **Lines 200-250:** archinstall execution
- **Lines 260-300:** Minimal Hyprland installation

### Disable Auto-Launch

To prevent the configurator from auto-launching on boot, delete or comment out:

```bash
# airootfs/root/.zlogin
```

Then users must manually run:

```bash
minimal-hyprland-configurator
```

## Boot Options

### UEFI Boot

The ISO supports UEFI boot with systemd-boot. On modern systems, just boot from the USB.

### BIOS/Legacy Boot

The ISO also supports BIOS boot with syslinux for older systems.

### Secure Boot

**Secure Boot must be disabled** in BIOS/UEFI settings to boot this ISO.

## Installation Flow

```
┌─────────────────────────────────────┐
│ 1. Boot from ISO                    │
│    ↓ Plymouth splash (if configured)│
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│ 2. Auto-login to root               │
│    ↓ .zlogin triggers configurator  │
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│ 3. Gum-based Configurator           │
│    ↓ Collect user input             │
│    ↓ Disk selection                 │
│    ↓ Encryption setup                │
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│ 4. archinstall                      │
│    ↓ Install base Arch Linux        │
│    ↓ Partition disk                 │
│    ↓ Install bootloader             │
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│ 5. arch-chroot                      │
│    ↓ Clone minimal-hyprland         │
│    ↓ Run install.sh                 │
│    ↓ Install Hyprland packages      │
│    ↓ Configure everything           │
└─────────────────────────────────────┘
           ↓
┌─────────────────────────────────────┐
│ 6. Reboot                           │
│    ↓ Plymouth boot splash           │
│    ↓ SDDM login                     │
│    ↓ Hyprland desktop               │
└─────────────────────────────────────┘
```

## Troubleshooting

### Build Fails

**Error: "No space left on device"**
- Increase work directory size: `sudo mkarchiso -v -w /mnt/large-drive/archiso-work ...`

**Error: "Permission denied"**
- Run mkarchiso with sudo
- Check file permissions in airootfs/

### Boot Fails

**ISO won't boot**
- Disable Secure Boot in BIOS
- Try both UEFI and Legacy boot modes
- Verify USB was written correctly

**Configurator doesn't launch**
- Check `/root/.zlogin` exists and is executable
- Manually run: `minimal-hyprland-configurator`

### Installation Fails

**archinstall errors**
- Check disk path is correct
- Ensure disk is unmounted before installing
- Try without encryption first

**Minimal Hyprland clone fails**
- Check internet connection
- Verify repository URL
- Try different branch/commit

## Advanced Usage

### Offline Installation

To create a fully offline ISO:

1. **Cache packages locally:**

```bash
# On a machine with internet
mkdir -p pkg-cache
sudo pacman -Syw --cachedir pkg-cache $(cat packages.x86_64)
sudo pacman -Syw --cachedir pkg-cache $(cat ../minimal-hyprland/install/minimal-base.packages)
```

2. **Add to ISO:**

```bash
mkdir -p airootfs/var/cache/pacman/pkg
cp pkg-cache/* airootfs/var/cache/pacman/pkg/
```

3. **Clone minimal-hyprland into ISO:**

```bash
mkdir -p airootfs/opt
git clone <your-repo> airootfs/opt/minimal-hyprland
```

4. **Update configurator to use local copy:**

Edit `minimal-hyprland-configurator`, change:

```bash
# From:
git clone https://github.com/$MINIMAL_HYPRLAND_REPO.git ...

# To:
cp -r /opt/minimal-hyprland \$USER_HOME/.local/share/
```

### Custom Branding

**Change ISO name:**

Edit `profiledef.sh`:

```bash
iso_name="your-custom-name"
iso_publisher="Your Name <your@email.com>"
```

**Custom logo in configurator:**

Edit the ASCII art in `minimal-hyprland-configurator` around line 20.

**Add Plymouth theme to ISO:**

```bash
cp -r ../minimal-hyprland/default/plymouth airootfs/usr/share/plymouth/themes/minimal-hyprland/
```

Edit `airootfs/etc/plymouth/plymouthd.conf`:

```ini
[Daemon]
Theme=minimal-hyprland
```

## Testing in VM

Before burning to USB, test in a VM:

### QEMU

```bash
qemu-system-x86_64 \
  -enable-kvm \
  -m 4096 \
  -cdrom ~/iso-output/minimal-hyprland-*.iso \
  -boot d
```

### VirtualBox

1. Create new VM (Arch Linux, 4GB RAM, 20GB disk)
2. Attach ISO to optical drive
3. Boot from optical drive

### VMware

1. Create new VM
2. Select "Installer disc image file (iso)"
3. Choose your ISO

## Contributing

Improvements welcome! Key areas:

- Better error handling in configurator
- More locale/keyboard options
- Pre-download common AUR packages
- Automated testing

## Credits

- Based on [archiso](https://gitlab.archlinux.org/archlinux/archiso)
- Inspired by [Omarchy](https://github.com/basecamp/omarchy)
- Uses [gum](https://github.com/charmbracelet/gum) for beautiful TUI
- Powered by [Hyprland](https://hyprland.org/)

## License

Same as Arch Linux and Hyprland projects.
