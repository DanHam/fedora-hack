#!/usr/bin/env bash
#
# Initial setup

target="/root/target"

systemd-firstboot \
    --root="${target}" \
    --locale=C.UTF-8 \
    --keymap=us \
    --hostname=fred \
    --timezone="Europe/London"
    --setup-machine-id

exit 0
