# Optical-Transceiver-for-Free-Space-Data-Transmission
🗓️ Timeline: Spring 2026 (Jan 2026 - May 2026) | Course: Junior Design Project

This repository contains the firmware and data processing stack for a custom Free-Space Optical (FSO) communication system. It establishes a hardware-software link utilizing ARM Cortex-M microcontrollers and MATLAB to accurately transmit digital data over a beam of light.

## 🚀 Features
*   **Bare-Metal Embedded Control:** Utilizes bare-metal C programming for direct hardware register configuration, precise timer management, and efficient interrupt handling to modulate the optical signal.
*   **Monochrome Image Transmission:** Features a specialized encoding and decoding pipeline built exclusively for transmitting monochrome black-and-white image data, optimizing bandwidth and minimizing reconstruction errors over the light link.
*   **MATLAB Signal Processing:** Custom scripts that interface with the microcontroller to serialize digital images into a transmittable format and decode the received light pulses back into a visual matrix.

## 🛠️ Hardware & Software Stack
*   **Microcontroller:** STM32F446RE (ARM Cortex-M4)
*   **Languages:** Embedded C, MATLAB
*   **Development Environment:** STM32CubeIDE
*   **Optics Hardware:** Transmitting LED/Laser diode and receiving photodiode circuits.

## 📂 Repository Structure
*   `firmware/`: Contains the bare-metal C source code, header files, and peripheral drivers for the STM32F446RE.
*   `matlab/`: Includes the encoding and decoding scripts for the monochrome black-and-white image transmission.
*   `docs/`: System architecture diagrams, hardware wiring schematics, and performance analysis.

## ⚙️ Quick Start
1. Open the `firmware/` project in STM32CubeIDE, compile, and flash it to the STM32F446RE board.
2. Wire the transmitting and receiving optical circuits to the configured GPIO and ADC pins.
3. Open the `matlab/` directory, update the serial COM port to match your microcontroller, and execute the main script to initiate the black-and-white image transfer.
