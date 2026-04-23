# Agilex 5 Output Files & Automation

This directory contains the binary outputs of the Quartus Prime Pro compilation and the scripts used to automate bitstream deployment for the Agilex 5 SoC.

## Automation Tools

### 1. Host Side: `build_and_host.sh`
Located in this directory, this script automates the conversion of the FPGA hardware image (`.sof`) into the Raw Binary File (`.rbf`) format required by U-Boot. It also starts a temporary HTTP server to allow the SoC to download the bitstream over the network.

**Usage:**
1. Grant execution permissions:
   ```bash
   chmod +x build_and_host.sh

    Run the script:
    Bash

    ./build_and_host.sh

2. SoC Side: update_bitstream.sh

This script should be created on your Agilex 5 Linux system (e.g., in /root/). It automates the process of mounting the boot partition, downloading the new bitstream from the server, and syncing the SD card.

Script Content:
Bash

#!/bin/sh
# SETTINGS: Change this IP to your Ubuntu Server's LAN IP!
SERVER_IP="192.168.0.100"
PORT="8080"
FILE_NAME="bitstream.rbf"

BOOT_PARTITION="/dev/mmcblk0p1"
MOUNT_POINT="/boot"

echo "=> [1/4] Mounting boot partition..."
if ! grep -qs "$MOUNT_POINT" /proc/mounts; then
    mkdir -p "$MOUNT_POINT"
    mount "$BOOT_PARTITION" "$MOUNT_POINT" || { echo "Mount failed!"; exit 1; }
fi

echo "=> [2/4] Downloading $FILE_NAME from $SERVER_IP..."
cd "$MOUNT_POINT" || exit 1
rm -f "$FILE_NAME"
wget "http://$SERVER_IP:$PORT/$FILE_NAME"

if [ $? -eq 0 ]; then
    echo "=> [3/4] Syncing SD card..."
    sync
    echo "=> [4/4] Success! Reboot the board to load the new bitstream."
else
    echo "Error: Download failed!"
    exit 1
fi

Note: Remember to run chmod +x update_bitstream.sh on the SoC before the first use.
Important Note on Git

Large binary files (.sof, .rbf) are excluded from this repository via .gitignore to keep the repository size manageable. Only the automation scripts and documentation are tracked.
