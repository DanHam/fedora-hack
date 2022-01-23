#!/usr/bin/env bash
#
# Crypto + LVM scratch
modprobe dm_crypt

# Set up the crypto container
cryptsetup luksFormat --type luks2 /dev/sda3

# Set a meaningful label on the partition/container
cryptsetup config --label='CRYPTLVM' /dev/sda3

# Open the disk and set the name for the encypted device under /dev/mapper/
cryptsetup open /dev/sda3 sda3_cryptlvm

# Permanently enable trim/discard support for SSD's
cryptsetup --allow-discards --persistent refresh sda3_cryptlvm

# Confirm
dmsetup table | grep allow_discards

# Set encrypted device as LVM physical volume
pvcreate /dev/mapper/sda3_cryptlvm

# Create Volume Group
vgcreate cryptvg /dev/mapper/sda3_cryptlvm

# Create the Logical Volumes - Specific to MacMini & Samsung SSD 870
# lvcreate -L 16G cryptvg -n root
# lvcreate -L 882.74G cryptvg -n home
# lvcreate -l +100%FREE cryptvg -n swap
