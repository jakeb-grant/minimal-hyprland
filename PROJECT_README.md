# Minimal Hyprland Project

Two powerful tools for creating a **beautiful, unopinionated Arch Linux + Hyprland desktop** without the bloat.

## What's Inside

### 1. 📦 minimal-hyprland/
**Unopinionated Hyprland installer with perfect defaults**

- ✨ Beautiful animations, blur, and visual polish
- 🎯 ~60 essential packages (vs 139+ in full Omarchy)
- 🔧 Modular installation pipeline
- 🎨 Gorgeous Hyprland configuration
- 🚫 Zero bloat: No web apps, proprietary software, or opinionated tools

[→ See minimal-hyprland/README.md](minimal-hyprland/README.md)

### 2. 💿 archiso-installer/
**Custom Arch ISO with gum-based interactive installer**

- 🎨 Beautiful TUI powered by gum
- 🚀 Auto-launches on boot
- ⚙️ Wraps archinstall with smart defaults
- 🔐 Optional disk encryption
- 📦 Automatically installs minimal-hyprland after base system

[→ See archiso-installer/README.md](archiso-installer/README.md)

## Quick Start

### Option A: Use the Custom ISO (Recommended)

**1. Build the ISO:**

```bash
cd archiso-installer
sudo ./build-iso.sh
```

**2. Write to USB:**

```bash
sudo dd if=output/minimal-hyprland-*.iso of=/dev/sdX bs=4M status=progress
```

**3. Boot and install:**
- Boot from USB
- Installer launches automatically
- Answer prompts (name, email, disk, etc.)
- Wait for installation
- Reboot to your new system!

### Option B: Manual Installation on Existing Arch

**1. Clone the installer:**

```bash
git clone <this-repo> ~/.local/share/minimal-hyprland
```

**2. Set your info (optional):**

```bash
export MINIMAL_HYPRLAND_USER_NAME="Your Name"
export MINIMAL_HYPRLAND_USER_EMAIL="you@example.com"
```

**3. Run installer:**

```bash
source ~/.local/share/minimal-hyprland/install.sh
```

## What Makes It Beautiful

### Visual Polish from Omarchy

**We kept:**
- ✓ Custom bezier animation curves
- ✓ 3-pass blur on windows
- ✓ Perfect gap sizing (5px inner, 10px outer)
- ✓ No rounded corners (clean aesthetic)
- ✓ Smooth window/border/fade animations
- ✓ Plymouth boot splash
- ✓ Sensible tiling keybindings

**We removed:**
- ✗ 13 web app Chromium wrappers
- ✗ Proprietary apps (1Password, Spotify, Signal, etc.)
- ✗ Heavy bloat (OBS, Kdenlive, LibreOffice)
- ✗ Theme switching system
- ✗ 131 utility scripts
- ✗ Opinionated customizations

### The Result

A **gorgeous Hyprland desktop** with all the visual beauty of Omarchy, but:
- 📉 ~500MB installed vs 2GB+
- 🎯 60 packages vs 139+
- 🧹 Clean, maintainable, understandable
- 🔓 Fully customizable without breaking defaults

## Package Comparison

| Category | Minimal | Full Omarchy |
|----------|---------|--------------|
| Window Manager | hyprland, waybar, mako | ✓ Same |
| Animations/Blur | ✓ Identical config | ✓ Same |
| Terminal | kitty | kitty, alacritty |
| File Manager | nautilus | nautilus |
| Browser | (your choice) | omarchy-chromium |
| Password Manager | (your choice) | 1password |
| Music | (your choice) | spotify |
| Notes | nvim | obsidian, typora |
| Messaging | (your choice) | signal, discord |
| Web Apps | ✗ None | 13 apps |
| Office Suite | (your choice) | libreoffice |
| Video Editing | (your choice) | kdenlive, obs |
| Utility Scripts | Essential only | 131 scripts |
| Theme System | Single theme | 12 themes |

## Architecture

```
.
├── minimal-hyprland/              # The installer
│   ├── install.sh                # Main installer script
│   ├── install/                  # Modular installation pipeline
│   │   ├── preflight/           # Pre-checks
│   │   ├── packaging/           # Package installation
│   │   ├── config/              # Configuration
│   │   ├── login/               # SDDM + Plymouth
│   │   └── post-install/        # Finalization
│   ├── default/                  # Default configs (don't edit!)
│   │   ├── hypr/                # Hyprland configs
│   │   └── plymouth/            # Boot splash
│   └── config/                   # User config templates
│       └── hypr/                # User customizations
│
└── archiso-installer/            # ISO builder
    ├── build-iso.sh             # Build script
    ├── profiledef.sh            # ISO configuration
    ├── packages.x86_64          # Live ISO packages
    └── airootfs/                # Files for ISO
        ├── root/.zlogin         # Auto-launch installer
        └── usr/local/bin/
            └── minimal-hyprland-configurator  # Gum TUI installer
```

## Installation Flow (ISO)

```
Boot ISO → Gum Configurator → archinstall → minimal-hyprland installer → Reboot → Hyprland Desktop
```

**Timeline:** 15-30 minutes total (depending on internet speed)

## Customization

### Hyprland Config

All user configs in `~/.config/hypr/`:

```bash
~/.config/hypr/
├── hyprland.conf    # Sources defaults + your overrides
├── monitors.conf    # Your monitors
├── bindings.conf    # Custom keybindings
├── looknfeel.conf   # Colors, animations
└── autostart.conf   # Startup apps
```

Defaults live in `~/.local/share/minimal-hyprland/default/hypr/` (don't edit!).

### Add Packages

Edit `minimal-hyprland/install/minimal-base.packages`:

```
# Add your packages
firefox
vscode
discord
whatever-you-want
```

### Change ISO Behavior

Edit `archiso-installer/airootfs/usr/local/bin/minimal-hyprland-configurator` to customize:
- Prompts and questions
- Default values
- Installation steps
- Post-install actions

## Key Bindings

- `SUPER + SPACE` - App launcher
- `SUPER + RETURN` - Terminal
- `SUPER + E` - File manager
- `SUPER + W` - Close window
- `SUPER + F` - Fullscreen
- `SUPER + [1-9]` - Switch workspace
- `SUPER + SHIFT + [1-9]` - Move window to workspace
- `SUPER + Arrow Keys` - Focus direction
- `SUPER + SHIFT + Arrow` - Swap windows

Full list: `minimal-hyprland/default/hypr/bindings/`

## Requirements

### For Building ISO:
- Arch Linux (or Arch-based system)
- `archiso` package
- Sudo access
- 10GB+ free space

### For Running Installer:
- Fresh Arch Linux installation
- Internet connection (for package downloads)
- User account created

## Philosophy

**Omarchy is beautiful but opinionated.**

This project extracts the beauty (Hyprland config, animations, polish) while removing the opinions (forced apps, themes, workflows).

You get:
1. A **perfect starting point** for Hyprland
2. A **beautiful installer** that respects your choices
3. A **clean foundation** to build upon

No more, no less.

## Comparison Table

| Feature | Minimal Hyprland | Full Omarchy | Plain Arch |
|---------|------------------|--------------|------------|
| Beautiful animations | ✓ | ✓ | Manual config |
| Blur/transparency | ✓ | ✓ | Manual config |
| Plymouth splash | ✓ | ✓ | ✗ |
| Perfect keybindings | ✓ | ✓ | Manual config |
| Gum installer | ✓ | ✓ | archinstall |
| Web apps | ✗ | 13 apps | ✗ |
| Proprietary apps | ✗ | Multiple | ✗ |
| Theme switching | ✗ | 12 themes | ✗ |
| Package count | ~60 | 139+ | Minimal |
| Disk usage | ~500MB | 2GB+ | ~1GB |
| Customizable | ✓✓✓ | ✓ | ✓✓✓ |

## Credits

- **Inspired by:** [Omarchy](https://github.com/basecamp/omarchy) by DHH & Basecamp
- **Built with:** [archiso](https://gitlab.archlinux.org/archlinux/archiso), [gum](https://github.com/charmbracelet/gum), [Hyprland](https://hyprland.org/)
- **Philosophy:** Beauty without bloat, opinions without force

## Contributing

Improvements welcome! This is meant to be a clean, maintainable foundation.

**Good PRs:**
- Bug fixes
- Better error handling
- Documentation improvements
- Essential package additions

**Please avoid:**
- Opinionated app additions
- Bloat
- Breaking the clean structure

## License

Follow upstream licenses (Arch Linux, Hyprland, Omarchy derivatives).

---

**Enjoy your beautiful, minimal Hyprland setup! 🎨**
