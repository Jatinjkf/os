# SnugOS Build Instructions

SnugOS is a minimal, eye-candy Arch Linux-based operating system designed for productivity and focus.

## Included Apps
- **WhatsApp**: Dedicated web app window (Super+W)
- **PW Live**: Dedicated web app window (Super+L)
- **Obsidian**: Native note-taking app (Super+O)
- **OneNote**: Web app window (Super+N)
- **Zathura**: Ultra-fast PDF viewer
- **Thunar**: File manager with Google Drive integration
- **GNOME Clocks**: Alarms and Timers
- **Waybar Pomodoro**: Integrated productivity timer

## How to Build the ISO

To build the ISO, you need an Arch Linux environment (or a machine with `archiso` installed).

1. **Install archiso**:
   ```bash
   sudo pacman -S archiso
   ```

2. **Clone/Copy these files** to your Arch machine.

3. **Build the ISO**:
   ```bash
   cd snug-os/archlive
   sudo mkarchiso -v -w /tmp/archiso-workspace -o ../out .
   ```

4. **Flash to USB**:
   Use BalenaEtcher or `dd` to flash the resulting `.iso` from the `out` directory to your USB stick.

## Usage
- **Boot**: Select your USB from the BIOS/Boot menu.
- **Login**: The system will auto-login to the live environment and start Hyprland.
- **Installer**: Click the "Install SnugOS" icon in the app launcher (Super+Space) to start the installation.
- **Google Drive**: Run `mount-gdrive` from the terminal or launcher to link your account.
