So, here is the program I made to help me analyze the diagrams produced by measurements.

The "genetic.cpp" file is a C++ source code. Many compilers apparently have trouble linking it, for some reason.

On Oracle Linux, I've compiled it with GCC 8.3, with this command: "g++ -o genetic.elf64 -O3 -static genetic.cpp". If you don't include "static", the linker shipped with Oracle Linux will go crazy.

Apparently, you can get a 32-bit executable with "clang++ -m32 -o genetic.elf -O3 genetic.cpp".

It apparently compiles without problems in MinGW GCC 8.2.

I am no expert in C++ to tell what's the problem here. In case somebody fails to compile the program, I will include the 32-bit Linux executable ("genetic.elf"), the 64-bit Linux executable ("genetic.elf64") and the 32-bit Windows executable ("genetic.exe"), hopefully your computer can usefully open at least one of those.
