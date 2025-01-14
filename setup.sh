#!/bin/sh
BASE_PATH=$HOME  # Adjust to the directory you cloned Bazinga-Bass in, if different

# Exit immediately if a command fails
set -e

# Set up the project directory
echo "Setting up the Big Mouth Bazinga Bass project..."

sudo apt update
    
# Check for Python3
if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 is not installed. Installing Python3..."
    sudo apt install -y python3
fi

# Check for Pip3
if ! command -v pip3 >/dev/null 2>&1; then
    echo "Pip3 is not installed. Installing pip3..."
    sudo apt install -y python3-pip
fi

# Install system dependencies for Python packages
echo "Installing system dependencies for Python packages..."
sudo apt install -y python3-dev portaudio19-dev 

# Install system dependencies for C++ packages
echo "Installing system dependencies for C++ packages..."
if [ ! -d "$BASE_PATH/pigpio" ]; then
  git clone https://github.com/joan2937/pigpio.git $HOME/pigpio
fi
cd $BASE_PATH/pigpio || exit
make
sudo make install
sudo pigpiod
pigs t
sudo rm -rf
sudo rm -rf "$BASE_PATH/pigpio"

# Update and install general system dependencies (non-language-specific)
echo "Installing system dependencies for audio and text-to-speech..."
sudo apt update
sudo apt install -y espeak-ng alsa-utils

# Install Python packages
cd "$BASE_PATH/Bazinga-Bass"
if [ -f "requirements.txt" ]; then
    echo "Installing Python packages from requirements.txt..."
    pip3 install -r requirements.txt
else
    echo "Error: requirements.txt not found. Skipping dependency installation."
    exit 1
fi

# Complete
echo "------------------------------------------------------------------"
echo "Setup complete! All dependencies have been installed successfully."
