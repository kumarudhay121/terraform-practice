#!/bin/bash

# Exit on any error
set -e

# Define variables
AWS_CLI_VERSION="latest"
INSTALL_DIR="/usr/local/bin"
TEMP_DIR=$(mktemp -d)

# Clean up temporary files on exit
trap "rm -rf $TEMP_DIR" EXIT

# Download the AWS CLI installation package
echo "Downloading AWS CLI v$AWS_CLI_VERSION..."
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$TEMP_DIR/awscliv2.zip"

# Unzip the package
echo "Unzipping AWS CLI package..."
unzip -q "$TEMP_DIR/awscliv2.zip" -d "$TEMP_DIR"

# Run the installer
echo "Installing AWS CLI..."
sudo "$TEMP_DIR/aws/install" --bin-dir "$INSTALL_DIR" --install-dir /usr/local/aws-cli --update

# Verify the installation
echo "Verifying AWS CLI installation..."
aws --version

echo "AWS CLI installed successfully!"
