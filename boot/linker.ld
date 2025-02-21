/* linker.ld */
OUTPUT_FORMAT(elf64-x86-64)
ENTRY(_kernel_main)
SECTIONS
{
    /* Place the C++ kernel starting at 0x21000 */
    . = 0x21000;
    .text : { *(.text*) }
    .rodata : { *(.rodata*) }
    .data : { *(.data*) }
    .bss : { *(.bss*) }
    . = ALIGN(512);
}