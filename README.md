# ⏱️ Digital Chronometer VHDL

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

## Core Modules Explained

### **Chronometre.vhd** — Top-Level Entity

Orchestrates all subsystems in a single module.

**Port Definitions :**

```vhdl
Inputs:
  CLK           : std_logic              -- Board clock (100 MHz)
  SEL_SPEED_CLK : std_logic              -- Acceleration switch
  START_STOP    : std_logic              -- Start/stop control
  RESET         : std_logic              -- Reset (active high)

Outputs:
  AFF[6:0]      : std_logic_vector(6 downto 0)  -- 7-segment signals
  ANODES[3:0]   : std_logic_vector(3 downto 0)  -- Anode selection
  LED_OUT[9:0]  : std_logic_vector(9 downto 0)  -- LED indicators
  TC            : std_logic              -- Terminal count signal
```

### **Clock Generation** — Two Independent Domains

1. **CLK_OUT_COUNT** 
   - Frequency : 1 Hz (normal) or accelerated for testing
   - Purpose : Drives the counting logic
   - Source : Divides 100 MHz down to required frequency

2. **CLK_OUT_AFF**
   - Frequency : ~1 kHz (1000 Hz)
   - Purpose : Multiplexes the 4 displays rapidly
   - Ensures : Flicker-free display at human perception

### **Counter Stack** — Cascaded 4-Digit Counter

```
┌─────────────────┐
│    Minutes      │  [0-5][0-9]  (59 max)
└────────┬────────┘
         │ (carry)
         ▼
┌─────────────────┐
│ Tens of Seconds │  [0-5]       (0-59 seconds total)
└────────┬────────┘
         │ (carry)
         ▼
┌─────────────────┐
│Units of Seconds │  [0-9]
└────────┬────────┘
         │ (carry)
         ▼
┌─────────────────┐
│    Tenths       │  [0-9]
└─────────────────┘
```

**Counting Flow :**
1. **Tenths** (0-9) → Carries to Units
2. **Units** (0-9) → Carries to Tens  
3. **Tens** (0-5) → Carries to Minutes
4. **Minutes** (0-59) → Terminal Count signal

### **Display System** — Real-Time Multiplexing

```
  MM:SS.D Format
  ↓    ↓
┌──┬──┬──┬──┐
│M1│M2│S1│S2│.T  ← Digital time representation
└──┴──┴──┴──┘
 AN3 AN2 AN1 AN0   ← Anodes (active low)
  ↓   ↓   ↓   ↓
 Mux → 7-Segment Decoder → Display outputs (AFF[6:0])
```

**Multiplexing Rate :** ~250 Hz per digit (1 kHz ÷ 4)

---

## Testing & Verification

Each major component has dedicated testbenches :

| Testbench | Module Tested | Purpose |
|-----------|---------------|---------|
| `Chronometre_tb.vhd` | Complete system | Integration test |
| `Affichage_tb.vhd` | Display module | Output verification |
| `COUNTER_DIXIEME_MIN_SEC_tb.vhd` | Counter stack | Cascading logic |
| `tb_counteurdixieme.vhd` | Tenths counter | BCD counting (0-9) |
| `tb_unit_second.vhd` | Units counter | BCD counting (0-9) |
| `tb_dizaine_sec.vhd` | Tens counter | Modulo-6 counting (0-5) |


---

## Design Highlights

| Aspect | Implementation |
|--------|-----------------|
| **Architecture** | Hierarchical, modular design |
| **Synchronization** | Clock-domain crossing with proper controls |
| **Multiplexing** | Temporal display multiplexing at 1 kHz |
| **Reset** | Synchronous reset with async capability |
| **Terminal Count** | Cascaded TC signals with end-of-count detection |
| **Testability** | Full testbenches with stimulus vectors |

---



## Authors

- **Paul Ledrapier**
- **Liam Morineau**
- **Titouan Bocquet**
- **Bosco de Rauglaudre**
