#!/bin/bash
VM_NAME="Debian_Sarge"
IMG_PATH="/home/zengxu/Projects/shared_storage.img"
MOUNT_POINT="/mnt/shared_storage"

REAL_UID=${SUDO_UID:-$(id -u)}
REAL_GID=${SUDO_GID:-$(id -g)}
REAL_USER=${SUDO_USER:-$(whoami)}

# 1. Dynamically query libvirt to see which target node (sda or sdb) the image currently occupies
TARGET_DEV=$(sudo virsh domblklist "$VM_NAME" | grep "shared_storage.img" | awk '{print $1}')

if [ -n "$TARGET_DEV" ]; then
    echo "[*] Hot-unplugging virtual flash drive ($TARGET_DEV) from $VM_NAME..."
    sudo virsh detach-disk "$VM_NAME" "$TARGET_DEV" --live
else
    echo "[*] Warning: Drive partition file does not appear to be attached to $VM_NAME."
fi

echo "[*] Mounting storage engine onto host..."
sudo mkdir -p "$MOUNT_POINT"
sudo mount -o loop,rw,uid=$REAL_UID,gid=$REAL_GID,umask=022 "$IMG_PATH" "$MOUNT_POINT"

echo "[*] Success! Files are mounted inside: $MOUNT_POINT"
echo "[*] Ownership mapped to user: $REAL_USER (UID: $REAL_UID)"