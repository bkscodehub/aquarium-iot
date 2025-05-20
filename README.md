# Aquarium IoT System 🌊🐟

A modular, open-source IoT platform for automating and monitoring aquariums using ESP microcontrollers, MQTT, and custom dashboards.

> 🐜 **WORK IN PROGRESS**  
> This project and the associated subprojects are actively being developed. Features, structure, and code may change frequently. Feedback and contributions are welcome!

---

## 🔧 Subprojects

### 1. [Aquarium Lighting Controller](https://github.com/bkscodehub/aquarium-lighting-controller)
This ESP-based controller automates aquarium lighting using time-based schedules and MQTT messages.

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
