#!/bin/bash

echo "================================================================"
echo "🚀 AGILEX 5 LIVE LINUX INJECTION SCRIPT (FPGA MANAGER)"
echo "================================================================"

HEX_FILE="terasic_official_spl.hex"

if [ ! -f "$HEX_FILE" ]; then
    echo "❌ Error: Could not find $HEX_FILE!"
    echo "Make sure the Terasic bootloader is in this output folder."
    exit 1
fi

echo "=> [1/2] Satisfying Quartus compiler to generate live bitstream..."
# We feed it the Terasic bootloader just to bypass the strict HPS error!
quartus_pfg -c golden_top.sof bitstream_live.rbf -o hps_path="$HEX_FILE"

if [ $? -ne 0 ]; then
    echo "❌ Error: Quartus programming file generation failed."
    exit 1
fi

echo "=> [2/2] Bitstream generated successfully!"

# Host the file
IP_ADDR=$(hostname -I | awk '{print $1}')
PORT=8000

echo ""
echo "================================================================"
echo "✅ Ready! Starting HTTP server on port $PORT..."
echo ""
echo "Run these exact commands on your Agilex SoC in Poland:"
echo "1. cd /lib/firmware"
echo "2. wget http://${IP_ADDR}:${PORT}/bitstream_live.rbf"
echo "3. echo bitstream_live.rbf > /sys/class/fpga_manager/fpga0/firmware"
echo "================================================================"
echo "Press Ctrl+C to stop the server when done."
echo ""

python3 -m http.server $PORT
