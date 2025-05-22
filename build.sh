#!/bin/bash

if [ -f .env ]; then
  echo "🔐 Loading environment secrets from .env"
  export $(grep -v '^#' .env | xargs)
fi

set -e

echo "🔄 Initializing submodules..."
git submodule update --init --recursive

echo "📁 Navigating to subproject: aquarium-lighting-controller..."
cd subprojects/aquarium-lighting-controller

echo "🔄 Updating nested submodules (shared-lib)..."
git submodule update --init --recursive

echo "📂 Contents of firmware/src:"
ls -l firmware/src

echo "🧪 PlatformIO INI contents:"
cat platformio.ini

# Set the PlatformIO build flags with secrets
echo "🔐 Setting flags for injection during build..."
export PLATFORMIO_BUILD_FLAGS="-DWIFI_SSID=\\\"${WIFI_SSID}\\\" \
-DWIFI_PASSWORD=\\\"${WIFI_PASSWORD}\\\" \
-DMQTT_BROKER=\\\"${MQTT_BROKER}\\\" \
-DMQTT_USERNAME=\\\"${MQTT_USERNAME}\\\" \
-DMQTT_PASSWORD=\\\"${MQTT_PASSWORD}\\\" \
-DMQTT_PORT=${MQTT_PORT}"

echo "🔐 Injected build flags:"
echo "$PLATFORMIO_BUILD_FLAGS" #| sed -e 's/WIFI_PASSWORD=.* /WIFI_PASSWORD=\"***\" /' -e 's/MQTT_PASSWORD=.* /MQTT_PASSWORD=\"***\" /'

echo "⚙️ Building with PlatformIO using injected flags..."
pio run -v

# Copy the final binary to a known location for GitHub Actions to pick up
if [ -f .pio/build/esp12f/firmware.bin ]; then
  ls -l .pio/build/esp12f/
  mkdir -p ../../artifacts
  cp .pio/build/esp12f/firmware.bin ../../artifacts/
  echo "✅ firmware.bin copied successfully."
else
  echo "❌ firmware.bin not found!"
  exit 1
fi

echo "✅ Build and copy completed."
