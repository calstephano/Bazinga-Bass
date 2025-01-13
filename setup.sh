#!/bin/sh

# Exit immediately if a command fails
set -e

# Set up the project directory
echo "Setting up the Big Mouth Bazinga Bass project..."

# Check for Python3
if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 is not installed. Installing Python3..."
    sudo apt update
    sudo apt install -y python3
fi

# Check for Pip3
if ! command -v pip3 >/dev/null 2>&1; then
    echo "Pip3 is not installed. Installing pip3..."
    sudo apt install -y python3-pip
fi

# Upgrade pip to the latest version
echo "Upgrading pip..."
pip3 install --upgrade pip

# Install system dependencies for Python packages
echo "Installing system dependencies for Python packages..."
sudo apt install -y python3-pip python3-dev portaudio19-dev 

# Install system dependencies for C++ packages
echo "Installing system dependencies for C++ packages..."
sudo apt install -y pigpio

# Install Python packages
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
