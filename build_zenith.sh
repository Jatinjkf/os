#!/usr/bin/env bash
# Zenith OS automated build script for Windows/WSL users
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
        # 1. Install archiso and grub (needed for UEFI bootloader generation)
        pacman -Sy --noconfirm archiso grub && \

        # 2. Copy missing bootloader configurations from the default 'releng' profile
        #    This fixes errors about missing syslinux/grub directories.
        if [ ! -d /archlive/syslinux ]; then
            echo 'Copying default syslinux config...';
            cp -r /usr/share/archiso/configs/releng/syslinux /archlive/;
        fi && \
        if [ ! -d /archlive/grub ]; then
            echo 'Copying default grub config...';
            cp -r /usr/share/archiso/configs/releng/grub /archlive/;
        fi && \
        if [ ! -d /archlive/efiboot ]; then
            echo 'Copying default efiboot config...';
            cp -r /usr/share/archiso/configs/releng/efiboot /archlive/;
        fi && \

        # 3. Customize Bootloader Names (Arch Linux -> SnugOS)
        #    This ensures the boot menu shows "SnugOS" instead of "Arch Linux"
        echo 'Customizing bootloader labels...' && \
        sed -i 's/Arch Linux/SnugOS/g' /archlive/syslinux/*.cfg 2>/dev/null || true && \
        sed -i 's/Arch Linux/SnugOS/g' /archlive/grub/grub.cfg 2>/dev/null || true && \
        sed -i 's/Arch Linux/SnugOS/g' /archlive/efiboot/loader/entries/*.conf 2>/dev/null || true && \

        # 4. Customize Boot Logo (Optional)
        #    If a 'logo.png' exists in archlive/, use it as the splash screen.
        if [ -f /archlive/logo.png ]; then
            echo 'Custom logo found! Applying...'
            cp /archlive/logo.png /archlive/syslinux/splash.png 2>/dev/null || true
            cp /archlive/logo.png /archlive/grub/splash.png 2>/dev/null || true
        fi && \

        # 5. Build the ISO
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
