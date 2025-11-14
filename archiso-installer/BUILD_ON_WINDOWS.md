# Building the ISO on Windows

Since `mkarchiso` is a Linux-only tool, you have several options for building the ISO from Windows.

## Option 1: GitHub Actions (Recommended - Easiest!)

**Let GitHub build the ISO for you automatically!**

### Setup

1. **Push to GitHub:**
   ```powershell
   git push origin your-branch
   ```

2. **Enable GitHub Actions:**
   - Go to your repo on GitHub
   - Click "Actions" tab
   - Enable workflows

3. **Trigger a build:**
   - Go to "Actions" → "Build Minimal Hyprland ISO"
   - Click "Run workflow"
   - Select your branch
   - Click "Run workflow"

4. **Download the ISO:**
   - Wait 20-30 minutes for build to complete
   - Go to the workflow run
   - Download the ISO from "Artifacts"

**Pros:**
- ✓ No local setup needed
- ✓ Free (GitHub provides runners)
- ✓ Can build on every commit
- ✓ Works from any OS

**Cons:**
- ✗ Requires internet
- ✗ 20-30 minute wait time
- ✗ 500MB artifact download limit

---

## Option 2: WSL2 with Arch Linux (Best Local Option)

**Run Arch Linux directly on Windows!**

### Setup WSL2

1. **Enable WSL2:**
   ```powershell
   # Run as Administrator in PowerShell
   wsl --install
   ```

2. **Install Arch Linux:**
   ```powershell
   # Download ArchWSL from https://github.com/yuk7/ArchWSL/releases
   # Extract to C:\ArchWSL
   # Run Arch.exe
   ```

   Or use the official Arch Linux app from Microsoft Store (if available).

3. **Initialize Arch:**
   ```bash
   # Inside WSL Arch
   pacman-key --init
   pacman-key --populate archlinux
   pacman -Syu
   ```

4. **Install archiso:**
   ```bash
   sudo pacman -S archiso git
   ```

### Build the ISO

1. **Clone your repo:**
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   git checkout your-branch
   ```

2. **Build:**
   ```bash
   cd archiso-installer
   sudo ./build-iso.sh
   ```

3. **Access from Windows:**
   The ISO will be in `output/` directory.

   From Windows Explorer, access it at:
   ```
   \\wsl$\Arch\home\yourusername\your-repo\archiso-installer\output\
   ```

   Or copy to Windows:
   ```bash
   cp output/*.iso /mnt/c/Users/YourName/Downloads/
   ```

**Pros:**
- ✓ Native Linux performance
- ✓ Fast builds (10-15 minutes)
- ✓ Full control
- ✓ No VM overhead

**Cons:**
- ✗ WSL2 setup required
- ✗ Uses disk space (~2GB)

---

## Option 3: VirtualBox / VMware (Most Compatible)

**Run Arch Linux in a virtual machine.**

### Setup

1. **Download Arch Linux ISO:**
   - https://archlinux.org/download/

2. **Create VM:**
   - **VirtualBox:**
     - New VM: "Arch Linux (64-bit)"
     - 2-4 GB RAM
     - 20 GB disk
     - Mount Arch ISO

   - **VMware:**
     - New VM: "Other Linux 5.x kernel 64-bit"
     - 2-4 GB RAM
     - 20 GB disk
     - Mount Arch ISO

3. **Install Arch:**
   ```bash
   # Boot the VM
   # Run archinstall for quick setup
   archinstall

   # Choose:
   # - Disk: Use entire disk
   # - Bootloader: systemd-boot
   # - Profile: minimal
   # - Network: NetworkManager
   # - Create a user account
   ```

4. **Install tools:**
   ```bash
   # After reboot
   sudo pacman -S archiso git base-devel
   ```

### Build the ISO

1. **Share folder with Windows:**

   **VirtualBox:**
   - VM Settings → Shared Folders
   - Add: `C:\Users\YourName\VMs\shared`
   - Mount in VM:
     ```bash
     sudo mount -t vboxsf shared /mnt/shared
     ```

   **VMware:**
   - VM Settings → Options → Shared Folders
   - Enable and add folder
   - Mount automatically in `/mnt/hgfs/shared`

2. **Clone and build:**
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   git checkout your-branch
   cd archiso-installer
   sudo ./build-iso.sh
   ```

3. **Copy to shared folder:**
   ```bash
   cp output/*.iso /mnt/shared/
   ```

4. **Access from Windows:**
   Check `C:\Users\YourName\VMs\shared\`

**Pros:**
- ✓ Full Arch Linux environment
- ✓ Works on any Windows version
- ✓ Can snapshot VM state

**Cons:**
- ✗ Large download (Arch ISO ~800MB)
- ✗ VM overhead (slower)
- ✗ More disk space needed (~5GB)

---

## Option 4: Docker (Advanced)

**Use an Arch Linux Docker container.**

### Setup

1. **Install Docker Desktop:**
   - Download from https://www.docker.com/products/docker-desktop
   - Install and start Docker Desktop
   - Enable WSL2 backend in settings

2. **Create build container:**

   Save this as `Dockerfile` in `archiso-installer/`:

   ```dockerfile
   FROM archlinux:latest

   RUN pacman -Syu --noconfirm && \
       pacman -S --noconfirm archiso git base-devel sudo

   WORKDIR /build

   CMD ["/bin/bash"]
   ```

3. **Build Docker image:**
   ```powershell
   cd archiso-installer
   docker build -t arch-iso-builder .
   ```

### Build the ISO

1. **Run container with your code:**
   ```powershell
   docker run --privileged -v ${PWD}:/build -it arch-iso-builder
   ```

2. **Inside container:**
   ```bash
   cd /build
   ./build-iso.sh
   ```

3. **ISO will be in `output/` folder** on your Windows filesystem.

**Pros:**
- ✓ Isolated environment
- ✓ Reproducible builds
- ✓ Easy to script

**Cons:**
- ✗ Docker learning curve
- ✗ Requires privileged mode
- ✗ May have permission issues

---

## Option 5: Cloud Build Server

**Use a free cloud service to build.**

### Using GitHub Codespaces

1. **Open repo in Codespaces:**
   - Go to GitHub repo
   - Click "Code" → "Codespaces" → "Create codespace"

2. **Install archiso:**
   ```bash
   # Codespaces runs Ubuntu, not Arch
   # This won't work directly - use GitHub Actions instead
   ```

### Using a Free Cloud VM

**DigitalOcean, Linode, Vultr, etc. offer free trials:**

1. **Create an Arch Linux droplet** (typically $5-10/month)
2. **SSH in and build:**
   ```bash
   sudo pacman -S archiso git
   git clone your-repo
   cd your-repo/archiso-installer
   sudo ./build-iso.sh
   ```
3. **Download via SCP:**
   ```powershell
   scp user@your-server:~/path/to/output/*.iso C:\Downloads\
   ```
4. **Destroy the droplet** (to avoid charges)

**Pros:**
- ✓ Native Arch Linux
- ✓ Fast builds
- ✓ Access from anywhere

**Cons:**
- ✗ Costs money (unless free trial)
- ✗ Requires cloud account
- ✗ Network upload/download

---

## Comparison

| Method | Difficulty | Speed | Cost | Best For |
|--------|-----------|-------|------|----------|
| **GitHub Actions** | ⭐ Easy | 20-30 min | Free | One-off builds, CI/CD |
| **WSL2** | ⭐⭐ Medium | 10-15 min | Free | Regular development |
| **VirtualBox** | ⭐⭐ Medium | 15-25 min | Free | Full Linux testing |
| **Docker** | ⭐⭐⭐ Hard | 10-15 min | Free | Advanced users |
| **Cloud VM** | ⭐⭐ Medium | 10-15 min | $5-10 | Occasional builds |

---

## Recommended Workflow

**For most users:**

1. **Use GitHub Actions for automated builds** (easiest!)
2. **Use WSL2 for development and testing** (fastest local option)

**Setup both:**

- Push to GitHub → Automatic ISO builds available to download
- Use WSL2 locally → Quick iterations during development

---

## After Building: Write ISO to USB on Windows

### Using Rufus (Recommended)

1. **Download Rufus:** https://rufus.ie/
2. **Insert USB drive** (will be erased!)
3. **Run Rufus:**
   - Device: Your USB drive
   - Boot selection: Select your ISO
   - Partition scheme: GPT
   - Target system: UEFI
   - Click "START"

### Using balenaEtcher

1. **Download:** https://www.balena.io/etcher/
2. **Run balenaEtcher:**
   - Select ISO
   - Select USB drive
   - Flash!

### Using dd in WSL2

```bash
# Find USB drive
lsblk

# Write ISO (replace sdX with your drive)
sudo dd if=output/minimal-hyprland-*.iso of=/dev/sdX bs=4M status=progress && sync
```

**⚠️ WARNING:** Double-check the device name! `dd` will overwrite without confirmation.

---

## Troubleshooting

### "Permission denied" in Docker
- Run Docker Desktop as Administrator
- Enable "Expose daemon on tcp://localhost:2375" in settings

### "No space left" in WSL2
- Increase WSL2 disk size:
  ```powershell
  wsl --shutdown
  # Edit %UserProfile%\.wslconfig
  [wsl2]
  memory=4GB
  swap=8GB
  ```

### VM is slow
- Allocate more RAM (4GB recommended)
- Enable virtualization in BIOS (VT-x/AMD-V)
- Use SSD if available

### ISO won't boot
- Disable Secure Boot in BIOS
- Try both UEFI and Legacy boot modes
- Verify ISO with checksum after download

---

## Need Help?

- **WSL2:** https://docs.microsoft.com/en-us/windows/wsl/
- **VirtualBox:** https://www.virtualbox.org/manual/
- **Docker:** https://docs.docker.com/desktop/windows/
- **Rufus:** https://rufus.ie/en/

**Recommended path:** Start with GitHub Actions to get your first ISO, then set up WSL2 for future development.
