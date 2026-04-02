#!/bin/bash

echo "🚀 Starting FaceTime HD Camera driver installation for MacBook Air..."

# 1. Install required build tools and libraries
sudo apt update
sudo apt install -y git curl xz-utils devscripts debhelper build-essential checkinstall libssl-dev

# 2. Cleanup existing directories (to allow clean re-runs)
rm -rf facetimehd-firmware bcwc_pcie

# 3. Extract and install firmware
echo "📂 Fetching firmware data..."
git clone https://github.com/patjak/facetimehd-firmware.git
cd facetimehd-firmware
make
sudo make install
cd ..

# 4. Build and install the kernel driver module
echo "⚙️ Building the driver engine (bcwc_pcie)..."
git clone https://github.com/patjak/bcwc_pcie.git
cd bcwc_pcie
make
sudo make install

# 5. Register and load the kernel driver
echo "🛰️ Registering the driver to the system..."
sudo depmod -a
sudo modprobe facetimehd

# Add to /etc/modules for persistence if not already present
if ! grep -q "facetimehd" /etc/modules; then
    echo "facetimehd" | sudo tee -a /etc/modules
fi

echo "✅ Installation complete! Please test with your camera app (Cheese or guvcview)."

sudo apt purge -y cheese
sudo apt autoremove -y
