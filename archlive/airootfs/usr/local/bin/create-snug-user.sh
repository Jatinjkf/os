#!/bin/bash
# Script to create the 'snug' user and configure sudo access on first boot

set -e

# Create the user 'snug' if it doesn't exist
if ! id "snug" &>/dev/null; then
    echo "Creating user 'snug'..."
    useradd -m -G wheel,video,audio,storage,network,sys,optical,uucp,lp,input,kvm -s /bin/bash snug
    echo "snug:snug" | chpasswd
    echo "User 'snug' created successfully."
fi

# Ensure the 'wheel' group can use sudo without a password
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/10-snug-sudoers
chmod 0440 /etc/sudoers.d/10-snug-sudoers
echo "Sudo configured for 'wheel' group."
