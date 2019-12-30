#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>
#include <cstdlib>

using namespace std;

clock_t getTimeInMiliseconds() {
    long ms;
    timespec spec;
    clock_gettime(CLOCK_MONOTONIC,&spec);
    return spec.tv_sec*1000+spec.tv_nsec/1e6;
}

int main() {
    cout <<"Comparing execution time of various implementations of efficient sorting algorithms on Ubuntu for different input sizes." <<endl;
    cout <<"n\tC++ \"sort\" directive\tMergeSort in AEC\tMergeSort in ADA\tMergeSort in C\tQuickSort in AEC\tQuickSort in ADA\tQuickSort in C" <<endl;
    for (int i=100; i<=15000; i+=100) {
        cout <<i <<'\t';
        vector<int> polje;
        for (int j=0; j<i; j++)
            polje.push_back(rand()%15000+1);
        ofstream ulaz("ulaz.txt");
        ulaz <<i <<'\n';
        for (int j=0; j<polje.size(); j++)
            ulaz <<polje[j] <<'\n';
        ulaz.close();
        clock_t prvi=getTimeInMiliseconds();
        system("./cppSortDirective.elf64 < ulaz.txt > /dev/null");
        clock_t drugi=getTimeInMiliseconds();
        cout <<(drugi-prvi) <<'\t' <<flush;
        system("wine msort.exe < ulaz.txt > /dev/null");
        clock_t treci=getTimeInMiliseconds();
        cout <<(treci-drugi) <<'\t' <<flush;
        system("./msortInAda.elf64 < ulaz.txt > /dev/null");
        clock_t cetvrti=getTimeInMiliseconds();
        cout <<(cetvrti-treci) <<'\t' <<flush;
        system("./msortInC.elf64 < ulaz.txt > /dev/null");
        clock_t peti=getTimeInMiliseconds();
        cout <<(peti-cetvrti) <<'\t' <<flush;
        system("wine qsort.exe < ulaz.txt > /dev/null");
        clock_t sesti=getTimeInMiliseconds();
        cout <<(sesti-peti) <<'\t' <<flush;
        system("./qsortInAda.elf64 < ulaz.txt > /dev/null");
        clock_t sedmi=getTimeInMiliseconds();
        cout <<(sedmi-sesti) <<'\t' <<flush;
        system("./qsortInC.elf64 < ulaz.txt > /dev/null");
        clock_t osmi=getTimeInMiliseconds();
        cout <<(osmi-sedmi) <<endl;
    }
}
