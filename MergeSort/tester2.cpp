#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>
#include <cstdlib>
#include <cmath>
#include <algorithm>

using namespace std;

clock_t getTimeInMiliseconds() {
    long ms;
    timespec spec;
    clock_gettime(CLOCK_MONOTONIC,&spec);
    return spec.tv_sec*1000+spec.tv_nsec/1e6;
}

bool sortirajUzlazno(int a,int b) {
    return a<b;
}

bool sortirajSilazno(int a,int b) {
    return a>b;
}

int main() {
    cout <<"Comparing the logarithm of the execution time of various implementations of efficient sorting algorithms on Ubuntu for different sortedness of the input of size 15'000." <<endl;
    cout <<"s\tC++ \"sort\" directive\tMergeSort in AEC\tMergeSort in ADA\tMergeSort in C\tQuickSort in AEC\tQuickSort in ADA\tQuickSort in C" <<endl;
    vector<int> polje;
    for (int i=1; i<=15000; i++)
        polje.push_back(i);
    for (int i=0; i<=15000; i+=50) {
        if (i<7500) sort(polje.begin(),polje.end(),sortirajUzlazno);
        else sort(polje.begin(),polje.end(),sortirajSilazno);
        for (int j=0; j<2*abs(i-7500); j++) {
            int prvi=rand()%15000;
            int drugi=rand()%15000;
            int tmp=polje[prvi];
            polje[prvi]=polje[drugi];
            polje[drugi]=tmp;
        }
        float s=0;
        for (int j=0; j<polje.size()-1; j++)
            s+=polje[j]<polje[j+1];
        s=s/((polje.size()-1)/2)-1;
        cout <<s <<'\t' <<flush;
        ofstream ulaz("ulaz.txt");
        ulaz <<polje.size() <<endl;
        for (int j=0; j<polje.size(); j++)
            ulaz <<polje[j] <<'\n';
        ulaz.close();
        clock_t prvi=getTimeInMiliseconds();
        system("./cppSortDirective.elf64 < ulaz.txt > /dev/null");
        clock_t drugi=getTimeInMiliseconds();
        cout <<log(drugi-prvi) <<'\t' <<flush;
        system("wine msort.exe < ulaz.txt > /dev/null");
        clock_t treci=getTimeInMiliseconds();
        cout <<log(treci-drugi) <<'\t' <<flush;
        system("./msortInAda.elf64 < ulaz.txt > /dev/null");
        clock_t cetvrti=getTimeInMiliseconds();
        cout <<log(cetvrti-treci) <<'\t' <<flush;
        system("./msortInC.elf64 < ulaz.txt > /dev/null");
        clock_t peti=getTimeInMiliseconds();
        cout <<log(peti-cetvrti) <<'\t' <<flush;
        system("wine qsort.exe < ulaz.txt > /dev/null");
        clock_t sesti=getTimeInMiliseconds();
        cout <<log(sesti-peti) <<'\t' <<flush;
        system("./qsortInAda.elf64 < ulaz.txt > /dev/null");
        clock_t sedmi=getTimeInMiliseconds();
        cout <<log(sedmi-sesti) <<'\t' <<flush;
        system("./qsortInC.elf64 < ulaz.txt > /dev/null");
        clock_t osmi=getTimeInMiliseconds();
        cout <<log(osmi-sedmi) <<endl;
    }
}
