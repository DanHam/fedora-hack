#!/usr/bin/env bash
#
# Create filesystems

mkfs.ext4 -L "BOOT" /dev/sda1

mkfs.vfat -F 32 -n "EFI" /dev/sda2

mkfs.ext4 -L "ROOT" /dev/mapper/cryptvg-root
mkfs.ext4 -L "HOME" -m 0 /dev/mapper/cryptvg-home
# On systems with a logical volume assigned for /var
# mkfs.ext4 -L "VAR" -m 2 /dev/mapper/cryptvg-var

mkswap -L "SWAP" /dev/mapper/cryptvg-swap
swapon /dev/mapper/cryptvg-swap
