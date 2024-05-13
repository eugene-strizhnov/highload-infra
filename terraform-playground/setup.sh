#!/bin/bash

# Define the virtual environment directory name
VENV_DIR=".venv"

# Create a virtual environment in the current directory
python -m venv $VENV_DIR

# Activate the virtual environment
source $VENV_DIR/bin/activate

pip install --upgrade pip
pip install ansible "ansible==9.1.0"

echo "Virtual environment created in the current directory and activated. Ansible installed."
