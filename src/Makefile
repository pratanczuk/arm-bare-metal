
hello_serial_c.bin: hello_serial_c.elf hello_serial_c.o hello_serial_c_startup.o
	arm-none-eabi-objcopy -O binary hello_serial_c.elf hello_serial_c.bin

hello_serial_c.elf: hello_serial_c.o hello_serial_c_startup.o
	arm-none-eabi-ld -T hello_serial_c.ld hello_serial_c.o hello_serial_c_startup.o -o hello_serial_c.elf

hello_serial_c.o: hello_serial.c
	arm-none-eabi-gcc -c -mcpu=arm926ej-s -g hello_serial.c -o hello_serial_c.o

hello_serial_c_startup.o: hello_serial_c_startup.s
	arm-none-eabi-as -mcpu=arm926ej-s -g hello_serial_c_startup.s -o hello_serial_c_startup.o

start: hello_serial_c.elf
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel hello_serial_c.bin

# arm-none-eabi-gdb 
# target remote localhost:1234
# file hello_serial_c.elf

start_debug: hello_serial_c.elf
	qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel hello_serial_c.bin

hello_arm64: hello_arm64.s
	aarch64-linux-gnu-gcc -nostdlib -o hello_arm64 hello_arm64.s

start_hello_arm64: hello_arm64
	qemu-arm64-static -L /usr/aarch64-linux-gnu/ ./hello_arm64

hello_armel: hello_armel.s
	arm-linux-gnueabi-gcc -nostdlib -o hello_armel hello_armel.s

start_hello_armel: hello_armel
	qemu-arm-static ./hello_armel

clean:
	rm -f *.o
	rm -f *.elf
	rm -f *.bin
