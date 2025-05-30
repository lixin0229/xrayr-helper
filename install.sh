#!/bin/bash

INSTALL_PATH="/usr/local/bin/edit_xrayr"
SCRIPT_URL="https://raw.githubusercontent.com/lixin0229/xrayr-helper/main/edit_xrayr.sh"

echo "Downloading edit_xrayr..."
curl -fsSL "$SCRIPT_URL" -o "$INSTALL_PATH"

if [ $? -ne 0 ]; then
  echo "Failed to download script from $SCRIPT_URL"
  exit 1
fi

chmod +x "$INSTALL_PATH"

echo "edit_xrayr has been installed. You can now run it with the command: edit_xrayr"
