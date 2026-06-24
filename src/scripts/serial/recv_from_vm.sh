#!/bin/bash

VM_NAME="Debian_Sarge"

# 1. Dynamically discover the active PTY node for serial port 1 (ttyS1)
echo "[*] Querying libvirt topology for $VM_NAME..."
PTY_NODE=$(virsh dumpxml "$VM_NAME" | grep -B 1 "port='1'" | grep "source path" | cut -d"'" -f2)

if [ -z "$PTY_NODE" ]; then
    echo "Error: Could not find an active serial PTY for $VM_NAME."
    echo "Is the virtual machine powered on?"
    exit 1
fi

echo "[*] Success! Data channel found at $PTY_NODE"
echo "[*] Standing by for inbound file(s) from VM..."
echo "[*] (Files will land in your current host directory: $(pwd))"

# 2. Run rz as root. We point both standard input and output to the PTY
# so rz can hear the VM's packets and reply with ACKs.
rz < "$PTY_NODE" > "$PTY_NODE"

echo "[*] Transfer sequence complete."
