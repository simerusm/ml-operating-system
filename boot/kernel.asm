; kernel.asm - A minimal 16-bit kernel that prints a message
BITS 16
org 0x7E00         ; This must match the load address in the bootloader

start:
    ; Print the message pointed to by SI using BIOS teletype service
    mov si, message
.print_loop:
    lodsb           ; Load byte from [SI] into AL and increment SI
    cmp al, 0       ; Check for end-of-string (null terminator)
    je .done
    mov ah, 0x0E    ; BIOS teletype function
    int 0x10        ; Call BIOS video interrupt
    jmp .print_loop

.done:
    ; Halt the CPU indefinitely
    cli
.hang:
    hlt
    jmp .hang

; Data
message db "Hello, Kernel!", 0

; Pad the kernel to fill one sector (512 bytes)
times 512 - ($ - $$) db 0