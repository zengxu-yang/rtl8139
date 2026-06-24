#!/bin/bash

# 1. Ensure the user provided a file to send
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

TARGET_FILE="$1"
SERIAL_DEV="/dev/ttyS1"

# 2. Verify the file actually exists inside the VM filesystem
if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: File '$TARGET_FILE' not found."
    exit 1
fi

echo "[*] Sending '$TARGET_FILE' to host via $SERIAL_DEV..."

# 3. Execute Zmodem binary transfer with full duplex redirection.
# The -b flag ensures absolute bit-for-bit integrity for binary objects.
sz -b "$TARGET_FILE" > "$SERIAL_DEV" < "$SERIAL_DEV"

echo "[*] Done."
