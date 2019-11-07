#include <cmath>
#include <ctime>
#include <cstdio>
#include <algorithm>

int niz[32768];
int brojac=0;
bool usporedba(int a, int b) {
    brojac++;
    return a<b;
}

int main() {
    using std::printf;
    using std::sort;
    using std::scanf;
    int n;
#ifdef IspisujPoruke
	printf("Unesite koliko cete brojeva unijeti.\n");
#endif
	scanf("%d",&n);
#ifdef IspisujPoruke
	printf("Unesite te brojeve:\n");
#endif
	for (int i=0; i<n; i++)
		scanf("%d",&niz[i]);
	long long procesorskoVrijeme=clock();
	sort(niz,niz+n,usporedba);
	procesorskoVrijeme=clock()-procesorskoVrijeme;
#ifdef IspisujPoruke
	printf("Sortirani niz je:\n");
#endif
	for (int i=0; i<n; i++) printf("%d\n",niz[i]);
#ifdef IspisujPoruke
	printf("Unutrasnja petlja izvrsila se %d puta.\n",brojac);
	printf("Ocekivani broj ponavljanja te petlje, po formuli n*log2(n), bio bi %.1f.\n",n*log(n)/log(2));
	printf("Sortiranje je trajalo %d milisekundi.\n",int(procesorskoVrijeme));
	printf("Pritisnite CTRL+C za izlaz.\n");
	while (1);
#endif
	return 0;
}