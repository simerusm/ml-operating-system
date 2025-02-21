; kernel_entry.asm - Second-stage loader: mode switch and jump to kernel
; This code is loaded at physical address 0x20000.
; Assemble with: nasm -f bin kernel_entry.asm -o kernel_entry.bin

[BITS 16]
org 0x20000

start16:
    cli
    xor ax, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Load our GDT
    lgdt [gdt_descriptor]

    ; Switch to Protected Mode: set PE bit in CR0
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Far jump to flush pipeline and enter Protected Mode
    jmp 0x08:pm_entry

[BITS 32]
pm_entry:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    ; Set up page tables for long mode
    call setup_paging

    ; Enable PAE in CR4
    mov eax, cr4
    or eax, 0x20
    mov cr4, eax

    ; Enable Long Mode: set LME in IA32_EFER MSR
    mov ecx, 0xC0000080
    rdmsr
    or eax, 0x100
    wrmsr

    ; Enable paging by setting PG bit in CR0
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

    ; Far jump to 64-bit long mode
    jmp 0x08:lm_entry

[BITS 64]
lm_entry:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov rsp, 0x100000

    ; Jump to the C++ kernel at 0x21000
    jmp 0x21000

hang:
    hlt
    jmp hang

; ------------------------------
; Global Descriptor Table (GDT)
align 8
gdt_start:
    dq 0                           ; Null descriptor
    dq 0x00AF9A000000FFFF          ; Code segment descriptor: base=0, limit=4GB, 4K gran, executable, readable
    dq 0x00CF92000000FFFF          ; Data segment descriptor: base=0, limit=4GB, 4K gran, writable
gdt_end:
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start
    dd 0

; ------------------------------
; Minimal Page Table Setup (identity map first 2MB using a 2MB page)
align 4096
pml4:
    times 512 dq 0
pdpt:
    times 512 dq 0
pd:
    times 512 dq 0

setup_paging:
    ; PML4[0] = address of PDPT | present, RW
    mov rax, pdpt
    or rax, 3
    mov [pml4], rax

    ; PDPT[0] = address of PD | present, RW
    mov rax, pd
    or rax, 3
    mov [pdpt], rax

    ; Map first 2MB: PD[0] = identity mapping for first 2MB | present, RW, PS
    mov rax, 0
    or rax, 0x83
    mov [pd], rax

    ret