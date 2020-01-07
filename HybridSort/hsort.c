int printf(const char *, ...);
int scanf(const char *, ...);
int system(const char *);
long long clock();
double log(double x)
{
    double i = 1, delta = 1 / 1000.;
    if (x < 1)
	delta *= -1;
    double y = 0;		// ln(1)=0
    while ((x < 1 && i > x) || (x > 1 && i < x)) {
	y += delta * 1 / i;	// (d/dx)*ln(x)=1/x
	i += delta;
	if (i + delta == i)
	    delta *= 2;
    }
    return y;
}

double exp(double x)
{
    double i = 0, delta = 1 / 1000.;
    if (x < 0)
	delta *= -1;
    double y = 1;		// exp(0)=1
    while ((x < 0 && i > x) || (x > 0 && i < x)) {
	y += delta * y;		// (d/dx)*exp(x)=exp(x)
	i += delta;
	if (i + delta == i)
	    delta *= 2;
    }
    return y;
}

double fabs(double x)
{
    if (x < 0)
	return -x;
    return x;
}

double pow(double x, double y)
{
    if (!x)
	return 0;
    double ret = exp(log(fabs(x)) * y);
    int y_as_int = y;
    if (fabs(y - y_as_int) < 1. / 1000 && y_as_int % 2 && x < 0)
	ret *= -1;
    return ret;
}


int original[32768], pomocni[32768];
int stog_s_donjim_granicama[32768],
    stog_s_gornjim_granicama[32768];
int vrh_stoga = 0,
    donja_granica,
    gornja_granica,
    sredina_niza, gdje_je_pivot, gdje_smo_u_prvom_nizu,
    gdje_smo_u_drugom_nizu,
	stavi_manje, stavi_vece;
int brojac = 0, i;
enum {razdvajati,spajati} treba_li_spajati_ili_razdvajati,
	stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove[32768];
float razvrstanost,
    polinomPodApsolutnom,
    eNaKoju, kolikoUsporedbiOcekujemoOdQuickSorta, kolikoUsporedbiOcekujemoOdMergeSorta;

int main()
{
    int n;
#ifdef IspisujPoruke
    printf("Unesite koliko cete brojeva unijeti.\n");
#endif
    scanf("%d", &n);
#ifdef IspisujPoruke
    printf("Unesite te brojeve:\n");
#endif
    for (int i = 0; i < n; i++)
	scanf("%d", &original[i]);
    long long procesorskoVrijeme = clock();
    i = 0;
    razvrstanost = 0;
    while (i < n - 1) {
	razvrstanost += original[i] < original[i + 1];
	i++;
	brojac++;
    }
    razvrstanost = razvrstanost / ((float) (n - 1) / 2) - 1;
#ifdef IspisujPoruke
    printf("Razvrstanost pocetnog niza iznosi: %f\n", razvrstanost);
#endif
    polinomPodApsolutnom =
	2.38854 * pow(razvrstanost, 7) - 0.284258 * pow(razvrstanost,
							6) -
	1.87104 * pow(razvrstanost, 5) + 0.372637 * pow(razvrstanost,
							4) +
	0.167242 * pow(razvrstanost, 3) - 0.0884977 * pow(razvrstanost,
							  2) +
	0.315119 * razvrstanost;
    eNaKoju =
	(log(n) + log(log(n))) * 1.05 + (log(n) -
					 log(log(n))) * 0.83 *
	fabs(polinomPodApsolutnom);
    kolikoUsporedbiOcekujemoOdQuickSorta = exp(eNaKoju);
    kolikoUsporedbiOcekujemoOdMergeSorta = 2 * n * log(n) / log(2);
#ifdef IspisujPoruke
    printf
	("Od QuickSorta ocekujemo %f usporedbi, a od MergeSorta ocekujemo %f usporedbi.\n",
	 kolikoUsporedbiOcekujemoOdQuickSorta, kolikoUsporedbiOcekujemoOdMergeSorta);
#endif
    if (razvrstanost == 1) {
#ifdef IspisujPoruke
	printf("Niz je vec poredan, ne radimo nista.\n");
#endif
    } else if (razvrstanost == -1) {
#ifdef IspisujPoruke
	printf("Niz je obrnuto poredan.\n");
#endif
	i = 0;
	while (i < n) {
	    pomocni[i] = original[n - i - 1];
	    i = i + 1;
	    brojac = brojac + 1;
	}
	i = 0;
	while (i < n) {
	    original[i] = pomocni[i];
	    i = i + 1;
	}
    } else if (kolikoUsporedbiOcekujemoOdQuickSorta < kolikoUsporedbiOcekujemoOdMergeSorta) {
#ifdef IspisujPoruke
	printf("Primijenit cemo QuickSort algoritam.\n");
#endif
	vrh_stoga++;
	stog_s_donjim_granicama[vrh_stoga] = 0;
	stog_s_gornjim_granicama[vrh_stoga] = n;

	while (vrh_stoga) {
	    gornja_granica = stog_s_gornjim_granicama[vrh_stoga];
	    donja_granica = stog_s_donjim_granicama[vrh_stoga];
	    vrh_stoga--;
	    gdje_je_pivot = donja_granica;
	    i = donja_granica + 1;
	    while (i < gornja_granica) {
		if (original[i] < original[donja_granica])
		    gdje_je_pivot++;
		i++;
	    }
	    stavi_manje = donja_granica;
	    stavi_vece = gdje_je_pivot + 1;
	    pomocni[gdje_je_pivot] = original[donja_granica];
	    i = donja_granica + 1;
	    while (i < gornja_granica) {
		if (original[i] < original[donja_granica]) {
		    pomocni[stavi_manje] = original[i];
		    stavi_manje++;
		} else {
		    pomocni[stavi_vece] = original[i];
		    stavi_vece++;
		}
		brojac++;
		i++;
	    }
	    i = donja_granica;
	    while (i < gornja_granica) {
		original[i] = pomocni[i];
		i++;
	    }
	    if (gdje_je_pivot < gornja_granica - 1) {
		vrh_stoga++;
		stog_s_donjim_granicama[vrh_stoga] = gdje_je_pivot + 1;
		stog_s_gornjim_granicama[vrh_stoga] = gornja_granica;
	    }
	    if (gdje_je_pivot > donja_granica + 1) {
		vrh_stoga++;
		stog_s_donjim_granicama[vrh_stoga] = donja_granica;
		stog_s_gornjim_granicama[vrh_stoga] = gdje_je_pivot;
	    }
	}
    } else {
#ifdef IspisujPoruke
	printf("Primijenit cemo MergeSort algoritam.\n");
#endif
	vrh_stoga++;
	stog_s_donjim_granicama[vrh_stoga] = 0;
	stog_s_gornjim_granicama[vrh_stoga] = n;
	stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
	    [vrh_stoga] = razdvajati;
	while (vrh_stoga) {
	    gornja_granica = stog_s_gornjim_granicama[vrh_stoga];
	    donja_granica = stog_s_donjim_granicama[vrh_stoga];
	    int treba_li_spajati_ili_razdvajati =
		stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
		[vrh_stoga];
	    vrh_stoga--;
	    int sredina_niza = (donja_granica + gornja_granica) / 2;
	    if (!treba_li_spajati_ili_razdvajati) {
		if (gornja_granica - donja_granica > 1) {
		    vrh_stoga++;
		    stog_s_donjim_granicama[vrh_stoga] = donja_granica;
		    stog_s_gornjim_granicama[vrh_stoga] = gornja_granica;
		    stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
			[vrh_stoga] = spajati;
		    vrh_stoga++;
		    stog_s_donjim_granicama[vrh_stoga] = donja_granica;
		    stog_s_gornjim_granicama[vrh_stoga] = sredina_niza;
		    stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
			[vrh_stoga] = razdvajati;
		    vrh_stoga++;
		    stog_s_donjim_granicama[vrh_stoga] = sredina_niza;
		    stog_s_gornjim_granicama[vrh_stoga] = gornja_granica;
		    stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
			[vrh_stoga] = razdvajati;
		}
	    } else {
		i = donja_granica;
		gdje_smo_u_prvom_nizu = donja_granica;
		gdje_smo_u_drugom_nizu = sredina_niza;
		while (i < gornja_granica) {
		    if ((gdje_smo_u_prvom_nizu == sredina_niza
			 || original[gdje_smo_u_drugom_nizu] <
			 original[gdje_smo_u_prvom_nizu])
			&& gdje_smo_u_drugom_nizu < gornja_granica) {
			pomocni[i] = original[gdje_smo_u_drugom_nizu];
			gdje_smo_u_drugom_nizu++;
		    } else {
			pomocni[i] = original[gdje_smo_u_prvom_nizu];
			gdje_smo_u_prvom_nizu++;
		    }
		    i++;
		    brojac++;
		}
		i = donja_granica;
		while (i < gornja_granica) {
		    original[i] = pomocni[i];
		    brojac++;
		    i++;
		}
	    }
	}

    }
    procesorskoVrijeme = clock() - procesorskoVrijeme;
#ifdef IspisujPoruke
    printf("Sortirani niz je:\n");
#endif
    for (int i = 0; i < n; i++)
	printf("%d\n", original[i]);
#ifdef IspisujPoruke
    printf("Unutrasnja petlja izvrsila se %d puta.\n", brojac);
    printf
	("Ocekivani broj ponavljanja te petlje, po formuli n*log2(n), bio bi %.1f.\n",
	 n * log(n) / log(2));
    printf("Sortiranje je trajalo %d milisekundi.\n",
	   (int) procesorskoVrijeme);
    printf("Pritisnite CTRL+C za izlaz.\n");
    while (1);
#endif
    return 0;
}
