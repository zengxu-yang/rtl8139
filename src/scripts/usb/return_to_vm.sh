#!/bin/bash
VM_NAME="Debian_Sarge"
IMG_PATH="/home/zengxu/Projects/shared_storage.img"

echo "[*] Flushing host write caches to disk platter..."
sync

echo "[*] Unmounting storage engine from host tree..."
sudo umount /mnt/shared_storage

echo "[*] Hot-plugging virtual flash drive back into $VM_NAME..."
sudo virsh attach-disk "$VM_NAME" "$IMG_PATH" sda --driver qemu --type disk --subdriver raw --targetbus usb --live

echo "[*] Done! Remount the drive inside your VM using: mount /dev/sda /mnt/storage"