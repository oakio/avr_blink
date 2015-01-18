SRC = ./src
BUILD = ./build
CPU = atmega328p

all:	build

clean:
	rm -rf $(BUILD)

build:	clean
	mkdir $(BUILD)
	avr-gcc -Wall -Os -mmcu=$(CPU) $(SRC)/main.c -o $(BUILD)/main.o
	avr-objcopy -j .text -j .data -O ihex $(BUILD)/main.o $(BUILD)/main.hex
	avr-objdump -h -S $(BUILD)/main.o > $(BUILD)/main.lss

setup:
	avrdude -p $(CPU) -c usbasp -U lfuse:w:0xff:m -U hfuse:w:0xda:m -U efuse:w:0x05:m

flash:	build
	avrdude -p $(CPU) -c usbasp -U flash:w:$(BUILD)/main.hex:i
