#!/usr/bin/env bash
#
# Mount target volumes and prepare target
set -o errexit

target="/root/target"

[ ! -d "${target}" ] && mkdir -p "${target}"
mount /dev/cryptvg/root "${target}"

[ ! -d "${target}/boot" ] && mkdir "${target}/boot"
mount /dev/sda1 "${target}/boot"

[ ! -d "${target}/boot/efi" ] && mkdir "${target}/boot/efi"
mount /dev/sda2 "${target}/boot/efi"

[ ! -d "${target}/home" ] && mkdir "${target}/home"
mount /dev/cryptvg/home "${target}/home"

# Prepare the target environment
mount --bind /dev "${target}/dev"      # Populate the /dev tree
mount -t proc procfs "${target}/proc"  # Create a proc filesystem
mount -t sysfs sysfs "${target}/sys"   # Create a sysfs filesystem

exit 0
