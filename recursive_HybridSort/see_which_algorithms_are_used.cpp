/*
 * Dakle, ovo ce biti omotac oko "hybrid_sort.aec" napisan u C++-u.
 * "hybrid_sort.aec" sam po sebi nije program koji se moze pokrenuti,
 * i zato cemo od C++ compilera (u ovom slucaju, GCC-a) traziti da
 * napravi program unutar kojeg ce se "hybrid_sort.aec" moze pokrenuti,
 * i, po mogucnosti, koji ce olaksati da ga testiramo. Drugim rijecima,
 * ovo je program s kojim se "hybrid_sort.aec" moze staticki linkirati.
 * */
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <iterator>

namespace AEC { // Da se razlikuju AEC-ove varijable od C++-ovih.
extern "C" {    // Za GNU Linker (koji se dobije uz Linux i koristi ga GCC), AEC
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
} // namespace AEC
const int n = 1 << 16;

int main() {
  std::cout << "sortedness\tsorted_array\treverse\tMergeSort\tQuickSort\n";
  for (int i = 0; i < n; i++)
    AEC::originalni_niz[i] = i;
  for (int i = 0; i <= n; i += 1 << 9) {
    std::sort(&AEC::originalni_niz[0], &AEC::originalni_niz[n]);
    if (i < (n / 2))
      std::reverse(&AEC::originalni_niz[0], &AEC::originalni_niz[n]);
    int broj_ispremjestanja = abs(i - (n / 2)) * 1.5;
    for (int j = 0; j < broj_ispremjestanja; j++)
      std::iter_swap(&AEC::originalni_niz[std::rand() % n],
                     &AEC::originalni_niz[std::rand() % n]);
    if (!(rand() % 100))
      std::random_shuffle(
          &AEC::originalni_niz[0],
          &AEC::originalni_niz[n]); // Ponekad namjesti da poredanost bude nula.
    if (!(rand() % 100))
      std::sort(&AEC::originalni_niz[0], &AEC::originalni_niz[n],
                [](float a, float b) -> bool {
                  return a > b;
                }); // Ponekad namjesti da poredanost bude 1. Za to sam koristio
                    // C++-ove lambda funkcije. Njih GCC podrzava jos od 2007, a
                    // komercijalni compileri jos od ranije. Nadam se da netko
                    // nece pokusati ukucati ovo u neki arhaican compiler.
    float razvrstanost = 0;
    for (int j = 0; j < n - 1; j++)
      razvrstanost += AEC::originalni_niz[j] < AEC::originalni_niz[j - 1];
    razvrstanost = razvrstanost / ((n - 1) / 2) - 1;
    std::copy_n(&AEC::originalni_niz[0], n, &AEC::kopija_originalnog_niza[0]);
    AEC::broj_vec_poredanih_podniza = 0;
    AEC::broj_obrnuto_poredanih_podniza = 0;
    AEC::broj_pokretanja_MergeSorta = 0;
    AEC::broj_pokretanja_QuickSorta = 0;
    AEC::gornja_granica = n;
    AEC::donja_granica = 0;
    AEC::vrh_stoga = -1;
    AEC::hybrid_sort();
    std::sort(&AEC::kopija_originalnog_niza[0],
              &AEC::kopija_originalnog_niza[n]);
    if (!std::equal(&AEC::originalni_niz[0], &AEC::originalni_niz[n],
                    &AEC::kopija_originalnog_niza[0])) {
      std::cerr << "C++-ov std::sort nije dobio isti rezultat za i=" << i << '!'
                << std::endl;
      return 1; // Javi operativnom sustavu da je doslo do pogreske.
    }
    std::cout << razvrstanost << '\t'
              << std::log(1 + AEC::broj_vec_poredanih_podniza)
              << '\t' // Broj vec poredanih podniza moze biti i nula (ako je,
                      // recimo, razvrstanost jednaka -1), a, kako logaritam od
                      // nula ne postoji, dodat cu jedinicu da se program ne rusi
                      // na nekim compilerima.
              << std::log(1 + AEC::broj_obrnuto_poredanih_podniza) << '\t'
              << std::log(1 + AEC::broj_pokretanja_MergeSorta) << '\t'
              << std::log(1 + AEC::broj_pokretanja_QuickSorta) << '\n';
  }
  std::flush(std::cout); // Obrisi meduspremnik prije no sto zavrsis program.
  return 0; // Javi operativnom sustavu da je program uspjesno zavrsen.
}
