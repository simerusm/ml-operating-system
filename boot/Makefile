NASM = nasm
GXX = x86_64-elf-g++
OBJCOPY = x86_64-elf-objcopy

# Assemble as raw binary for bootloader and second-stage loader.
NASMFLAGS = -f bin

# C++ flags for 64-bit freestanding code.
CFLAGS = -m64 -ffreestanding -O2 -Wall -Wextra

all: os.img

# Build bootloader (512 bytes)
bootloader.bin: bootloader.asm
	$(NASM) $(NASMFLAGS) bootloader.asm -o bootloader.bin

# Assemble second-stage loader (kernel_entry.asm)
kernel_entry.bin: kernel_entry.asm
	$(NASM) $(NASMFLAGS) kernel_entry.asm -o kernel_entry.bin

# Compile the C++ kernel into an ELF file using the linker script.
kernel.elf: kernel.cpp linker.ld
	$(GXX) $(CFLAGS) kernel.cpp -o kernel.elf -T linker.ld -nostdlib -nostartfiles

# Convert the ELF kernel to a flat binary.
kernel_kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel_kernel.bin

# Combine the second-stage loader and the C++ kernel binary.
kernel.bin: kernel_entry.bin kernel_kernel.bin
	cat kernel_entry.bin kernel_kernel.bin > kernel.bin

# Pad the combined kernel binary to exactly 10240 bytes.
# This rule uses the system "truncate" command.
kernel_padded.bin: kernel.bin
	cp kernel.bin kernel_padded.bin
	truncate -s 10240 kernel_padded.bin

# Create the final OS image by concatenating the bootloader and the padded kernel.
os.img: bootloader.bin kernel_padded.bin
	cat bootloader.bin kernel_padded.bin > os.img

clean:
	rm -f *.bin *.elf os.img