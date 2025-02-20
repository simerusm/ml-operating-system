#!/bin/bash

nasm -f bin bootloader.asm -o boot.bin
nasm -f bin kernel.asm -o kernel.bin
cat bootloader.bin kernel.bin > os.img
qemu-system-i386 -drive format=raw,file=os.img

# you should see "hello world" in QEMU output