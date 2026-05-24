

```markdown
# Agilex 5 Output Files & Automation

This directory contains the binary outputs of the Quartus Prime Pro compilation and the scripts used to automate bitstream deployment for the Agilex 5 (DE25-Nano) SoC.

---

## Automation Tools

### 1. Remote QSPI JTAG Flasher (Recommended)
**Script:** `remote_qspi_flash.sh` (Host Side)

This script automates the complete remote deployment of a new FPGA design over the JTAG cable. It takes the raw hardware design (`golden_top.sof`), stitches it with the official Terasic bootloader (`terasic_official_spl.hex`), converts it into a Micron QSPI-compatible `.jic` file, and permanently flashes the board's QSPI memory—even if the board is completely unresponsive or 5,000 miles away.

**Usage:**
1. Ensure your FPGA engineer has compiled the project and pushed `golden_top.sof` to this directory.
2. Ensure the board is powered on and connected via the USB Type-C JTAG cable.
3. Grant execution permissions (first time only):
```bash
   chmod +x remote_qspi_flash.sh

```

4. Run the script:

```bash
   ./remote_qspi_flash.sh

```

*Note: The script temporarily kills the `jtagd` background service to bypass Linux USB hardware lockouts and triggers a board cold-boot upon completion.*

---

### 2. HTTP SD Card Transfer (Alternative / SD Boot)

If you are booting from the MicroSD card instead of the QSPI chip (using the MSEL hardware switches), you can use these legacy HTTP transfer scripts.

#### Host Side Script: `build_and_host.sh`

This script converts the `.sof` into an `.rbf` and starts a temporary Python HTTP server to allow the SoC to download the bitstream over the network.

```bash
chmod +x build_and_host.sh
./build_and_host.sh

```

#### SoC Side Script: `update_bitstream.sh`

This script should be created on your Agilex 5 Linux system (e.g., in `/root/`). It automates the process of mounting the boot partition, downloading the new bitstream from your host server, and syncing the SD card.

```bash
#!/bin/sh
# SETTINGS: Change this IP to your Ubuntu Server's LAN IP!
SERVER_IP="100.84.250.31"
PORT="8000"
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

```

*Note: Remember to run `chmod +x update_bitstream.sh` on the SoC before the first use.*

---

## Important Note on Git Tracking

By default, large Quartus temporary binary files and compiled junk are excluded via `.gitignore` to keep the repository size manageable.

However, specific exceptions have been added to track the necessary files for remote deployment:

* `terasic_official_spl.hex` is strictly tracked so the bootloader doesn't break across environments.
* `golden_top.sof` is explicitly tracked so FPGA updates can be pushed and pulled effortlessly.
```

```
