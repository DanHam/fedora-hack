#/usr/bin/env bash
#
# Bootstrap
set -o errexit

dnf install \
    --installroot=/root/target \
    --releasever=35 \
    --setopt=install_weak_deps=False \
    --setopt=keepcache=True \
    --assumeyes \
    --nodocs \
    NetworkManager \
    audit \
    deltarpm \
    dnf \
    e2fsprogs \
    firewalld \
    glibc-langpack-en \
    iputils \
    kdb \
    less \
    lz4 \
    passwd \
    policycoreutils \
    rootfiles \
    rtkit \
    selinux-policy-targeted \
    sqlite \
    sudo \
    systemd \
    systemd-udev \
    vim-minimal \
    zchunk
