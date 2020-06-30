/*The C++ wrapper around "fibonacci.aec". Compile this as:
    node aec fibonacci.aec #Assuming you've downloaded aec.js from the releases.
    g++ -o fibonacci let_gcc_setup_gas.cpp fibonacci.s
*/
#include <algorithm> //The "fill" function.
#include <cmath>     //The "isnan" function.
#include <iostream>
#ifdef _WIN32
#include <cstdlib> //system("PAUSE");
#endif

extern "C" { // To the GNU Linker (which comes with Linux and is used by GCC),
             // AEC language is a dialect of C, and AEC is a C compiler.
float n, stackWithLocalVariables[1024], memoisation[1024],
    topOfTheStackWithLocalVariables, temporaryResult, returnValue,
    result; // When using GCC, there is no need to declare variables in the same
            // file as you will be using them, or even in the same language. So,
            // no need to look up the hard-to-find information about how to
            // declare variables in GNU Assembler while targeting 64-bit Linux.
            // GCC and GNU Linker will take care of that.
void fibonacci(); // The ".global fibonacci" from inline assembly in
                  // "fibonacci.aec" (you need to declare it, so that the C++
                  // compiler doesn't complain: C++ isn't like JavaScript or AEC
                  // in that regard, C++ tries to catch errors such as a
                  // mistyped function or variable name in compile-time).
}

int main() {
  std::cout << "Enter n:" << std::endl;
  std::cin >> n;
  topOfTheStackWithLocalVariables = -1;
  if (n >= 2)
    std::fill(&memoisation[0], &memoisation[int(n)],
              0); // This is way more easily done in C++ than in AEC here,
                  // because the AEC subprogram doesn't know if it's being
                  // called by C++ or recursively by itself.
  fibonacci();
  if (std::isnan(returnValue)) {
    std::cerr << "The AEC program returned an invalid decimal number."
              << std::endl;
    return 1;
  }
  std::cout << "The " << n
            << ((int(n) % 10 == 3)
                    ? ("rd")
                    : (int(n) % 10 == 2) ? ("nd")
                                         : (int(n) % 10 == 1) ? ("st") : "th")
            << " Fibonacci number is " << returnValue << "." << std::endl;
#ifdef _WIN32
  std::system("PAUSE");
#endif
  return 0;
}
