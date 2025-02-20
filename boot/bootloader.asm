; Simple x86 Bootloader (NASM syntax)
; This bootloader loads a single sector (512 bytes) from the disk into memory
; and jumps to it. It assumes the kernel is located immediately after the bootloader.

BITS 16             ; 16-bit real mode
ORG 0x7C00          ; BIOS loads the bootloader at this address

start:
    ; Set up segment registers
    xor ax, ax      ; Clear AX
    mov ds, ax      ; Set DS (data segment) to 0
    mov es, ax      ; Set ES (extra segment) to 0

    ; Print a message
    mov si, msg     ; Load address of the message into SI
    call print_string

    ; Load the kernel (1 sector) from disk
    mov ah, 0x02    ; BIOS read sector function
    mov al, 1       ; Number of sectors to read
    mov ch, 0       ; Cylinder number
    mov cl, 2       ; Sector number (2nd sector, after bootloader)
    mov dh, 0       ; Head number
    mov dl, 0x80    ; Use 0x80 for hard drive boot
    mov bx, 0x7E00  ; Load kernel to memory address 0x7E00
    int 0x13        ; BIOS disk interrupt

    ; Check for errors
    jc disk_error   ; Jump if carry flag is set (error)

    ; Jump to the loaded kernel
    jmp 0x7E00      ; Jump to the kernel at 0x7E00

disk_error:
    mov si, disk_error_msg
    call print_string
    hlt             ; Halt the CPU

print_string:
    mov ah, 0x0E    ; BIOS teletype function
.next_char:
    lodsb           ; Load next character from SI into AL
    cmp al, 0       ; Check for null terminator
    je .done        ; If null, we're done
    int 0x10        ; Print character
    jmp .next_char  ; Repeat for next character
.done:
    ret

; Data
msg db "Booting OS...", 0
disk_error_msg db "Disk read error!", 0

; Bootloader padding and signature
times 510-($-$$) db 0  ; Pad to 510 bytes
dw 0xAA55              ; Boot signature (magic number)
