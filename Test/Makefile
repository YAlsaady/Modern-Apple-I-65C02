# Makefile for building and sending 6502 programs to Woz Monitor

# Source assembly file
SRC = LCD.s

# Derived filenames
BASENAME = $(basename $(SRC))
BIN = $(BASENAME).bin

# Default target: build + convert + send
all: load

# Assemble 6502 program
$(BIN): $(SRC)
	@echo "Assembling $< -> $@"
	@vasm6502_oldstyle -Fbin -dotdir -wdc02 $< -o $@ > /dev/null 2>&1

# Flash binary to EEPROM
load: $(BIN)
	@echo "Flashing $< to EEPROM"
	@ minipro -p AT28C256 -w $<

# Clean intermediate files
clean:
	@echo "Cleaning files..."
	@rm -f $(BIN)

# Phony targets
.PHONY: all load clean

