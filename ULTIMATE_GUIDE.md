# SnugOS - The Ultimate Technical Guide

This guide is for power users, developers, and those who want to understand the inner workings of SnugOS (formerly Zenith OS). It covers the architecture, the build process, the installer logic, and post-installation customization.

## 🏗️ Architecture Overview

SnugOS is built on top of **Arch Linux** using the `archiso` toolchain. However, it significantly deviates from a standard Arch install in several key ways:

### 1. The "Live-to-Install" Philosophy
Unlike most distros that install a fresh set of packages, SnugOS aims to persist the **exact configuration** of the live environment to the installed system.
*   **Live Environment:** Uses a read-only `airootfs` (Arch Linux Installation Root Filesystem).
*   **Configuration:** All custom dotfiles (Hyprland, Waybar, GTK themes) are stored in `/etc/skel/` within the ISO.
*   **User Creation:** On boot, a systemd service (`create-snug-user`) runs `customize_airootfs.sh` to create the `snug` user and apply these dotfiles.

### 2. The Custom Installer Wrapper (`install-snugos.sh`)
The standard `archinstall` script is powerful but generic. It doesn't know about our custom themes.
*   **How it works:** We wrap `archinstall` with a custom script (`/usr/local/bin/install-snugos.sh`).
*   **Process:**
    1.  Runs `archinstall` to partition disks, install base packages, and set up the user.
    2.  **Crucially:** It mounts the newly installed system's partition.
    3.  It uses `rsync` to copy the entire `/etc/skel/` directory from the live ISO to the new user's home directory (`/home/$USER`).
    4.  It enables essential services (`greetd`, `NetworkManager`, `bluetooth`) on the target system.
    5.  It regenerates the `initramfs` to include the Plymouth boot splash.

### 3. Chaotic-AUR Integration
SnugOS leverages the **Chaotic-AUR** repository to provide pre-built binary packages for software not in the official Arch repos.
*   **Why?** Building complex packages like `opentabletdriver` or `hyprland-git` from source during ISO creation is slow and error-prone.
*   **Implementation:** The build script (`build_zenith.sh`) imports the Chaotic-AUR GPG keys and adds the repository to the build container's `pacman.conf`.

---

## 🛠️ Build System Internals

The build process is automated via `build_zenith.sh` and runs inside a Docker container.

### Key Components:
1.  **`build_zenith.sh`**: The orchestrator.
    *   Checks for Docker.
    *   Spins up an `archlinux:latest` container.
    *   Installs build dependencies (`archiso`, `grub`, `dosfstools`).
    *   **Fixes:** Handles Windows CRLF line endings, initializes pacman keyrings, and sets up Chaotic-AUR mirrors.
    *   **Branding:** dynamically patches bootloader configs (`syslinux`, `grub`) to replace "Arch Linux" with "SnugOS".

2.  **`packages.x86_64`**: The package manifest.
    *   Contains every package to be installed on the ISO.
    *   Includes: `base`, `linux`, `hyprland`, `nvidia`, `mesa`, `kio`, `dolphin`, `krita`, etc.

3.  **`airootfs/`**: The root filesystem overlay.
    *   Files here are copied directly to the ISO's root directory.
    *   `etc/skel/`: Default user configuration (dotfiles).
    *   `usr/local/bin/`: Custom scripts (`install-snugos.sh`, `snug-welcome`).
    *   `etc/systemd/system/`: Enabled services.

---

## 🎨 The "Dragonized" Aesthetics

The visual identity of SnugOS is defined by:

*   **Hyprland Config (`~/.config/hypr/hyprland.conf`):**
    *   **Borders:** Neon gradients (Pink `#ff00ff` to Cyan `#00ffff`).
    *   **Blur:** Heavy blur (size 6, passes 3) enabled for transparent windows.
    *   **Animations:** Smooth `bezier` curves for window open/close.
    *   **Window Rules:** Specific opacity rules for `kitty`, `dolphin`, and `wofi`.

*   **Waybar (`~/.config/waybar/`):**
    *   Custom CSS with neon gradients and rounded modules.
    *   Uses `JetBrains Mono Nerd Font` for icons.

*   **GTK Theme:**
    *   **Theme:** `Sweet-Dark` (for that deep purple/neon look).
    *   **Icons:** `candy-icons` (colorful, gradient-heavy icons).

---

## 🔧 Post-Install & Maintenance

### Updating the System
Since SnugOS is Arch-based, you use `pacman`:
```bash
sudo pacman -Syu
```

### Installing AUR Packages
We include a helper script `install-yay` to bootstrap the `yay` AUR helper:
```bash
install-yay
yay -S package-name
```

### Tablet Configuration
We use **OpenTabletDriver** (`otd-daemon`).
*   **GUI:** Open "OpenTabletDriver GUI" from the menu to map buttons and area.
*   **Daemon:** It starts automatically via `exec-once` in Hyprland config.

### Customizing Boot Splash
The boot splash uses **Plymouth**. To change it:
1.  Install a new theme (e.g., from AUR).
2.  Edit `/etc/plymouth/plymouthd.conf`.
3.  Run: `sudo plymouth-set-default-theme -R <theme-name>`

---

**Happy Hacking!**
