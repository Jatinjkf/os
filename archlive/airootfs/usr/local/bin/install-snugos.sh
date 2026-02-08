#!/bin/bash
# SnugOS Installer Wrapper
# This script runs 'archinstall' and then copies SnugOS configurations to the new system.

set -e

echo "--- Welcome to the SnugOS Installer ---"
echo "This wizard will help you install SnugOS (based on Arch Linux) to your disk."
echo ""
echo "Step 1: Run the standard Arch Linux installer."
echo "Step 2: After installation, DO NOT REBOOT yet."
echo "Step 3: This script will copy the Dragonized theme and settings to your new system."
echo ""
read -p "Press Enter to start the installation..."

# Run archinstall
archinstall

# Check if the installation was successful (look for mounted root)
MOUNTPOINT="/mnt/archinstall"

if [ ! -d "$MOUNTPOINT/etc" ]; then
    # Try default mount point used by manual installs or if archinstall changed
    MOUNTPOINT="/mnt"
fi

if [ ! -d "$MOUNTPOINT/etc" ]; then
    echo ""
    echo "WARNING: Could not find the installed system at /mnt or /mnt/archinstall."
    echo "The installation may have failed or was not mounted."
    echo "Please mount your new root partition to /mnt manually and run this script again to apply themes."
    exit 1
fi

echo ""
echo "--- applying SnugOS configurations ---"
echo "Copying dotfiles to new system..."

# Copy skel (user templates)
cp -r /etc/skel/.config "$MOUNTPOINT/etc/skel/"
cp -r /etc/skel/.bashrc "$MOUNTPOINT/etc/skel/"
# Also copy to root for consistency
cp -r /etc/skel/.config "$MOUNTPOINT/root/"

# Enable services in the new system
echo "Enabling services (NetworkManager, Bluetooth, Greetd)..."
arch-chroot "$MOUNTPOINT" systemctl enable NetworkManager bluetooth greetd

# Attempt to find the new user created by archinstall
# This is tricky, so we rely on /etc/skel for new users created LATER.
# But for the primary user created during install, we try to find them in /home.
for user_home in "$MOUNTPOINT/home"/*; do
    if [ -d "$user_home" ]; then
        user_name=$(basename "$user_home")
        echo "Applying theme to user: $user_name"
        cp -r /etc/skel/.config "$user_home/"
        # Fix permissions
        arch-chroot "$MOUNTPOINT" chown -R "$user_name:$user_name" "/home/$user_name/.config"
    fi
done

echo ""
echo "--- SnugOS Installation Complete! ---"
echo "You can now reboot into your new Dragonized Minimal system."
read -p "Press Enter to close..."
