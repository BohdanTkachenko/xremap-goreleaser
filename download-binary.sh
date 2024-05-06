#!/usr/bin/env bash

VERSION="$1"
ARCH="$2"
VARIANT="$3"
BIN_PATH="$4"

URL="https://github.com/xremap/xremap/releases/download/v${VERSION}/xremap-linux-${ARCH}-${VARIANT}.zip"
ARCHIVE_PATH="$BIN_PATH.zip"
BIN_DIR=$(dirname "$BIN_PATH")

# Remove the placeholder binary
# If it will be still missing by the end of this script, GoReleaser will fail
# This will help to ensure that the right binary is in place
rm -f "${BIN_PATH}"

# Remove previously downloaded archives (if any).
rm -f "$ARCHIVE_PATH"

# Download corresponding archive
echo "INFO: Downloading \"$URL\" to \"$ARCHIVE_PATH\"..."
curl -L "$URL" --output "$ARCHIVE_PATH"

# Extract the archive and install binary
echo "INFO: Extracting binary from the downloaded archive to \"$BIN_PATH\"..."
if ! command -v unzip &> /dev/null; then
  echo "ERROR: Command \"unzip\" not found."
  exit 0
fi
unzip -o -d "$BIN_DIR" "$ARCHIVE_PATH"
chmod +x "$BIN_PATH"