# Quick Start for Windows Users

**The easiest way to build the ISO from Windows: Let GitHub do it for you!**

## 🚀 Method 1: GitHub Actions (Recommended)

### Step 1: Push Your Code to GitHub

If you haven't already:

```powershell
# In PowerShell or Git Bash
git push origin claude/archlinux-hyprland-analysis-011xvqhuFUeJVXaCLTjv97sy
```

### Step 2: Trigger the Build

1. Go to your GitHub repository
2. Click the **"Actions"** tab at the top
3. Click **"Build Minimal Hyprland ISO"** in the left sidebar
4. Click the **"Run workflow"** button (top right)
5. Select your branch: `claude/archlinux-hyprland-analysis-011xvqhuFUeJVXaCLTjv97sy`
6. Click **"Run workflow"**

### Step 3: Wait for Build (20-30 minutes)

Watch the progress in real-time:
- Green checkmark = Success ✅
- Red X = Failed ❌

### Step 4: Download Your ISO

1. Click on the completed workflow run
2. Scroll down to **"Artifacts"**
3. Click **"minimal-hyprland-iso"** to download (it's a .zip file)
4. Extract the .zip to get your ISO file

**That's it!** You now have a bootable ISO built on GitHub's servers.

---

## 💿 Writing ISO to USB (Windows)

### Using Rufus (Recommended)

1. **Download Rufus:** https://rufus.ie/
2. **Insert your USB drive** (8GB+ recommended, **will be erased!**)
3. **Run Rufus:**
   - **Device:** Your USB drive
   - **Boot selection:** Click "SELECT" and choose your ISO
   - **Partition scheme:** GPT
   - **Target system:** UEFI (not CSM)
   - **Volume label:** MINIMAL_HYPRLAND (or whatever you want)
   - Click **"START"**
   - If prompted about ISOHybrid or DD mode, choose **"DD Image"**
   - Confirm you want to erase the USB
4. **Wait 2-5 minutes**
5. **Done!** USB is ready to boot

### Using balenaEtcher (Simpler UI)

1. **Download:** https://www.balena.io/etcher/
2. **Run balenaEtcher:**
   - Click **"Flash from file"** → Select your ISO
   - Click **"Select target"** → Choose your USB drive
   - Click **"Flash!"**
3. **Wait 2-5 minutes**
4. **Done!**

---

## 🖥️ Booting and Installing

### Prepare Your PC

1. **Disable Secure Boot** (required):
   - Restart PC and enter BIOS/UEFI (usually F2, F10, F12, or DEL during boot)
   - Find "Secure Boot" setting (usually under Security or Boot tab)
   - Set to **"Disabled"**
   - Save and exit

2. **Optional: Disable TPM** (if you have issues):
   - In BIOS/UEFI settings
   - Find "TPM" or "Trusted Platform Module"
   - Set to **"Disabled"**

### Boot from USB

1. **Insert the USB drive**
2. **Restart your PC**
3. **Press boot menu key** during startup:
   - Common keys: F12, F8, F10, ESC, F9
   - Dell: F12
   - HP: F9 or ESC
   - Lenovo: F12
   - ASUS: ESC or F8
   - MSI: F11
   - Gigabyte: F12

4. **Select your USB drive** from boot menu
5. **Wait for the installer to load** (15-30 seconds)

### Installation Process

The beautiful gum-based installer will auto-launch and ask you:

1. **Your full name** (e.g., "John Doe")
2. **Email address** (for git config)
3. **Username** (auto-suggested from your name)
4. **Hostname** (your computer's name)
5. **Which disk to install to** (⚠️ will be erased!)
6. **Enable disk encryption?** (recommended for laptops)
   - If yes: enter encryption password (you'll need this on every boot)
7. **Timezone** (auto-detected)
8. **Locale** (language/region, e.g., en_US.UTF-8)
9. **Keyboard layout** (e.g., us, uk, de)
10. **Confirmation** (review everything)

Then it will:
- Install base Arch Linux (~5 minutes)
- Install Minimal Hyprland (~10-15 minutes)
- Configure everything
- Prompt you to reboot

**Total time:** 15-30 minutes depending on your internet speed

### First Boot

1. **Remove the USB drive** when prompted
2. **Reboot**
3. **Watch the beautiful Plymouth boot splash** 🎨
4. **SDDM login screen** appears
5. **Enter your password**
6. **Welcome to Hyprland!** ✨

---

## 🎮 First Steps in Hyprland

### Essential Keybindings

Press these to get started:

- **SUPER + SPACE** → Application launcher (rofi)
- **SUPER + RETURN** → Terminal (kitty)
- **SUPER + E** → File manager (Nautilus)
- **SUPER + W** → Close window
- **SUPER + Q** → Quit Hyprland (logout)

**SUPER** = Windows key on your keyboard

### Connect to WiFi

In terminal (SUPER + RETURN):

```bash
# Launch network manager TUI
nmtui

# Select "Activate a connection"
# Choose your WiFi network
# Enter password
# Done!
```

Or use the GUI:
```bash
# Application launcher (SUPER + SPACE)
# Type: "wifi" or "network"
# Click the network settings app
```

### Update System

```bash
sudo pacman -Syu
```

### Install More Apps

```bash
# Browser
sudo pacman -S firefox

# Code editor
sudo pacman -S code  # VS Code

# Communication
sudo pacman -S discord telegram-desktop

# Media
sudo pacman -S vlc spotify-launcher

# Whatever you want!
yay -S <package-name>  # AUR packages
```

---

## 🔧 Troubleshooting

### ISO Build Failed on GitHub

**Check the error log:**
1. Go to Actions → Failed run
2. Click on the failed step
3. Read the error message

**Common issues:**
- Out of disk space → Will retry automatically
- Network timeout → Re-run the workflow
- Invalid configuration → Check your modifications to archiso-installer/

### USB Won't Boot

**Try these:**
1. ✅ Disable Secure Boot in BIOS
2. ✅ Try both UEFI and Legacy boot modes
3. ✅ Re-write the USB using "DD Image" mode in Rufus
4. ✅ Try a different USB port (USB 2.0 vs 3.0)
5. ✅ Try a different USB drive

### Black Screen After Boot

**Press CTRL+ALT+F2** to get to a terminal, then:
```bash
# Check if Hyprland is running
ps aux | grep hyprland

# If not, start it manually
Hyprland
```

If that doesn't work, check logs:
```bash
cat ~/.hyprland.log
```

### WiFi Not Working

**Check if your WiFi card is detected:**
```bash
ip link

# If you see wlan0 or similar, it's detected
# If not, you may need firmware:
sudo pacman -S linux-firmware
```

For Broadcom cards:
```bash
sudo pacman -S broadcom-wl
```

### Can't Login (Password Rejected)

**Reset password from live USB:**
1. Boot back into the USB
2. Mount your system:
   ```bash
   sudo mount /dev/nvme0n1p2 /mnt  # Adjust device name
   sudo arch-chroot /mnt
   passwd yourusername
   ```

---

## 📚 Next Steps

### Customize Hyprland

Edit configs in `~/.config/hypr/`:

```bash
nvim ~/.config/hypr/bindings.conf     # Change keybindings
nvim ~/.config/hypr/looknfeel.conf    # Change colors, animations
nvim ~/.config/hypr/monitors.conf     # Setup multiple monitors
nvim ~/.config/hypr/autostart.conf    # Add startup apps
```

After editing, reload Hyprland:
**SUPER + SHIFT + R** (or logout and login again)

### Add Your Favorite Apps

Edit the package list before building:

```bash
# Edit minimal-hyprland/install/minimal-base.packages
# Add your packages, then rebuild ISO
```

Or install after:
```bash
sudo pacman -S your-favorite-app
```

### Set Wallpaper

```bash
# Download or copy your wallpaper to:
cp /path/to/wallpaper.jpg ~/.config/hypr/wallpaper.jpg

# Hyprland will use it on next login
```

### Explore

```bash
# System monitor
btop

# File finder
fd <filename>

# Text search
rg <pattern>

# Git helper
lazygit

# Docker helper
lazydocker
```

---

## 🆘 Need More Help?

- **Check logs:** `~/.hyprland.log`
- **Hyprland wiki:** https://wiki.hyprland.org/
- **Arch wiki:** https://wiki.archlinux.org/
- **Ask in Hyprland Discord:** https://discord.gg/hQ9XvMUjjr

---

## 🎉 You Did It!

You now have:
- ✅ A beautiful Hyprland desktop
- ✅ Smooth animations and blur
- ✅ Perfect keybindings
- ✅ Plymouth boot splash
- ✅ Zero bloat
- ✅ Complete customizability

**Enjoy your gorgeous new system!** 🎨✨
