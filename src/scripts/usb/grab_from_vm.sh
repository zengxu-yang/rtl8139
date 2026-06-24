#!/bin/bash
VM_NAME="Debian_Sarge"
IMG_PATH="/home/zengxu/Projects/shared_storage.img"
MOUNT_POINT="/mnt/shared_storage"

# If run with sudo, use SUDO_UID. If run normally, use the current user's UID.
REAL_UID=${SUDO_UID:-$(id -u)}
REAL_GID=${SUDO_GID:-$(id -g)}
REAL_USER=${SUDO_USER:-$(whoami)}

echo "[*] Hot-unplugging virtual flash drive from $VM_NAME..."
sudo virsh detach-disk "$VM_NAME" sda --live

echo "[*] Mounting storage engine onto host..."
sudo mkdir -p "$MOUNT_POINT"

# Mounts safely using the robustly detected IDs
sudo mount -o loop,rw,uid=$REAL_UID,gid=$REAL_GID,umask=022 "$IMG_PATH" "$MOUNT_POINT"

echo "[*] Success! Files are mounted inside: $MOUNT_POINT"
echo "[*] Ownership mapped to user: $REAL_USER (UID: $REAL_UID)"