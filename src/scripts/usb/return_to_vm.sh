#!/bin/bash
VM_NAME="Debian_Sarge"
IMG_PATH="/home/zengxu/Projects/shared_storage.img"
STATE_FILE="/tmp/vflash_last_target"

echo "[*] Flushing host write caches to disk platter..."
sync

echo "[*] Unmounting storage engine from host tree..."
sudo umount /mnt/shared_storage

# --- THE HACK: Toggle target identities to trick the guest udev layer ---
LAST_TARGET=$(cat "$STATE_FILE" 2>/dev/null)
if [ "$LAST_TARGET" = "sda" ]; then
    NEW_TARGET="sdb"
else
    NEW_TARGET="sda"
fi
echo "$NEW_TARGET" > "$STATE_FILE"

echo "[*] Hot-plugging virtual flash drive back into $VM_NAME as target: $NEW_TARGET..."
sudo virsh attach-disk "$VM_NAME" "$IMG_PATH" "$NEW_TARGET" --driver qemu --type disk --subdriver raw --targetbus usb --live

echo "[*] Done! Guest kernel will trigger a clean, un-cached automount sequence."