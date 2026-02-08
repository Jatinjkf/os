# SnugOS

![SnugOS Banner](https://img.shields.io/badge/SnugOS-Dragonized_Minimal-ff00ff?style=for-the-badge&logo=archlinux)
![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-00ffff?style=for-the-badge&logo=hyprland)
![Chaotic-AUR](https://img.shields.io/badge/Chaotic_AUR-Enabled-725ac1?style=for-the-badge&logo=archlinux)

**SnugOS** (formerly known as Zenith OS) is a custom Arch Linux distribution designed for creators, gamers, and minimalists. It features a stunning "Dragonized Minimal" desktop environment powered by **Hyprland**, pre-configured for productivity and performance out of the box.

Unlike a vanilla Arch install, SnugOS comes with everything set up: drivers, themes, gaming tools, and creative apps.

## ✨ Key Features

### 🐉 The "Dragonized" Experience
*   **Hyprland Window Manager:** Pre-configured with neon borders (Pink -> Cyan), heavy blur, and smooth animations.
*   **Sweet Dark Theme:** A consistent, modern look across GTK apps with `candy-icons`.
*   **Waybar:** A custom status bar with neon gradients and JetBrains Mono Nerd Fonts.
*   **Auto-Login:** Boot straight into your desktop with `greetd`.

### 🎨 Creative Suite Ready
*   **Tablet Support:** Out-of-the-box support for Wacom, Huion, and XP-Pen tablets via `opentabletdriver` and `wacom` drivers.
*   **Pre-Installed Apps:**
    *   **Krita:** Professional digital painting.
    *   **Xournal++:** Best-in-class handwriting and PDF annotation.
    *   **Rnote:** Modern vector sketching app.
    *   **MyPaint:** Distraction-free infinite canvas.

### 🎮 Gaming & Performance
*   **GameMode:** Optimizes system performance for gaming.
*   **Steam & Lutris:** Ready to play your library.
*   **MangoHud & Goverlay:** Performance monitoring overlay.
*   **Drivers:** Latest Mesa, Vulkan, and proprietary NVIDIA drivers included.

### 🛠️ "It Just Works" Installer
*   **Custom Installer Wrapper:** Our unique installer script (`install-snugos.sh`) wraps `archinstall` to handle the heavy lifting.
*   **Theme Persistence:** Automatically copies the beautiful "Dragonized" configuration (`/etc/skel`) to your installed system, so your fresh install looks exactly like the live USB.
*   **Chaotic-AUR:** Pre-configured access to thousands of community packages (like `opentabletdriver`) without compiling.

## 🚀 Quick Start (Build Your Own ISO)

SnugOS is designed to be built easily on Windows (via WSL2) or Linux using Docker.

### Prerequisites
1.  **Windows 10/11** with WSL2 enabled (Ubuntu recommended).
2.  **Docker Desktop** installed and running.
3.  **Git** installed.

### Build Instructions

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/snug-os.git
    cd snug-os
    ```

2.  **Run the Build Script:**
    This script handles everything: installing dependencies in Docker, setting up keys, and building the ISO.
    ```bash
    bash build_zenith.sh
    ```
    *(Note: The build takes 10-20 minutes depending on your internet speed.)*

3.  **Get Your ISO:**
    Once finished, your bootable ISO will be in the `out/` folder:
    `snug-os-YYYY.MM.DD-x86_64.iso`

## 💿 Installation

1.  **Flash:** Use [Rufus](https://rufus.ie) or [Ventoy](https://www.ventoy.net) to flash the ISO to a USB drive.
2.  **Boot:** Boot your PC from the USB drive.
3.  **Install:**
    *   Once the desktop loads, open the application launcher (Super Key) or terminal (Super + Q).
    *   Run the installer shortcut or type:
        ```bash
        install-snugos
        ```
    *   Follow the on-screen prompts to select your disk and region.
    *   The installer will handle the rest, including copying your themes!

## 📦 Default Credentials
*   **User:** `snug`
*   **Password:** `snug`
*   **Root Password:** (Set during installation)

---
*Built with ❤️ for the Arch Linux Community.*
