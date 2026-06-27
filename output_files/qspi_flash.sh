#!/bin/bash

echo "================================================================"
echo "🚀 AGILEX 5 REMOTE QSPI FLASHER (JTAG DIRECT)"
echo "================================================================"

# Define your file names
SOF_FILE="golden_top.sof"
HEX_FILE="terasic_official_spl.hex" 
STITCHED_SOF="golden_top_complete.sof"
JIC_FILE="golden_top_hps.jic"

echo "=> [1/4] Verifying required files..."
if [ ! -f "$SOF_FILE" ]; then
    echo "❌ Error: Could not find $SOF_FILE."
    echo "Make sure your FPGA guy successfully compiled the Quartus project!"
    exit 1
fi

if [ ! -f "$HEX_FILE" ]; then
    echo "❌ Error: Could not find $HEX_FILE."
    echo "Make sure the official Terasic bootloader is in this directory!"
    exit 1
fi

echo "=> [2/4] Stitching the Terasic Bootloader into the SOF..."
# Combine the raw logic with the bootloader
quartus_pfg -c "$SOF_FILE" "$STITCHED_SOF" -o hps_path="$HEX_FILE"

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to stitch the bootloader into the SOF."
    exit 1
fi

echo "=> [3/4] Converting stitched SOF into QSPI JIC image..."
# Wrap the complete SOF into the specific Micron QSPI hardware footprint
quartus_pfg -c "$STITCHED_SOF" "$JIC_FILE" -o device=MT25QU128 -o flash_loader=A5EB013BB23B -o mode=ASX4

if [ $? -ne 0 ]; then
    echo "❌ Error: JIC generation failed."
    exit 1
fi

echo ""
echo "⚠️  WARNING: Flashing QSPI takes 2 to 5 minutes."
echo "⚠️  DO NOT press Ctrl+C or disconnect the server during this step!"
echo ""
echo "=> [4/4] Bypassing Linux USB security and flashing QSPI via JTAG..."

# Kill any stuck JTAG background services before starting
killall -9 jtagd 2>/dev/null

# Execute the flash! (This will prompt you for your benji2004 server password)
sudo $(which quartus_pgm) -c 1 -m jtag -o "pvi;$JIC_FILE"

if [ $? -ne 0 ]; then
    echo "❌ Error: JTAG Programming failed. Check the USB connection!"
    exit 1
fi

echo "=> Cleaning up JTAG daemon to trigger board cold-boot..."
# Killing the daemon here releases the JTAG lock so the SDM can wake the board up
killall -9 jtagd 2>/dev/null

echo ""
echo "================================================================"
echo "✅ SUCCESS! The QSPI has been permanently updated."
echo "The DE25-Nano is rebooting now with the new logic and Linux."
echo "================================================================"
