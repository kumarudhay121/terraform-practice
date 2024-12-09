#!/bin/bash

# Exit on any error
set -e

# Specify the version of Terraform to install
TERRAFORM_VERSION="1.10.1"

# Define the installation directory
INSTALL_DIR="/usr/local/bin"

# Temporary directory for downloading files
TEMP_DIR=$(mktemp -d)

# Clean up temporary files on exit
trap "rm -rf $TEMP_DIR" EXIT

# Download Terraform binary
echo "Downloading Terraform v$TERRAFORM_VERSION..."
curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o "$TEMP_DIR/terraform.zip"

# Rename the file to match the checksum file entry
mv "$TEMP_DIR/terraform.zip" "$TEMP_DIR/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

# Download SHA256 checksum
echo "Downloading checksum..."
curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS" -o "$TEMP_DIR/terraform_SHA256SUMS"

# Extract the specific checksum for the binary
echo "Extracting checksum for verification..."
grep "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" "$TEMP_DIR/terraform_SHA256SUMS" > "$TEMP_DIR/terraform_SHA256SUM"

# Verify checksum
echo "Verifying checksum..."
(cd "$TEMP_DIR" && sha256sum --check terraform_SHA256SUM)

# Unzip the binary
echo "Installing Terraform..."
unzip -q "$TEMP_DIR/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -d "$TEMP_DIR"
sudo mv "$TEMP_DIR/terraform" "$INSTALL_DIR"

# Verify installation
echo "Verifying installation..."
terraform version

echo "Terraform v$TERRAFORM_VERSION installed successfully!"
