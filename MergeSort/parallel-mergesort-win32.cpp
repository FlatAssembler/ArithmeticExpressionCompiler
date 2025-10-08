#include <algorithm>
#include <cmath>
#include <iostream>
#include <windows.h>

int *originalni_niz, *pomocni_niz;
HANDLE ghMutex;
int brojacKolikoJeUsporedbiMergeSortNapravio = 0, brojacThreadova = 0;
SYSTEM_INFO informacijeOSustavu; // Za broj procesora.

template <typename T> class MojKomparator {
private:
  bool jeLiBioAlociran = false;
  int *lokalni_brojac;

public:
  MojKomparator() {
    jeLiBioAlociran = true;
    lokalni_brojac = new int(0);
  }
  MojKomparator(int *inicijalizacija) {
    jeLiBioAlociran = false;
    lokalni_brojac = inicijalizacija;
  }
  int daj_brojanje() { return *lokalni_brojac; }
  bool operator()(T prviBroj, T drugiBroj) {
    (*lokalni_brojac)++;
    return prviBroj < drugiBroj;
  }
  MojKomparator(const MojKomparator<T> &x) {
    jeLiBioAlociran = x.jeLiBioAlociran;
    lokalni_brojac = x.lokalni_brojac;
  }
  ~MojKomparator() {
    if (jeLiBioAlociran)
      delete lokalni_brojac;
  }
};

struct Granice {
  int donja_granica, gornja_granica, dubina_rekurzije;
};

DWORD WINAPI paralelni_mergesort(LPVOID lpGranice) {
  Granice granice = *((Granice *)lpGranice);
  int donjaGranica = granice.donja_granica;
  int gornjaGranica = granice.gornja_granica;
  if (gornjaGranica - donjaGranica < 2)
    return 0;
  int dubinaRekurzije = granice.dubina_rekurzije;
  int sredinaNiza = (gornjaGranica + donjaGranica) / 2;
  Granice lijeviDio = {donjaGranica, sredinaNiza, dubinaRekurzije + 1},
          desniDio = {sredinaNiza, gornjaGranica, dubinaRekurzije + 1};
  if (dubinaRekurzije < std::log2(informacijeOSustavu.dwNumberOfProcessors)) {
    HANDLE noviThreadovi[2];
    DWORD ThreadID[2];
    noviThreadovi[0] =
        CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)paralelni_mergesort,
                     &lijeviDio, 0, &ThreadID[0]);
    noviThreadovi[1] =
        CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)paralelni_mergesort,
                     &desniDio, 0, &ThreadID[1]);
    if (!noviThreadovi[0] || !noviThreadovi[1]) {
      std::cerr << "Ne mogu stvoriti novi thread: " << GetLastError()
                << std::endl;
      delete[] originalni_niz;
      delete[] pomocni_niz;
      std::exit(1);
    }
    WaitForMultipleObjects(2, noviThreadovi, TRUE, INFINITE);
    WaitForSingleObject(ghMutex, INFINITE);
    brojacThreadova += 2;
    ReleaseMutex(ghMutex);
  } else {
    paralelni_mergesort(&lijeviDio);
    paralelni_mergesort(&desniDio);
  }
  int lokalni_brojac = 0;
  MojKomparator<int> komparator(&lokalni_brojac);
  std::merge(originalni_niz + donjaGranica, originalni_niz + sredinaNiza,
             originalni_niz + sredinaNiza, originalni_niz + gornjaGranica,
             pomocni_niz + donjaGranica, komparator);
  WaitForSingleObject(ghMutex, INFINITE);
  brojacKolikoJeUsporedbiMergeSortNapravio += lokalni_brojac;
  ReleaseMutex(ghMutex);
  std::copy(pomocni_niz + donjaGranica, pomocni_niz + gornjaGranica,
            originalni_niz + donjaGranica);
  return 0;
}

int main(void) {
  using std::cin;
  using std::cout;
  using std::endl;
  cout << "Unesite koliko cete brojeva unijeti." << endl;
  int n;
  cin >> n;
  try {
    originalni_niz = new int[n];
    pomocni_niz = new int[n];
  } catch (...) {
    std::cerr << "Nema dovoljno memorije za nastavak programa?!" << endl;
    return 1;
  }
  cout << "Unesite te brojeve: " << endl;
  for (int i = 0; i < n; i++)
    cin >> originalni_niz[i];
  GetSystemInfo(&informacijeOSustavu);
  ghMutex = CreateMutexA(NULL, 0, NULL);
  Granice cijeli_niz = {0, n, 0};
  HANDLE korijenskiThread;
  DWORD id_korijenskog_threada;
  korijenskiThread =
      CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)paralelni_mergesort,
                   &cijeli_niz, 0, &id_korijenskog_threada);
  if (korijenskiThread == NULL) {
    std::cerr << "Stvaranje korijenskog threada nije uspjelo: "
              << GetLastError() << endl;
    delete[] originalni_niz;
    delete[] pomocni_niz;
    return 1;
  }
  WaitForSingleObject(korijenskiThread, INFINITE);
  cout << "Nakon MergeSorta, niz je: " << endl;
  for (int i = 0; i < n; i++)
    cout << originalni_niz[i] << endl;
  cout << "MergeSort je napravio usporedbi: "
       << brojacKolikoJeUsporedbiMergeSortNapravio << endl;
  cout << "Koristio je threadova: " << brojacThreadova << endl;
  delete[] originalni_niz;
  delete[] pomocni_niz;
  system("PAUSE");
  return 0;
}
