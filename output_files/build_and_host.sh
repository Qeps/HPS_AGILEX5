#!/bin/bash



SOF_FILE="golden_top.sof"
BIN_FILE="hps_bootloader_handoff.bin"
DUMMY_HEX="dummy.hex"
OUTPUT_RBF="golden_top.rbf"
FINAL_RBF="bitstream.rbf"
PORT=8080

echo "=> [1/4] Przygotowywanie fałszywego bootloadera (dummy.hex)..."
if [ ! -f "$BIN_FILE" ]; then
    echo "Błąd: Nie znaleziono pliku $BIN_FILE!"
    exit 1
fi
objcopy -I binary -O ihex "$BIN_FILE" "$DUMMY_HEX"

echo "=> [2/4] Generowanie pliku RBF za pomocą quartus_pfg..."
if [ ! -f "$SOF_FILE" ]; then
    echo "Błąd: Nie znaleziono pliku $SOF_FILE!"
    exit 1
fi
quartus_pfg -c "$SOF_FILE" "$OUTPUT_RBF" -o hps_path="$DUMMY_HEX"

echo "=> [3/4] Zmiana nazwy na $FINAL_RBF..."
if [ -f "$OUTPUT_RBF" ]; then
    mv "$OUTPUT_RBF" "$FINAL_RBF"
    echo "Sukces! Wygenerowano $FINAL_RBF."
else
    echo "Błąd: Generator Quartusa zawiódł."
    exit 1
fi

echo "=> [4/4] Uruchamianie serwera HTTP na porcie $PORT..."
echo "Serwer działa. Pobierz plik na SoC, a następnie wciśnij Ctrl+C, aby go wyłączyć."
python3 -m http.server $PORT
