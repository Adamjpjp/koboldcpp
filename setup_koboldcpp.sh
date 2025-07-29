#!/bin/bash

set -e

echo "[*] Installing system dependencies..."
sudo apt update && sudo apt install -y build-essential cmake git wget unzip

echo "[*] Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

echo "[*] Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt || echo "[*] No requirements.txt found, skipping."

echo "[*] Compiling KoboldCPP..."
mkdir -p build
cd build
cmake ..
make -j$(nproc)

cd ..
echo "[*] Setup complete. To start KoboldCPP, run:"
echo "    ./koboldcpp --model <path-to-model.gguf> --port 5000"
