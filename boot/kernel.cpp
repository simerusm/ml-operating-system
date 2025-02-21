// kernel.cpp - Simple x86_64 C++ kernel
extern "C" void _kernel_main() {
    const char* msg = "Hello from x86_64 C++ kernel!";
    volatile unsigned short* video = (volatile unsigned short*)0xB8000;
    for (int i = 0; msg[i] != '\0'; i++) {
        video[i] = (unsigned short)msg[i] | 0x0700;
    }
    while (1) { }
}