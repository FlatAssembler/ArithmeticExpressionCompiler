int printf(const char*,...);
int scanf(const char*,...);
int system(const char*);
long long clock();
double log(double);

int original[32768],pomocni[32768];
int stog_s_donjim_granicama[32768],stog_s_gornjim_granicama[32768];
int vrh_stoga=0;
int brojac=0;

int main() {
	int n;
#ifdef IspisujPoruke
	printf("Unesite koliko cete brojeva unijeti.\n");
#endif
	scanf("%d",&n);
#ifdef IspisujPoruke
	printf("Unesite te brojeve:\n");
#endif
	for (int i=0; i<n; i++)
		scanf("%d",&original[i]);
	long long procesorskoVrijeme=clock();
	vrh_stoga++;
	stog_s_donjim_granicama[vrh_stoga]=0;
	stog_s_gornjim_granicama[vrh_stoga]=n;
	while (vrh_stoga) {
		int gornja_granica=stog_s_gornjim_granicama[vrh_stoga];
		int donja_granica=stog_s_donjim_granicama[vrh_stoga];
		vrh_stoga--;
#ifdef DEBUG
		printf("Sortiram od %d-tog do %d-tog clana.\n",donja_granica+1,gornja_granica+1);
#endif
		int gdje_je_pivot=donja_granica;
		int i=donja_granica+1;
		while (i<gornja_granica) {
			if (original[i]<original[donja_granica]) gdje_je_pivot++;
			i++;
		}
		int stavi_manje=donja_granica;
		int stavi_vece=gdje_je_pivot+1;
		pomocni[gdje_je_pivot]=original[donja_granica];
		i=donja_granica+1;
		while (i<gornja_granica) {
			if (original[i]<original[donja_granica])
			{
				pomocni[stavi_manje]=original[i];
				stavi_manje++;
			}
			else {
				pomocni[stavi_vece]=original[i];
				stavi_vece++;
			}
			brojac++;
			i++;
		}
		i=donja_granica;
		while (i<gornja_granica) {
			original[i]=pomocni[i];
			i++;
		}
#ifdef DEBUG
		printf("Pivot je na %d-tom mjestu.\n",gdje_je_pivot+1);
		printf("Niz sada izgleda ovako: ");
		for (int i=0; i<n; i++) printf ("%d ",original[i]);
		printf("\n");
#endif
		if (gdje_je_pivot<gornja_granica-1)
		{
			vrh_stoga++;
			stog_s_donjim_granicama[vrh_stoga]=gdje_je_pivot+1;
			stog_s_gornjim_granicama[vrh_stoga]=gornja_granica;
		}
		if (gdje_je_pivot>donja_granica+1) {
			vrh_stoga++;
			stog_s_donjim_granicama[vrh_stoga]=donja_granica;
			stog_s_gornjim_granicama[vrh_stoga]=gdje_je_pivot;
		}
#ifdef DEBUG
		system("sleep 1");
#endif
	}
	procesorskoVrijeme=clock()-procesorskoVrijeme;
#ifdef IspisujPoruke
	printf("Sortirani niz je:\n");
#endif
	for (int i=0; i<n; i++) printf("%d\n",original[i]);
#ifdef IspisujPoruke
	printf("Unutrasnja petlja izvrsila se %d puta.\n",brojac);
	printf("Ocekivani broj ponavljanja te petlje, po formuli n*log2(n), bio bi %.1f.\n",n*log(n)/log(2));
	printf("Sortiranje je trajalo %d milisekundi.\n",(int)procesorskoVrijeme);
	printf("Pritisnite CTRL+C za izlaz.\n");
	while (1);
#endif
	return 0;
}
