# $< first arg
# $^ all args
# $@ output
run: os-image
	qemu-system-i386 os-image
C_SOURCES = $(wildcard kernel/*.c)
OBJ = $(C_SOURCES:.c=.o)

all: os-image
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o : %.c
	gcc -ffreestanding -c $< -o $@

%.o : %.asm
	nasm $< -f elf -o $@


%.bin : %.asm
	nasm $< -f bin -I . -o $@

clean:
	rm -rf *.bin os-image
	rm -rf kernel/*.o boot/*.bin kernel/*.dis
