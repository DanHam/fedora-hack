#!/usr/bin/env bash
#
# Mount target volumes
[ ! -d /root/target ] && mkdir -p /root/target
mount /dev/cryptvg/root /root/target

[ ! -d /root/target/boot ] && mkdir /root/target/boot
mount /dev/sda1 /root/target/boot

[ ! -d /root/target/boot/efi ] && mkdir /root/target/boot/efi
mount /dev/sda2 /root/target/boot/efi

[ ! -d /root/target/home ] && mkdir /root/target/home
mount /dev/cryptvg/home /root/target/home
