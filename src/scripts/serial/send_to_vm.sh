#!/bin/bash

VM_NAME="Debian_Sarge"

if [ -z "$1" ]; then
    echo "Usage: sudo $0 <filename>"
    exit 1
fi

TARGET_FILE="$1"

if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: File '$TARGET_FILE' not found."
    exit 1
fi

# Automatically query libvirt for the active PTY path mapped to serial port 1 (ttyS1)
echo "[*] Querying libvirt topology for $VM_NAME..."
PTY_NODE=$(virsh dumpxml "$VM_NAME" | grep -B 1 "port='1'" | grep "source path" | cut -d"'" -f2)

# Safety check to make sure the VM is actually running and returning a PTY
if [ -z "$PTY_NODE" ]; then
    echo "Error: Could not find an active serial PTY for $VM_NAME."
    echo "Is the virtual machine powered on?"
    exit 1
fi

echo "[*] Success! Found data channel at $PTY_NODE"
echo "[*] Streaming '$TARGET_FILE' to guest workspace..."

sz -b "$TARGET_FILE" < "$PTY_NODE" > "$PTY_NODE"
