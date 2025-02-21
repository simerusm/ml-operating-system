; bootloader.asm - 16-bit real mode bootloader (512 bytes)
[BITS 16]
ORG 0x7C00

start:
    ; Enable A20 line
    call enable_a20

    ; (Optional) Print a boot message
    mov si, boot_msg
    call print_string

    ; Read 20 sectors (20*512 = 10240 bytes) from disk starting at sector 2
    ; into memory at physical address 0x20000.
    mov ah, 0x02         ; BIOS read sectors function
    mov al, 20           ; Number of sectors to read
    mov ch, 0            ; Cylinder 0
    mov cl, 2            ; Starting at sector 2 (sector 1 is bootloader)
    mov dh, 0            ; Head 0
    mov dl, 0x80         ; Boot from first hard disk
    mov bx, 0x0000       ; Offset in segment
    mov ax, 0x2000       ; 0x2000 * 16 = 0x20000 (load address)
    mov es, ax
    int 0x13
    jc disk_error

    ; Jump to the kernel loaded at 0x20000.
    jmp 0x2000:0x0000

disk_error:
    mov si, disk_err_msg
    call print_string
    hlt

; BIOS teletype print routine
print_string:
    mov ah, 0x0E
.print_loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .print_loop
.done:
    ret

; Enable A20 line via port 0x92
enable_a20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

; Data
boot_msg      db "Bootloader: Loading kernel...", 0
disk_err_msg  db "Disk read error!", 0

; Pad to 510 bytes then add boot signature.
times 510 - ($ - $$) db 0
dw 0xAA55