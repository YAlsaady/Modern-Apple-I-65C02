# Modern Apple I – Reimagined with Modern Components

A modern reimplementation of the original Apple I computer (1976), built entirely with contemporary components.

## Project Idea

Steve Wozniak's Apple I was a masterpiece of simplicity.

This project is a modern reimplementation, following the same principles of minimalism, openness, and cost-conscious design while replacing obsolete components with modern equivalents such as WDC 65C02, EEPROM, SRAM, and PLDs.

The system is designed to eventually support classic Apple I software, including the Wozniak Monitor, Apple Cassette Interface (ACI), and BASIC.

## Hardware Description

| Component | Type / Model | Description |
|------------|---------------|-------------|
| **CPU** | WDC 65C02 (1 MHz) | Main processor (CMOS version of 6502) |
| **Program Memory** | AT28C256 (32K × 8 EEPROM) | Wozniak Monitor, ACI, and HAL routines |
| **Data Memory** | AS6C62256 (32K × 8 SRAM) | Main RAM |
| **Address Decoder / Glue Logic** | ATF16V8B PLD | Generates chip-selects for all memory and peripherals; allows flexible memory mapping |
| **UART** | 65C51 + TTL-Serial Adapter | Serial communication interface |
| **Display** | LC-Display | display output |
| **PIA 65C21** | Port A: PS/2 Keyboard via 74HC595<br>Port B: Display (VGA planned via FPGA/MCU) | Parallel I/O ports |
| **VIA 65C22** | Port A: 8 DIP switches<br>Port B: 8 LED bar | Digital input<br>Digital output |
| **Clock / Reset** | 1 MHz crystal oscillator + power-on reset | Core system timing |

## Software Architecture

### Hardware Abstraction Layer (HAL)

The HAL is being developed to provide low-level routines for standardized input/output:

| Routine | Description |
|----------|--------------|
| `CHAR_OUT_LCD` | Output character to LCD |
| `CHAR_OUT_PIA` | Output via PIA Port B (to VGA/FPGA) |
| `CHAR_OUT_ASIA` | Output via UART |
| `IRQ_KEYBOARD` | Input from PS/2 keyboard |
| `IRQ_ASIA` | Input via UART |
| `IRQ_Timer` | Timer Interrupt |
| `IO_DIRECTION` | Configure I/O direction (PIA, VIA) |
| `IO_READ` / `IO_WRITE` | Read or write port data |

### Firmware Layers

Planned firmware support includes:

- **Wozniak Monitor** – Original Apple I monitor adapted for 65C02 + UART  
- **Apple Cassette Interface (ACI)** – To be integrated in firmware (no separate ROM)  
- **BASIC** – Planned to be loadable via monitor or cassette  

## System Architecture

```
         +-------------------------+
         |        65C02 CPU        |
         +-----------+-------------+
                     |
             Address / Data Bus
                     |
            +--------+--------+
            |  PLD (ATF16V8B) |
            |  (Chip-Selects) |
            +--------+--------+
                     |
 +---------+---------+---------+----------+----------+--------+
 | EEPROM  |  SRAM   |  PIA    |  VIA     |   ACI    |  ASIA  |
 | (ROM)   | (RAM)   | 65C21   | 65C22    |          | 65C51  |
 +---------+---------+---------+----------+----------+--------+
                     |         |          |          |        |
                     +---------+----------+----------+--------+
                     |  PS/2   |  LEDs    | Cassette | Serial |
                     |  VGA    | Switches |          |        |
                     +---------+----------+----------+--------+
```

## Current Status

- [x] CPU, ROM, RAM, and PLD operational  
- [x] UART communication working  
- [x] LCD and keyboard tested  
- [ ] VIA I/O and Timer (switches, LEDs, interrupts)  
- [ ] ACI firmware integration  
- [ ] VGA output via FPGA  
- [ ] HAL subroutines completion  
- [ ] BASIC integration
- [ ] Schematics  

## Tools

- [VASM](http://sun.hasenbraten.de/vasm)
- [CC65](https://cc65.github.io/)  
- [Minipro](https://gitlab.com/DavidGriffith/minipro) + [WINE](https://www.winehq.org/)
- [WinCUPL](https://www.microchip.com/en-us/development-tool/WinCUPL)
- [GTKTerm](https://github.com/wvdakker/gtkterm)

## License

Licensed under the MIT License.
