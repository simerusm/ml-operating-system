#!/bin/bash

make
qemu-system-x86_64 -drive format=raw,file=os.img