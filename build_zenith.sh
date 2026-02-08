#!/usr/bin/env bash
# SnugOS automated build script for Windows/WSL users
# This script runs inside WSL and uses Docker to build the Arch ISO.

echo "--- SnugOS 'Chef' Script ---"

# 1. Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker Desktop or the Docker service in WSL."
    exit 1
fi

# 2. Create local directory for the build
mkdir -p ./out

# 3. Use Docker to build the ISO
echo "Starting build... this may take 10-20 minutes depending on your internet speed."
docker run --privileged --rm \
    -v "$(pwd)/archlive:/archlive" \
    -v "$(pwd)/out:/out" \
    archlinux:latest bash -c "
        # 1. Install archiso and tools (ensure grub is installed on host for mkarchiso)
        pacman -Sy --noconfirm archiso && \
        pacman -S --noconfirm --needed grub dosfstools mtools libisoburn && \

        # 1.5 Setup Chaotic-AUR (for OpenTabletDriver and other community packages)
        # Initialize pacman keyring properly first
        pacman-key --init && \
        pacman-key --populate archlinux && \
        # Import the chaotic key
        pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
        pacman-key --lsign-key 3056513887B78AEB && \
        # Install the keyring and mirrorlist directly
        pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' && \
        pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-mirrorlist.pkg.tar.zst' && \
        # Ensure the mirrorlist exists where pacman.conf expects it (mkarchiso quirk)
        if [ ! -f /etc/pacman.d/chaotic-mirrorlist ]; then
            echo "WARNING: chaotic-mirrorlist not found in /etc/pacman.d/. Searching..."
            find / -name chaotic-mirrorlist -exec cp {} /etc/pacman.d/ \;
        fi && \
        # Fallback: Create it if still missing
        if [ ! -f /etc/pacman.d/chaotic-mirrorlist ]; then
             echo "Server = https://cdn-mirror.chaotic.cx/chaotic-aur/x86_64" > /etc/pacman.d/chaotic-mirrorlist
        fi && \

        # 2. Fix potential line ending issues in package list (Windows/CRLF fix)
        sed -i 's/\r$//' /archlive/packages.x86_64 && \

        # 3. Setup Bootloader Configurations
        # Check for specific files instead of just directories to handle empty folders
        if [ ! -f /archlive/syslinux/syslinux.cfg ]; then
            echo 'Copying default syslinux config...';
            rm -rf /archlive/syslinux 2>/dev/null || true
            cp -r /usr/share/archiso/configs/releng/syslinux /archlive/;
        fi && \
        if [ ! -f /archlive/grub/grub.cfg ]; then
            echo 'Copying default grub config...';
            rm -rf /archlive/grub 2>/dev/null || true
            cp -r /usr/share/archiso/configs/releng/grub /archlive/;
        fi && \
        if [ ! -f /archlive/efiboot/loader/loader.conf ]; then
            echo 'Copying default efiboot config...';
            rm -rf /archlive/efiboot 2>/dev/null || true
            cp -r /usr/share/archiso/configs/releng/efiboot /archlive/;
        fi && \

        # 4. Apply SnugOS Branding
        #    This ensures the boot menu shows 'SnugOS' instead of 'Arch Linux'
        echo 'Applying SnugOS branding to bootloaders...' && \
        sed -i 's/Arch Linux/SnugOS/g' /archlive/syslinux/*.cfg 2>/dev/null || true && \
        sed -i 's/Arch Linux/SnugOS/g' /archlive/grub/grub.cfg 2>/dev/null || true && \
        sed -i 's/Arch Linux/SnugOS/g' /archlive/efiboot/loader/entries/*.conf 2>/dev/null || true && \

        # Add 'splash' kernel parameter for Plymouth
        echo 'Enabling Plymouth boot splash...' && \
        sed -i 's/quiet/quiet splash/g' /archlive/syslinux/*.cfg 2>/dev/null || true && \
        sed -i 's/quiet/quiet splash/g' /archlive/grub/grub.cfg 2>/dev/null || true && \
        sed -i 's/options /options splash /g' /archlive/efiboot/loader/entries/*.conf 2>/dev/null || true && \

        # 5. Apply SnugOS Boot Logo
        if [ -f /archlive/logo.png ]; then
            echo 'Applying custom boot logo...'
            cp /archlive/logo.png /archlive/syslinux/splash.png 2>/dev/null || true
            cp /archlive/logo.png /archlive/grub/splash.png 2>/dev/null || true
        else
            echo 'WARNING: No logo.png found in /archlive. Using default Arch splash.'
        fi && \

        # 6. Build the ISO
        mkarchiso -v -w /tmp/archiso-workspace -o /out /archlive
    "

if [ $? -eq 0 ]; then
    echo "--- SUCCESS! ---"
    echo "Your ISO is ready in the 'out' folder."
    echo "File: $(ls ./out/*.iso)"
else
    echo "--- FAILED ---"
    echo "Something went wrong during the build."
fi
