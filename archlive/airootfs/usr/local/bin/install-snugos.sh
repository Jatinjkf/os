#!/bin/bash
# SnugOS Installer Wrapper
# This script wraps 'archinstall' and applies SnugOS customizations post-installation.

set -e

# --- Configuration ---
INSTALL_LOG="/tmp/snugos-install.log"
CONFIG_SOURCE="/etc/skel"
PLYMOUTH_CONFIG="/etc/mkinitcpio.conf"

echo "--- SnugOS Installation Wizard ---"
echo "This wizard will install a base Arch system and apply the Dragonized SnugOS theme."
echo "Please follow the on-screen prompts."
echo ""
read -p "Press Enter to begin installation..."

# Step 1: Run Archinstall
# We pipe the output to tee so the user sees it, but we can also capture it if needed.
archinstall 2>&1 | tee "$INSTALL_LOG"

# Step 2: Detect Installation Target
# Archinstall mounts the target at /mnt/archinstall by default in recent versions.
MOUNTPOINT=""
POSSIBLE_MOUNTS=("/mnt/archinstall" "/mnt")

for mount in "${POSSIBLE_MOUNTS[@]}"; do
    if [ -d "$mount/etc" ] && [ -f "$mount/etc/fstab" ]; then
        MOUNTPOINT="$mount"
        break
    fi
done

if [ -z "$MOUNTPOINT" ]; then
    echo "ERROR: Could not detect the installed system at /mnt/archinstall or /mnt."
    echo "Please mount your new root partition to /mnt and run this script again."
    exit 1
fi

echo ""
echo "--- Applying SnugOS Customizations to $MOUNTPOINT ---"

# Step 3: Copy User Configurations (The Dragonized Theme)
echo "Installing SnugOS configs..."
# Copy to skel template so future users get the theme
cp -r "$CONFIG_SOURCE/.config" "$MOUNTPOINT/etc/skel/"
cp "$CONFIG_SOURCE/.bashrc" "$MOUNTPOINT/etc/skel/"
# Also copy to root for consistency
cp -r "$CONFIG_SOURCE/.config" "$MOUNTPOINT/root/"

# Find the primary user created during install and apply theme
for user_home in "$MOUNTPOINT/home"/*; do
    if [ -d "$user_home" ]; then
        user_name=$(basename "$user_home")
        echo "Applying theme to user: $user_name"
        rsync -a "$CONFIG_SOURCE/.config/" "$user_home/.config/"
        arch-chroot "$MOUNTPOINT" chown -R "$user_name:$user_name" "/home/$user_name/.config"
    fi
done

# Step 4: Configure Boot Splash (Plymouth)
echo "Configuring boot splash..."
# Copy our custom mkinitcpio.conf (with 'plymouth' hook)
cp "$PLYMOUTH_CONFIG" "$MOUNTPOINT/etc/mkinitcpio.conf"

# Edit GRUB config to add 'splash' parameter if not present
if [ -f "$MOUNTPOINT/etc/default/grub" ]; then
    if ! grep -q "splash" "$MOUNTPOINT/etc/default/grub"; then
        sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash /' "$MOUNTPOINT/etc/default/grub"
        echo "Updated GRUB configuration."
    fi
fi

# Step 5: Enable Services & Regenerate Initramfs
echo "Finalizing system configuration..."
arch-chroot "$MOUNTPOINT" /bin/bash -c "
    echo 'Enabling services...'
    systemctl enable NetworkManager bluetooth greetd tlp upower

    echo 'Regenerating initramfs for Plymouth...'
    mkinitcpio -P

    if [ -f /boot/grub/grub.cfg ]; then
        echo 'Updating GRUB...'
        grub-mkconfig -o /boot/grub/grub.cfg
    fi
"

echo ""
echo "--- SnugOS Installation Complete! ---"
echo "You can now reboot into your fully configured Dragonized system."
read -p "Press Enter to exit..."
