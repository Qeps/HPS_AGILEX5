#!/bin/bash

echo "=> [1/3] Locating the compiled U-Boot SPL..."
# This path goes up one folder, into the u-boot source, and into the spl folder
SPL_HEX_PATH="../u-boot-socfpga/spl/u-boot-spl.ihex"

# Safety check to ensure the file actually exists
if [ ! -f "$SPL_HEX_PATH" ]; then
    echo "Error: Could not find u-boot-spl.ihex at $SPL_HEX_PATH."
    echo "Make sure you ran the U-Boot compilation script successfully!"
    exit 1
fi

echo "=> [2/3] Converting golden_top.sof to bitstream.rbf with real SPL..."
# We now use the freshly compiled hex file for the HPS bootloader
quartus_pfg -c golden_top.sof bitstream.rbf -o hps_path="$SPL_HEX_PATH"

if [ $? -ne 0 ]; then
    echo "Error: Quartus programming file generation failed."
    exit 1
fi

echo "=> [3/3] Bitstream converted successfully!"

# Host the file
IP_ADDR=$(hostname -I | awk '{print $1}')
PORT=8000

echo ""
echo "================================================================"
echo "✅ Ready! Starting HTTP server on port $PORT..."
echo ""
echo "Run this command on your Agilex SoC to download it:"
echo "wget http://${IP_ADDR}:${PORT}/bitstream.rbf"
echo "================================================================"
echo "Press Ctrl+C to stop the server when done."
echo ""

python3 -m http.server $PORT
