#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="zenith-os"
iso_label="ZENITH_$(date +%Y%m)"
iso_publisher="Zenith OS <https://zenith-os.org>"
iso_application="Zenith OS Live/Installation CD"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-ia32.grub.esp' 'uefi-x64.grub.esp' 'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/usr/local/bin/whatsapp-web"]="0:0:755"
  ["/usr/local/bin/pw-live"]="0:0:755"
  ["/usr/local/bin/onenote-web"]="0:0:755"
  ["/usr/local/bin/mount-gdrive"]="0:0:755"
  ["/usr/local/bin/pomodoro-status"]="0:0:755"
  ["/usr/local/bin/pomodoro-toggle"]="0:0:755"
)
