#include <algorithm>
#include <chrono>
#include <iostream>
#include <iterator>
#include <random>

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
        0; // GNU linker omogucuje da se varijable ne deklariraju ne samo u
           // razlicitim datotekama, nego i u razlicitim jezicima.
void hybrid_sort(); //".global hybrid_sort" iz "hybrid_sort.aec". U C++-u ga
                    // morate deklarirati da biste ga mogli koristiti. C++ nije
                    // kao JavaScript ili AEC u tom pogledu, C++ pokusava
                    // pronaci krivo natipkana imena varijabli i funkcija vec za
                    // vrijeme compiliranja.
}

int main() {
  std::cout << "Unesite koliko zelite da generirani niz bude dugacak."
            << std::endl;
  int n;
  std::cin >> n;
  auto distribution = std::uniform_real_distribution<float>(-n, n);
  auto generator =
      std::default_random_engine(); // Moramo paziti da se generator
                                    // pseudo-nasumicnih brojeva inicijalizira
                                    // samo jednom, inace ce na Linuxu
                                    // generirati obrnuto sortirani niz (a ne
                                    // nasumicno poredan). To su nam spomenuli
                                    // na fakultetu, no ja to nisam uzeo
                                    // ozbiljno, pa sam se sada opekao.
  std::cout << "Generiram niz od " << n << " nasumicnih decimalnih brojeva..."
            << std::endl;
  std::generate_n(
      &originalni_niz[0], n,
      [&]() -> float { // C++-ove lambda funkcije, GCC ih podrzava od 2007, a
                       // komercijalni compileri jos od ranije. Nadajmo se da
                       // netko nece pokusati ukucati ovaj program u arhajski
                       // C++ compiler.
        return distribution(generator);
      });
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
