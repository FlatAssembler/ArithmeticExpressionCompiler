This is an implementation of a hybrid sort algorithm, combining MergeSort and QuickSort, based on what appears to be more optimal, in AEC. Basically, if an array is nearly-sorted, it runs MergeSort, and if it appears to be randomly shuffled, it runs QuickSort instead.

"hsort.aec" contains the source code in the language of ArithmeticExpressionCompiler, "hsort.asm" contains the assembly that ArithmeticExpressionCompiler outputted for it, and "hsort.exe" is a 32-bit Windows executable produced by FlatAssembler by compiling "hsort.asm".
