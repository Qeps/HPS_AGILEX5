#!/bin/bash

# 1. Convert the SOF to RBF using the dummy bootloader bypass
echo "Starting conversion of golden_top.sof to bitstream.rbf..."
quartus_pfg -c golden_top.sof bitstream.rbf -o hps_path=dummy.hex

# 2. Check if the conversion was successful before proceeding
if [ $? -ne 0 ]; then
    echo "Error: Quartus compilation failed. Stopping script."
    exit 1
fi
echo "Conversion successful!"

# 3. Grab the server's local IP address to show you the download command
IP_ADDR=$(hostname -I | awk '{print $1}')
PORT=8000

echo ""
echo "================================================================"
echo "✅ Bitstream is ready! Starting HTTP server on port $PORT..."
echo ""
echo "Run this command on your Agilex SoC to download it:"
echo "wget http://${IP_ADDR}:${PORT}/bitstream.rbf"
echo "================================================================"
echo "Press Ctrl+C to kill the server when you are done downloading."
echo ""

# 4. Start the built-in Python 3 HTTP server
python3 -m http.server $PORT
