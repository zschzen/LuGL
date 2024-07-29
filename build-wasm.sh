#!/bin/bash

if [ -z "$VCPKG_ROOT" ]; then
	echo "VCPKG_ROOT is not set!"
	exit 1
fi

if [ -z "$EMSDK" ]; then
	echo "EMSDK is not set!"
	exit 1
fi

# Define directories
WEB_DIR="./web/"
BUILD_DIR="./Build/emscripten/"
BIN_DIR="${BUILD_DIR}bin/"

# Check if the build directory exists
if [ ! -d "$BUILD_DIR" ]; then
	echo "Build directory does not exist. Configuring and building the project..."
	cmake --preset emscripten
	cmake --build "$BUILD_DIR" -- -j 12
fi

# Copy files from web directory to bin directory
echo "Copying files from $WEB_DIR to $BIN_DIR..."
rsync -a "$WEB_DIR" "$BIN_DIR"

# Change to the bin directory and start the HTTP server
echo "Starting HTTP server in $BIN_DIR..."
cd "$BIN_DIR"
python3 -m http.server 9000
