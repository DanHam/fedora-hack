#!/usr/bin/env bash
#
# Crypto + LVM scratch
modprobe dm_crypt

# Set up the crypto container
cryptsetup luksFormat --type luks2 /dev/sda3

# Set a meaningful label on the partition/container
cryptsetup config --label='LUKS' /dev/sda3

# Open the disk and set the name for the encypted device under /dev/mapper/
cryptsetup open /dev/sda3 cryptpv

# Permanently enable trim/discard support for SSD's
cryptsetup --allow-discards --persistent refresh cryptpv

# Confirm
dmsetup table | grep allow_discards

# Set encrypted device as LVM physical volume
pvcreate /dev/mapper/cryptpv

# Create Volume Group
vgcreate cryptvg /dev/mapper/cryptpv

# Create the Logical Volumes - Specific to hack test
lvcreate -L 16GiB cryptvg -n root
lvcreate -L 28.98GiB cryptvg -n home
lvcreate -l +100%FREE cryptvg -n swap
