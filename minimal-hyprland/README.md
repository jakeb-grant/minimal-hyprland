# Minimal Hyprland

A beautiful, unopinionated Hyprland desktop environment with perfect defaults and zero bloat.

## What's Included

### Core Features
- **Hyprland** - Modern Wayland compositor with gorgeous animations
- **Beautiful defaults** - Carefully tuned bezier curves, blur, and gaps
- **Essential tools only** - ~60 packages vs 139+ in full Omarchy
- **Modular configuration** - Easy to customize without breaking defaults

### The Beautiful Bits
- Smooth animations with custom easing curves
- 3-pass blur on windows
- Clean tiling with sensible keybindings
- Plymouth boot splash
- SDDM display manager

### What's NOT Included (vs Full Omarchy)
- ❌ Web apps (13 Chromium wrappers)
- ❌ Proprietary apps (1Password, Spotify, Signal)
- ❌ Heavy apps (OBS, Kdenlive, LibreOffice)
- ❌ Theme switching system
- ❌ 131 utility scripts
- ❌ Opinionated customizations

## Installation

### Prerequisites
- Fresh Arch Linux installation
- User account created
- Internet connection

### Quick Install

```bash
# Clone to ~/.local/share
git clone <your-repo> ~/.local/share/minimal-hyprland

# Set your details (optional)
export MINIMAL_HYPRLAND_USER_NAME="Your Name"
export MINIMAL_HYPRLAND_USER_EMAIL="you@example.com"

# Run installer
source ~/.local/share/minimal-hyprland/install.sh
```

### What It Does

1. **Preflight** - Configure pacman, update databases
2. **Packaging** - Install ~60 essential packages
3. **Config** - Copy Hyprland configs to ~/.config/hypr/
4. **Login** - Setup SDDM + Plymouth
5. **Post-Install** - Finish and offer reboot

## Package List (~60 packages)

**Window Manager Stack:**
- hyprland, hypridle, hyprlock, hyprsunset, uwsm
- waybar, mako, rofi-wayland
- swaybg, brightnessctl, wl-clipboard

**Essential Apps:**
- kitty, nautilus, evince
- firefox (or your browser choice)

**Development:**
- nvim, git, github-cli, mise, docker, lazygit

**Utilities:**
- grim, slurp, satty (screenshots)
- btop, fastfetch, ripgrep, fd, fzf, eza, bat, gum

**See full list:** `install/minimal-base.packages`

## Customization

All configs live in `~/.config/hypr/`:

```
~/.config/hypr/
├── hyprland.conf    # Main config (sources defaults)
├── monitors.conf    # Your monitor setup
├── bindings.conf    # Custom keybindings
├── input.conf       # Input device overrides
├── envs.conf        # Environment variables
├── looknfeel.conf   # Colors, animations, borders
└── autostart.conf   # Startup applications
```

**Defaults are in:** `~/.local/share/minimal-hyprland/default/hypr/`

**Don't edit defaults!** Override them in `~/.config/hypr/`

## Key Bindings (Defaults)

- `SUPER + SPACE` - App launcher (rofi)
- `SUPER + RETURN` - Terminal (kitty)
- `SUPER + E` - File manager (nautilus)
- `SUPER + W` - Close window
- `SUPER + F` - Fullscreen
- `SUPER + T` - Toggle floating
- `SUPER + [1-9]` - Switch workspace
- `SUPER + SHIFT + [1-9]` - Move window to workspace
- `SUPER + Arrow Keys` - Move focus
- `SUPER + SHIFT + Arrow Keys` - Swap windows

See all bindings: `~/.local/share/minimal-hyprland/default/hypr/bindings/`

## Architecture

```
minimal-hyprland/
├── install.sh                 # Main installer
├── install/
│   ├── helpers/              # Logging, presentation
│   ├── preflight/            # Pre-install checks
│   ├── packaging/            # Package installation
│   ├── config/               # Configuration setup
│   ├── login/                # SDDM, Plymouth
│   └── post-install/         # Finalization
├── default/
│   ├── hypr/                 # Default Hyprland configs
│   └── plymouth/             # Boot splash theme
└── config/
    └── hypr/                 # User config templates
```

## Plymouth Theme

The included Plymouth theme features:
- Custom Omarchy-style background
- Animated progress bar with easing
- Password dialog
- Matches Hyprland aesthetics

## Comparison to Full Omarchy

| Feature | Minimal | Full Omarchy |
|---------|---------|--------------|
| Packages | ~60 | 139+ |
| Hyprland configs | ✓ | ✓ |
| Animations/blur | ✓ | ✓ |
| Plymouth | ✓ | ✓ |
| Web apps | ✗ | 13 apps |
| Theme switching | ✗ | 12 themes |
| Proprietary apps | ✗ | Multiple |
| Utility scripts | Essential only | 131 scripts |
| Install size | ~500MB | 2GB+ |

## Philosophy

**Minimal Hyprland** keeps what makes Omarchy beautiful:
- ✓ Perfect Hyprland configuration
- ✓ Smooth animations and visual polish
- ✓ Sensible defaults that just work

But strips away the opinions:
- ✗ No forced apps or workflows
- ✗ No proprietary software
- ✗ No theme system overhead
- ✗ No utility script bloat

**You get:** A gorgeous foundation to build upon.

## Credits

Based on [Omarchy](https://github.com/basecamp/omarchy) by DHH and the Basecamp team.

This is an unopinionated derivative focusing on core beauty and functionality.
