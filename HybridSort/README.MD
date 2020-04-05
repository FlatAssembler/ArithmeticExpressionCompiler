This is an implementation of a hybrid sort algorithm, combining MergeSort and QuickSort, based on what appears to be more optimal, in AEC. Basically, if an array is nearly-sorted, it runs MergeSort, and if it appears to be randomly shuffled, it runs QuickSort instead.

"hsort.aec" contains the source code in the language of ArithmeticExpressionCompiler, "hsort.asm" contains the assembly that ArithmeticExpressionCompiler outputted for it, and "hsort.exe" is a 32-bit Windows executable produced by FlatAssembler by compiling "hsort.asm". "hsort.aec.rtf" is an RTF file (can be opened by LibreOffice) containing the syntax-highlighted version of "hsort.aec", produced by Notepad++.

"hsort.c" is supposed to be an equivalent C program, and "hsort.s" is the assembly code printed by CLANG when asked to convert "hsort.c" to assembly.

"tester3.cpp" is the program I've used to measure performance of HybridSort.

"worst_case.txt" is what I think is the worst case for HybridSort. It contains an array (the first row is the size of the array) which has a near-zero sortedness at the beginning, but whose sortedness increases to 1 after just two iterations of QuickSort. HybridSort, namely, checks sortedness only at the beginning, because deciding whether QuickSort or MergeSort would do better requires expensive calculations with exponents. So, HybridSort is, if I am not mistaken, at the worst case, around 4 times faster than QuickSort is at its worst case. However, the worst case of QuickSort can easily happen accidentally in programs (array can accidentally be already nearly-sorted), while the worst case of HybridSort is very unlikely to happen.
