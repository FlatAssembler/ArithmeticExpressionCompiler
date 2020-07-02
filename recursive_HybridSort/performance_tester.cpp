/*
 * Dakle, ovo ce biti omotac oko "hybrid_sort.aec" napisan u C++-u.
 * "hybrid_sort.aec" sam po sebi nije program koji se moze pokrenuti,
 * i zato cemo od C++ compilera (u ovom slucaju, GCC-a) traziti da
 * napravi program unutar kojeg ce se "hybrid_sort.aec" moze pokrenuti,
 * i, po mogucnosti, koji ce olaksati da ga testiramo. Drugim rijecima,
 * ovo je program s kojim se "hybrid_sort.aec" moze staticki linkirati.
 * */
#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <iterator>

extern "C" { // Za GNU Linker (koji se dobije uz Linux i koristi ga GCC), AEC
// jezik je dijalekt C-a, a moj compiler je C compiler.
float result, originalni_niz[1 << 16], kopija_originalnog_niza[1 << 16],
    pomocni_niz[1 << 16], i, gdje_smo_u_prvom_nizu, gdje_smo_u_drugom_nizu,
    gornja_granica, donja_granica, sredina_niza,
    stog_sa_sredinama_niza[1 << 10], stog_s_donjim_granicama[1 << 10],
    stog_s_gornjim_granicama[1 << 10], vrh_stoga, pomocna_varijabla_za_zamijenu,
    gdje_je_pivot, j, pivot, koliko_usporedbi_ocekujemo_od_QuickSorta,
    koliko_usporedbi_ocekujemo_od_MergeSorta, razvrstanost,
    Eulerov_broj_na_koju_potenciju, polinom_pod_apsolutnom,
    razvrstanost_na_potenciju[8],
    broj_vec_poredanih_podniza = 0, broj_obrnuto_poredanih_podniza = 0,
    broj_pokretanja_MergeSorta = 0,
    broj_pokretanja_QuickSorta =
        0; // GNU Linker omogucuje da se varijable ne deklariraju ne samo u
           // razlicitim datotekama, nego i u razlicitim jezicima. Znaci, ne
           // moram traziti kako se, recimo, na 64-bitnom Linuxu deklariraju
           // globalne varijable na asemblerskom jeziku, jer GCC to vec zna.
void hybrid_sort(); //".global hybrid_sort" iz "hybrid_sort.aec". U C++-u ga
// morate deklarirati da biste ga mogli koristiti. C++ nije
// kao JavaScript ili AEC u tom pogledu, C++ pokusava pronaci
// krivo natipkana imena varijabli i funkcija vec za vrijeme
// compiliranja.
}

const int n = 1 << 16;

int main() {
  std::cout << "sortedness\tc++ std::sort\tAEC hybrid_sort\n";
  for (int i = 0; i < n; i++)
    originalni_niz[i] = i;
  for (int i = 0; i <= n; i += 1 << 9) {
    std::sort(&originalni_niz[0], &originalni_niz[n]);
    if (i < 1 << 15)
      std::reverse(&originalni_niz[0], &originalni_niz[n]);
    int broj_ispremjestanja = abs(i - (1 << 15)) * 1.5;
    for (int j = 0; j < broj_ispremjestanja; j++)
      std::iter_swap(&originalni_niz[std::rand() % n],
                     &originalni_niz[std::rand() % n]);
    if (!(rand() % 100))
      std::random_shuffle(
          &originalni_niz[0],
          &originalni_niz[n]); // Ponekad namjesti da poredanost bude nula.
    if (!(rand() % 100))
      std::sort(&originalni_niz[0], &originalni_niz[n],
                [](float a, float b) -> bool {
                  return a > b;
                }); // Ponekad namjesti da poredanost bude 1. Za to sam koristio
                    // C++-ove lambda funkcije. Njih GCC podrzava jos od 2007, a
                    // komercijalni compileri jos od ranije. Nadam se da netko
                    // nece pokusati ukucati ovo u neki arhaican compiler.
    float poredanost = 0;
    for (int j = 0; j < n - 1; j++)
      poredanost += originalni_niz[j] < originalni_niz[j - 1];
    poredanost = poredanost / ((n - 1) / 2) - 1;
    std::copy_n(&originalni_niz[0], n, &kopija_originalnog_niza[0]);
    gornja_granica = n;
    donja_granica = 0;
    vrh_stoga = -1;
    auto prvoVrijeme = std::chrono::high_resolution_clock::now();
    hybrid_sort();
    auto drugoVrijeme = std::chrono::high_resolution_clock::now();
    std::sort(&kopija_originalnog_niza[0], &kopija_originalnog_niza[n]);
    auto treceVrijeme = std::chrono::high_resolution_clock::now();
    if (!std::equal(&originalni_niz[0], &originalni_niz[n],
                    &kopija_originalnog_niza[0])) {
      std::cerr << "C++-ov std::sort nije dobio isti rezultat za i=" << i << '!'
                << std::endl;
      return 1; // Javi operativnom sustavu da je doslo do pogreske.
    }
    std::cout << poredanost << '\t'
              << log((treceVrijeme - drugoVrijeme).count()) << '\t'
              << log((drugoVrijeme - prvoVrijeme).count()) << '\n';
  }
  std::flush(std::cout); // Obrisi meduspremnik prije no sto zavrsis program.
  return 0; // Javi operativnom sustavu da je program uspjesno zavrsen.
}
