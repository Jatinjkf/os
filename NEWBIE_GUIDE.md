# SnugOS - Step-by-Step Installation Guide

Welcome to the world of SnugOS! This guide will walk you through building your own ISO, creating a bootable USB, and installing the operating system.

## 🛠️ Prerequisites

Before you start, make sure you have:

1.  **A Computer:** Running Windows 10/11 or Linux.
2.  **WSL 2 (Windows Subsystem for Linux):** Installed and running.
    *   *To enable:* Open PowerShell as Administrator and run `wsl --install`.
    *   *Then install Ubuntu:* `wsl --install -d Ubuntu`.
3.  **Docker Desktop:** Installed and running.
    *   *Download:* [Docker Desktop](https://www.docker.com/products/docker-desktop)
    *   *Why?* We use Docker to build the Arch ISO safely without messing up your main system.
4.  **A USB Flash Drive:** At least 4GB, for installation.

---

## 🏗️ Building the ISO (Part 1)

1.  **Clone the SnugOS Repository:**
    Open your WSL terminal (e.g., Ubuntu) and run:
    ```bash
    git clone https://github.com/your-username/snug-os.git
    cd snug-os
    ```

2.  **Start the Build:**
    Run the build script. This will download everything needed and create your ISO.
    ```bash
    bash build_zenith.sh
    ```
    *   *Note:* This process takes 10-20 minutes depending on your internet speed. Be patient!
    *   *Troubleshooting:* If you see errors about "permissions" or "docker socket", verify Docker Desktop is running.

3.  **Locate Your ISO:**
    Once the script finishes successfully, check the `out/` folder in your project directory.
    You will see a file named something like:
    `snug-os-202X.MM.DD-x86_64.iso`

---

## 💾 Creating Bootable Media (Part 2)

Now that you have the ISO file, you need to put it on a USB drive so you can boot from it.

### Using Rufus (Windows)
1.  Download [Rufus](https://rufus.ie).
2.  Plug in your USB drive.
3.  Open Rufus.
4.  Select your USB drive under "Device".
5.  Click "SELECT" and choose your `snug-os-...iso` file.
6.  Click "START". Rufus might ask to download "Syslinux" or similar files—click "Yes".
7.  Wait for it to finish.

### Using Ventoy (Recommended)
1.  Download [Ventoy](https://www.ventoy.net).
2.  Install Ventoy to your USB drive.
3.  Simply **copy and paste** the `snug-os-...iso` file onto the USB drive.
4.  Done! Ventoy lets you boot multiple ISOs easily.

---

## 💿 Installing SnugOS (Part 3)

1.  **Boot from USB:**
    *   Restart your computer.
    *   Enter your BIOS/UEFI settings (usually F2, Del, or F12 during startup).
    *   Select your USB drive as the boot device.

2.  **Welcome to SnugOS Live:**
    You will boot straight into the beautiful "Dragonized" desktop! Feel free to explore.
    *   **Open Terminal:** Super + Q
    *   **Application Menu:** Super + R (or just start typing)

3.  **Start Installation:**
    *   Launch the "Install SnugOS" shortcut on the desktop.
    *   Or open a terminal and type:
        ```bash
        install-snugos
        ```

4.  **Follow the Prompts:**
    The installer will ask you:
    *   **Language & Keyboard Layout:** (Default is US English)
    *   **Disk Selection:** Choose the drive you want to install on. *Warning: This will erase the disk!*
    *   **Filesystem:** Btrfs or Ext4 (Btrfs is recommended for snapshots).
    *   **Hostname:** Name your computer (e.g., `snug-pc`).
    *   **Root Password:** Set a secure password for the administrator account.
    *   **User Account:** Create your main user (e.g., `snug`).

5.  **Reboot:**
    Once installation is complete, reboot your computer and remove the USB drive.

**Congratulations! You are now running SnugOS!** 🎉
