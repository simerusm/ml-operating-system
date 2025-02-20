#!/bin/bash

qemu-system-x86_64 \
    -drive format=raw,file=boot/boot.bin \
    -m 128M \
    -s -S # enable gdb debug support
