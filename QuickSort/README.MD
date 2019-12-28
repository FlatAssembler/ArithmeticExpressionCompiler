This is an example of how to implement the QuickSort algorithm in AEC. "qsort.c" contains the equivalent C code, while "qsort.adb" contains the equivalent ADA code. In case somebody fails to compile the ADA code, "qsortInAda.elf" is a 32-bit Linux executable and "qsortInAda.elf64" is a 64-bit Linux executable, hopefully at least one of them helps.

"qsort.aec" contains the AEC source code. "qsort.asm" is the output produced by the compiler I made. "qsort.exe" is the executable produced by FlatAssembler from "qsort.asm". "qsort.aec.rtf" contains the syntax-highlighted code exported from Notepad++.

"qsort.cpp" calls the C++ "sort" function in a way that we can fairly compare the speeds.
