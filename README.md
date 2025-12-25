# Digital Chronometer VHDL

> A complete digital chronometer project developed in VHDL, designed and implemented on the **Nexys A7** FPGA board

---

## Quick Overview

This project implements a complete digital chronometer capable of measuring time up to **59:59.9** (59 minutes, 59 seconds and 9 tenths of a second). Entirely developed in VHDL, it demonstrates the fundamental principles of digital design and FPGA programming.

### Key Features

- **Dynamic Display** : 7-segment display in real-time via the 4 anodes of the Nexys A7
- **User Control** : Start/Stop switch, Reset button, Acceleration mode for testing
- **Visual Indicators** : LED rotating pattern for visualizing tenths
- **Modular Architecture** : Reusable components with cascaded counters
- **Complete Testing** : Comprehensive testbenches for all modules

---

## Hardware Target

<div align="center">

![Nexys A7 FPGA Board](docs/nexysA7.png)

**Nexys A7 Board** — *Artix-7 FPGA • 100 MHz • 4 × 7-Segment Displays*

</div>

The **Nexys A7** provides :
- **FPGA** : Artix-7 XC7A100TCSG324
- **Clock** : 100 MHz oscillator
- **Display** : 4 common-cathode 7-segment displays (multiplexed)
- **I/O** : 16 switches, 16 buttons, 16 LEDs
- **Interface** : USB programming and communication

---

## How to Use

| Control | Function |
|---------|----------|
| `START_STOP` | **Starts** or **stops** the counting |
| `RESET` | **Resets** the chronometer to 00:00.0 |
| `SEL_SPEED_CLK` | Activates **acceleration mode** (for testing) |
| **7-segment Display** | Shows time as **MM:SS.D** (minutes:seconds.tenths) |
| **LED Pattern** | Rotating lights indicate tenths of seconds |

---

## Project Structure

```
VHDL-chronometer/
├── Chronometre.vhd          # Top-level entity (main orchestrator)
├── Chronometre_tb.vhd       # System-level testbench
│
├── Affichage/               # Display Module
│   ├── Affichage.vhd        # Display controller
│   ├── Affichage_tb.vhd
│   ├── Transcodeur_7seg/    # BCD to 7-segment converter
│   ├── Transcodeur_anodes/  # Anode selector
│   ├── Mux_4x1x4b/          # 4-to-1 multiplexer
│   └── Counter_2b/          # 2-bit counter for anode rotation
│
├── Compteur/                # Counting Module
│   ├── COUNTER_DIXIEME_MIN_SEC/  # Main counter (all digits)
│   ├── Counter_dixieme_RE/       # Tenths counter
│   ├── Counter_Unit_4b_RE/       # Units seconds counter
│   └── Counter_Diz_4b_RE/        # Tens seconds counter
│
├── Gestion Horloge/         # Clock Management Module
│   ├── CLK_OUT_COUNT/       # Clock for counters (1 Hz)
│   └── CLK_OUT_AFF/         # Clock for display (~1 kHz)
│
└── VIVADO-Project/          # Xilinx Vivado environment
    └── Chronometre/
```

---



## Authors

- **Paul Ledrapier**
- **Liam Morineau**
- **Titouan Bocquet**
- **Bosco de Rauglaudre**
