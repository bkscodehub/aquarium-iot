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

# Generate env.h from environment variables if not already present
# echo "🔐 Generating env.h..."
# mkdir -p firmware/include
# echo "#pragma once" > firmware/include/env.h
# echo "#define WIFI_SSID \"${WIFI_SSID}\"" >> firmware/include/env.h
# echo "#define WIFI_PASSWORD \"${WIFI_PASSWORD}\"" >> firmware/include/env.h
# echo "#define MQTT_BROKER \"${MQTT_BROKER}\"" >> firmware/include/env.h
# echo "#define MQTT_USERNAME \"${MQTT_USERNAME}\"" >> firmware/include/env.h
# echo "#define MQTT_PASSWORD \"${MQTT_PASSWORD}\"" >> firmware/include/env.h
# echo "#define MQTT_PORT ${MQTT_PORT}" >> firmware/include/env.h
# echo "✅ env.h created in firmware/include"
# echo "✅ env.h contents:"
# cat firmware/include/env.h

echo "🔐 Setting flags for injection during build..."
PIO_FLAGS="-DWIFI_SSID=\\\"${WIFI_SSID}\\\" \
           -DWIFI_PASSWORD=\\\"${WIFI_PASSWORD}\\\" \
           -DMQTT_BROKER=\\\"${MQTT_BROKER}\\\" \
           -DMQTT_USERNAME=\\\"${MQTT_USERNAME}\\\" \
           -DMQTT_PASSWORD=\\\"${MQTT_PASSWORD}\\\" \
           -DMQTT_PORT=${MQTT_PORT}"

echo "⚙️ Building with PlatformIO using injected flags..."
pio run -v --environment esp12f --build-property="build_flags=${PIO_FLAGS}"

# echo "⚙️ Building with PlatformIO..."
# pio run -v

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
