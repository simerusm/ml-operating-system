#!/bin/bash

nasm -f bin boot/bootloader.asm -o boot/boot.bin
nasm -f bin boot/kernel.asm -o boot/kernel.bin
cat boot/boot.bin boot/kernel.bin > os.img
qemu-system-x86_64 -drive format=raw,file=os.img

# you should see "hello world" in QEMU output