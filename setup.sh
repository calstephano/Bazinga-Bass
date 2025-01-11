#!/bin/bash

# Set up the project directory
echo "Setting up the project..."

# Step 1: Upgrade pip to the latest version
echo "Upgrading pip..."
pip install --upgrade pip

# Step 2: Install Python dependencies from requirements.txt
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt

# Step 3: Check if TensorFlow or PyTorch is installed correctly
echo "Verifying TensorFlow and PyTorch installations..."
python -c "import torch; print('PyTorch version:', torch.__version__)"
python -c "import tensorflow as tf; print('TensorFlow version:', tf.__version__)"

# Step 4: Finished
echo "Setup complete."

# End
