#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

struct granice {int donja_granica,gornja_granica,dubina_rekurzije;};

int *original,*pomocni,brojac=0;
pthread_mutex_t mutex;

void *merge_sort(void *arg) {
    int lokalni_brojac=0;
    struct granice *argument=(struct granice*)arg;
    int donja_granica=argument->donja_granica;
    int gornja_granica=argument->gornja_granica;
    int dubina_rekurzije=argument->dubina_rekurzije;
    int sredina_niza=(donja_granica+gornja_granica)/2;
    if (gornja_granica-donja_granica<2) return NULL;
    pthread_t lijeva_nit;
    pthread_t desna_nit;
    struct granice argument_lijevog={donja_granica,sredina_niza,dubina_rekurzije+1};
    struct granice argument_desnog={sredina_niza,gornja_granica,dubina_rekurzije+1};
    if (dubina_rekurzije<3) { //Procesor na kojem ce se taj program izvrsavati vjerojatno nema vise od 2^3=8 jezgri, pa je daljnje paraleliziranje kontraproduktivno.
        int error1=pthread_create(&lijeva_nit,NULL,merge_sort,&argument_lijevog);
        int error2=pthread_create(&desna_nit,NULL,merge_sort,&argument_desnog);
        if (error1 || error2) {
            fprintf(stderr,"Nema dovoljno memorije za nastavak programa!?\n");
            exit(1);
        }
        pthread_join(lijeva_nit,NULL);
        pthread_join(desna_nit,NULL);
    }
    else
    {
        merge_sort(&argument_lijevog);
        merge_sort(&argument_desnog);
    }
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
        lokalni_brojac++;
        i++;
    }
    i=donja_granica;
    while (i<gornja_granica) {
        original[i]=pomocni[i];
        i++;
        lokalni_brojac++;
    }
    #ifdef IspisujPoruke
        pthread_mutex_lock(&mutex);
        brojac+=lokalni_brojac;
        pthread_mutex_unlock(&mutex);
    #endif
    return NULL;
}

int main() {
    int n;
    #ifdef IspisujPoruke
        printf("Unesite koliko cete brojeva unijeti.\n");
    #endif
    scanf("%d",&n);
    original=malloc(sizeof(int)*n);
    pomocni=malloc(sizeof(int)*n);
    if (!original || !pomocni) {
        fprintf(stderr,"Nema dovoljno memorije za nastavak programa!?\n");
        return 1;
    }
    #ifdef IspisujPoruke
	    printf("Unesite te brojeve:\n");
    #endif
    for (int i=0; i<n; i++)
        scanf("%d",original+i);
    struct granice pocetne_granice={0,n,0};
    pthread_t korijen_rekurzije;
    #ifdef IspisujPoruke
        long long procesorskoVrijeme=clock();
        pthread_mutex_init(&mutex,NULL);
    #endif
    int error=pthread_create(&korijen_rekurzije,NULL,merge_sort,&pocetne_granice);
    if (error) {
        fprintf(stderr,"Nema dovoljno memorije za nastavak programa!?\n");
        return 1;
    }
    pthread_join(korijen_rekurzije,NULL);
    #ifdef IspisujPoruke
        procesorskoVrijeme=clock()-procesorskoVrijeme;
        pthread_mutex_destroy(&mutex);
    #endif
    #ifdef IspisujPoruke
	    printf("Sortirani niz je:\n");
    #endif
    for (int i=0; i<n; i++)
        printf("%d\n",original[i]);
    free(original);
    free(pomocni);
    #ifdef IspisujPoruke
	    printf("Unutrasnja petlja izvrsila se %d puta.\n",brojac);
        printf("Ocekivani broj ponavljanja te petlje, po formuli 2*n*log2(n), bio bi %.1f.\n",2*n*log(n)/log(2));
        printf("Sortiranje je trajalo %f milisekundi.\n",(float)procesorskoVrijeme/CLOCKS_PER_SEC*1000);
    #endif
    return 0;
}