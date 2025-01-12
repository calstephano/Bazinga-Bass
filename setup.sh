#!/bin/sh

# Exit immediately if a command fails
set -e

# Set up the project directory
echo "Setting up the Big Mouth Bazinga Bass project..."

# Step 1: Check for Python3
echo "Checking for Python3, pip3, and python3-dev..."
if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 is not installed. Installing Python3..."
    sudo apt update
    sudo apt install -y python3
fi

# Step 2: Check for Pip3
if ! command -v pip3 >/dev/null 2>&1; then
    echo "pip3 is not installed. Installing pip3..."
    sudo apt install -y python3-pip
fi
echo "Upgrading pip..."
pip3 install --upgrade pip

# Step 3: Install system dependencies
sudo apt install -y python3-pip python3-dev portaudio19-dev 

# Step 4: Install Python dependencies
if [ -f "requirements.txt" ]; then
    echo "Installing dependencies from requirements.txt..."
    pip3 install -r requirements.txt
else
    echo "Error: requirements.txt not found. Skipping dependency installation."
    exit 1
fi

# Final Step: Success message
echo "------------------------------------------------------------------"
echo "Setup complete! All dependencies have been installed successfully."

# End of script
