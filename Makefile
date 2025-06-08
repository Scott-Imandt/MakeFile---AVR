# Makefile for AVR development

#COMMANDS: make, make flash, make clean

TARGET = main
MCU = attiny85 # or can be atmega328p
CFLAGS = -mmcu=$(MCU) -Os

PROGRAMMER = usbtiny
PART = t85 # or m328p

all: $(TARGET).hex

$(TARGET).out: $(TARGET).c
	avr-gcc $(CFLAGS) -o $@ $<

$(TARGET).hex: $(TARGET).out
	avr-objcopy -O ihex -j .text -j .data -R .eeprom $< $@

flash: $(TARGET).hex
	avrdude -c $(PROGRAMMER) -p $(PART) -U flash:w:$<:a

clean:
	rm -f *.out *.hex
