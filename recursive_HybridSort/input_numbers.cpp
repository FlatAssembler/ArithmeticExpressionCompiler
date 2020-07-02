#include <algorithm>
#include <chrono>
#include <iostream>
#include <iterator>

extern "C" { // Za GNU Linker (koji se dobije uz Linux i koristi ga GCC), AEC
             // jezik je dijalekt C-a, a moj compiler je C compiler.
float result, originalni_niz[32768], kopija_originalnog_niza[32768],
    pomocni_niz[32768], i, gdje_smo_u_prvom_nizu, gdje_smo_u_drugom_nizu,
    gornja_granica, donja_granica, sredina_niza, stog_sa_sredinama_niza[1024],
    stog_s_donjim_granicama[1024], stog_s_gornjim_granicama[1024], vrh_stoga,
    pomocna_varijabla_za_zamijenu, gdje_je_pivot, j, pivot,
    koliko_usporedbi_ocekujemo_od_QuickSorta,
    koliko_usporedbi_ocekujemo_od_MergeSorta, razvrstanost,
    Eulerov_broj_na_koju_potenciju, polinom_pod_apsolutnom,
    razvrstanost_na_potenciju[8],
    broj_vec_poredanih_podniza = 0, broj_obrnuto_poredanih_podniza = 0,
    broj_pokretanja_MergeSorta = 0,
    broj_pokretanja_QuickSorta =
        0; // GNU linker omogucuje da se varijable ne deklariraju ne samo u
           // razlicitim datotekama, nego i u razlicitim jezicima.
void hybrid_sort(); //".global hybrid_sort" iz "hybrid_sort.aec". U C++-u ga
                    //morate deklarirati da biste ga mogli koristiti. C++ nije
                    //kao JavaScript ili AEC u tom pogledu, C++ pokusava pronaci
                    //krivo natipkana imena varijabli i funkcija vec za vrijeme
                    //compiliranja.
}

int main() {
  std::cout << "Unesite koliko niz ima brojeva." << std::endl;
  int n;
  std::cin >> n;
  std::cout << "Unesite te brojeve:" << std::endl;
  std::copy_n(std::istream_iterator<float>(std::cin), n, &originalni_niz[0]);
  std::copy_n(&originalni_niz[0], n, &kopija_originalnog_niza[0]);
  gornja_granica = n;
  donja_granica = 0;
  vrh_stoga = -1;
  std::cout << "Pokrecem potprogram u AEC-u..." << std::endl;
  auto prvoVrijeme = std::chrono::high_resolution_clock::now();
  hybrid_sort();
  auto drugoVrijeme = std::chrono::high_resolution_clock::now();
  std::cout << "Potprogram u AEC-u je zavrsio." << std::endl;
  std::cout
      << "Detektirao je " << broj_vec_poredanih_podniza
      << " vec poredanih podnizova,\n"
      << broj_obrnuto_poredanih_podniza << " obrnuto poredanih podniza,\n"
      << broj_pokretanja_MergeSorta
      << " priblizno poredanih podnizova (pogodnih za MergeSort)\n i "
      << broj_pokretanja_QuickSorta
      << " nasumicno ispremjestanih podnizova.\nPokrecem C++-ov std::sort..."
      << std::endl;
  std::cout << "On tvrdi da je sortirani niz:" << std::endl;
  std::copy_n(&originalni_niz[0], n,
              std::ostream_iterator<float>(std::cout, "\n"));
  auto treceVrijeme = std::chrono::high_resolution_clock::now();
  std::sort(&kopija_originalnog_niza[0], &kopija_originalnog_niza[n]);
  auto cetvrtoVrijeme = std::chrono::high_resolution_clock::now();
  if (!std::equal(&originalni_niz[0], &originalni_niz[n],
                  &kopija_originalnog_niza[0])) {
    std::cout << "C++-ov std::sort nije dobio isti rezultat!" << std::endl;
    return 1;
  }
  std::cout << "C++-ov std::sort dobio je isti rezultat." << std::endl;
  std::cout << "C++-ov std::sort vrtio se "
            << (cetvrtoVrijeme - treceVrijeme).count()
            << " procesorskih taktova." << std::endl;
  std::cout << "AEC-ov hybrid_sort vrtio se "
            << (drugoVrijeme - prvoVrijeme).count() << " procesorskih taktova."
            << std::endl;
  return 0;
}
