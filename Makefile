# Makefile for AVR development

#COMMANDS: make, make flash, make clean

TARGET = main
MCU = attiny85 # or can be atmega328p
CFLAGS = -mmcu=$(MCU) -Os

PROGRAMMER = usbtiny
PART = t85 # or m328p

SRC = $(TARGET).c
BUILD_DIR = build

OUT_FILE = $(BUILD_DIR)/$(TARGET).out
HEX_FILE = $(BUILD_DIR)/$(TARGET).hex

# Default target
all: $(HEX_FILE)

# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile C to .out
$(OUT_FILE): $(SRC) | $(BUILD_DIR)
	avr-gcc $(CFLAGS) -o $@ $<

# Convert .out to .hex
$(HEX_FILE): $(OUT_FILE)
	avr-objcopy -O ihex -j .text -j .data -R .eeprom $< $@

# Flash to microcontroller
flash: $(HEX_FILE)
	avrdude -c $(PROGRAMMER) -p $(PART) -U flash:w:$(HEX_FILE):a

# Clean build files
clean:
	rm -rf $(BUILD_DIR)


