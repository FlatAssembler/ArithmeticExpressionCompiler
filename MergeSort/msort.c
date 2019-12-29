int printf(const char*,...);
int scanf(const char*,...);
int system(const char*);
long long clock();
double log(double x) {
	double i=1,delta=1/1000.;
	if (x<1) delta*=-1;
	double y=0; //ln(1)=0
	while ((x<1 && i>x) || (x>1 && i<x)) {
		y+=delta*1/i; //(d/dx)*ln(x)=1/x
		i+=delta;
		if (i+delta==i) delta*=2;
	}
	return y;
}
int original[32768],pomocni[32768];
int stog_s_donjim_granicama[32768],stog_s_gornjim_granicama[32768],stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove[32768];
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
    stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove[vrh_stoga]=0;
	while (vrh_stoga) {
        int gornja_granica=stog_s_gornjim_granicama[vrh_stoga];
		int donja_granica=stog_s_donjim_granicama[vrh_stoga];
        int treba_li_spajati_ili_razdvajati=stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove[vrh_stoga];
        vrh_stoga--;
        int sredina_niza=(donja_granica+gornja_granica)/2;
        #ifdef DEBUG
		printf("Sortiram od %d-tog do %d-tog clana.\n",donja_granica+1,gornja_granica+1);
        #endif
        if (!treba_li_spajati_ili_razdvajati) {
            if (gornja_granica-donja_granica>1) {
                vrh_stoga++;
                stog_s_donjim_granicama[vrh_stoga]=donja_granica;
                stog_s_gornjim_granicama[vrh_stoga]=gornja_granica;
                stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove[vrh_stoga]=1;
                vrh_stoga++;
                stog_s_donjim_granicama[vrh_stoga]=donja_granica;
                stog_s_gornjim_granicama[vrh_stoga]=sredina_niza;
                stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove[vrh_stoga]=0;
                vrh_stoga++;
                stog_s_donjim_granicama[vrh_stoga]=sredina_niza;
                stog_s_gornjim_granicama[vrh_stoga]=gornja_granica;
                stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove[vrh_stoga]=0;
            }
        }
        else {
            int i=donja_granica;
            int gdje_smo_u_prvom_nizu=donja_granica;
            int gdje_smo_u_drugom_nizu=sredina_niza;
            while (i<gornja_granica) {
                if ((gdje_smo_u_prvom_nizu==sredina_niza || original[gdje_smo_u_drugom_nizu]<original[gdje_smo_u_prvom_nizu])
                    && gdje_smo_u_drugom_nizu<gornja_granica) {
                    pomocni[i]=original[gdje_smo_u_drugom_nizu];
                    gdje_smo_u_drugom_nizu++;
                }
                else {
                    pomocni[i]=original[gdje_smo_u_prvom_nizu];
                    gdje_smo_u_prvom_nizu++;
                }
                i++;
                brojac++;
            }
            #ifdef DEBUG
                printf("U prvom nizu dosli smo do %d-tog elementa, a u drugom smo dosli do %d-tog.\n",gdje_smo_u_prvom_nizu+1,gdje_smo_u_drugom_nizu+1);
            #endif
            i=donja_granica;
            while (i<gornja_granica) {
                original[i]=pomocni[i];
                brojac++;
                i++;
            }
        }
        #ifdef DEBUG
		printf("Sredina niza je na %d-tom mjestu.\n",sredina_niza+1);
		printf("Niz sada izgleda ovako: ");
		for (int i=0; i<n; i++) printf ("%d ",original[i]);
		printf("\n");
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
    printf("Ocekivani broj ponavljanja te petlje, po formuli 2*n*log2(n), bio bi %.1f.\n",2*n*log(n)/log(2));
	printf("Sortiranje je trajalo %d milisekundi.\n",(int)procesorskoVrijeme);
    #endif
}