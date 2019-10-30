#include <iostream>
#include <fstream>
#include <ctime>
#include <cstdlib>
#include <algorithm>

int polje[32768];

int main() {
    using namespace std;
    srand(time(NULL));
    int n=rand()%30000+1;
    for (int i=0; i<n; i++)
        polje[i]=rand()%30000-15000;
    ofstream izlaz("testin.txt");
    izlaz <<n <<endl;
    for (int i=0; i<n; i++)
        izlaz <<polje[i] <<'\n';
    izlaz.close();
    clock_t pocetak=clock();
    system("./qsort > testout.txt < testin.txt");
    clock_t kraj=clock();
    cout <<"Program se izvrsavao " <<kraj-pocetak <<" milisekundi." <<endl;
    sort(polje,polje+n);
    cout <<"C++-ov 'sort' je izvrsio isto sortiranje za " <<clock()-kraj <<" milisekundi." <<endl;
    ifstream ulaz("testout.txt");
    for (int i=0; i<n; i++)
    {
        int tmp;
        ulaz >>tmp;
        if (tmp!=polje[i])
        {
            cout <<"Nisu dali isti rezultat za " <<n <<" brojeva." <<endl;
            return 1;
        }
    }
    cout <<"Dali su isti rezultat za " <<n <<" brojeva." <<endl;
    ulaz.close();
    remove("testin.txt");
    remove("testout.txt");
    return 0;
}