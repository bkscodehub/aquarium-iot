# Aquarium IoT System 🌊🐟

A modular, open-source IoT platform for automating and monitoring aquariums using ESP microcontrollers, MQTT, and custom dashboards.

> 🐜 **WORK IN PROGRESS**  
> This project and the associated subprojects are actively being developed. Features, structure, and code may change frequently. Feedback and contributions are welcome!

---
## 🚀 Flashing the Firmware to ESP8266
To flash the compiled firmware to your ESP8266 (ESP-12F) using esptool, follow the steps below:

### 🔧 Prerequisites
- Python 3 installed
- esptool installed via pip:

```
pip install esptool
```
### 📦 Flashing the Firmware
Connect your ESP8266 to your computer via USB (through an FTDI adapter or USB-to-Serial).

Ensure the board is in flash mode.

Use the following command to flash the firmware:

```
esptool.py --port COM6 --baud 115200 write_flash 0x00000 firmware.bin
```
💡 Replace COM6 with your actual serial port. On Linux/macOS, it might look like /dev/ttyUSB0.

### ℹ️ Optional: Erase Flash Completely

If you're encountering persistent issues or want to reset the ESP8266 to a clean state, you can erase the entire flash memory, including the EEPROM emulation area:

⚠️ Use with caution — this will remove all data stored in flash memory.
```
esptool.py --port COM6 erase_flash
```
This is useful before installing a new version of the firmware from scratch.

### 🔌 Wiring ESP-12F Adapter to FTDI Module
Here's how to connect the ESP-12F to an FTDI module:

- ESP-12F Adapter Pin	FTDI Pin
- VCC	3.3V ⚠️ Do not use 5V
- GND	GND
- TX	RX of FTDI
- RX	TX of FTDI
- GPIO0	GND (only while uploading sketch)
- EN / CH_PD	3.3V (must be pulled HIGH)

**NOTE**: You can add a 10kΩ pull-up resistor to EN/CH_PD and optionally to RST and GPIO2 for stable operation.

### 🔋Power Supply Warning
**Important**: The ESP-12F draws peak currents >200mA, especially during Wi-Fi activity. Make sure your FTDI module’s 3.3V regulator can handle it.

If the ESP keeps resetting or doesn’t respond, power it from a separate 3.3V LDO like AMS1117 instead, and just connect FTDI’s GND, TX, RX.

---

## 🔧 Subprojects

### 1. [Aquarium Lighting Controller](https://github.com/bkscodehub/aquarium-lighting-controller)
This ESP8266-based controller automates aquarium lighting using time-based schedules and MQTT messages.

- Written in C++/Arduino
- Supports manual and automatic lighting modes
- MQTT Topics:
  - `/cmd`: control commands
  - `/status`: lighting status updates
  - `/ack`: acknowledgments

> ⚙️ Uses code from [`aquarium-iot-shared-lib`](https://github.com/bkscodehub/aquarium-iot-shared-lib)

---

### 2. [Aquarium Dashboard](https://github.com/bkscodehub/aquarium-dashboard)
A web or Android front-end to view status and control the lighting and other future modules via MQTT.

- Built with Python, React, or Flutter (choose based on stack)
- Real-time control over MQTT
- Status visualization

---

### 3. [Aquarium IoT Shared Lib](https://github.com/bkscodehub/aquarium-iot-shared-lib)
Common libraries and utilities used across aquarium controllers and dashboards.

- MQTT helper functions
- JSON encoding/decoding utilities
- Time and schedule management tools

---

## 📌 Goals

- ✅ Modular design for lighting, filter, CO₂, and more
- ✅ MQTT-based communication
- ✅ Open and extendable hardware + software
- 🛠️ Under active development

---

## 📂 Directory Structure (For Reference Only)

This repo contains no direct code — just links and documentation.
Each subproject has its own GitHub repository and README.

---

## 💡 Future Modules (Planned)

- Filter Controller
- CO₂ Controller
- Temperature & pH Monitoring
- Mobile App Integration

---

## 🤝 Contributing

Want to help with hardware, firmware, UI, or testing?
[Create an issue](https://github.com/bkscodehub/aquarium-iot/issues) or submit a pull request to one of the submodules.

---

## 📜 License

This project is open-source under the GNU GENERAL PUBLIC LICENSE (Version 3, 29 June 2007).
