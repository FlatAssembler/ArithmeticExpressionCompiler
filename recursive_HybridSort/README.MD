A recursive variant of the HybridSort algorithm.

This time, I've chosen not to write the entire program in AEC, but just one function which can be statically linked against a tester program written, for example, in C++. Whereas the previous version of HybridSort can easily only be run on Windows, the "RecursiveHybridSortExecutables.zip" contains executables for 32-bit Windows, 32-bit Linux, 64-bit Linux (as some 64-bit Linuxes today refuse to run 32-bit programs) and even for [FreeDOS](http://www.freedos.org/) (compiled using [DJGPP](http://www.delorie.com/djgpp/)). Thus I am quite sure it can be run by a not-so-tech-savvy person on almost any computer of today.

The recursive version deals with the worst-case [scenarios](https://github.com/FlatAssembler/ArithmeticExpressionCompiler/blob/master/HybridSort/worst_case.txt) by checking the sortedness of the array on every iteration.

Also, the formula for determining the number of comparisons done by QuickSort has been changed to:

f(n, s) = exp((ln(n) + ln(ln(n))) * 1.05 + (ln(n) - ln(ln(n)) - **ln(2)) * 0.9163** * abs(2.38854 * pow(s,7) - 0.284258 * pow(s,6) - 1.87104 * pow(s,5) + 0.372637 * pow(s,4) + 0.167242 * pow(s,3) - 0.0884977 * pow(s,2) + 0.315119 * s))

In that formula, 'n' is the number of elements in an array, and 's' is the pre-sortedness of an array. If an element is sorted before QuickSort is called, 's' is 1. If it's reverse-sorted, 's' is -1. If 's' is randomly shuffled, 's' is approximately 0.

The new formula appears to work better than the formula used in the original HybridSort, especially for small arrays. The previous formula massively overestimated the number of comparisons QuickSort will do on small arrays, which could have lead to performance penalty (using MergeSort on small arrays where QuickSort would have done a lot better job).

However, it's apparently posssible to unintentionally (as I did) generate large arrays for which this algorithm will behave vastly suboptimally, see "worst_case.txt" as an example and "worst_case.png" to better see what's really going on. A temporary solution I've chosen is to switch from QuickSort to MergeSort after QuickSort has allocated too much stack memory (similar idea is used by IntroSort, when it switches to HeapSort), however, I suspect there are much better solutions.
