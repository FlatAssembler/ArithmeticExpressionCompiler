#include <algorithm>
#include <chrono>
#include <iostream>
#include <iterator>

extern "C" {
float result, originalni_niz[32768], kopija_originalnog_niza[32768],
    pomocni_niz[32768], i, gdje_smo_u_prvom_nizu, gdje_smo_u_drugom_nizu,
    gornja_granica, donja_granica, sredina_niza, stog_sa_sredinama_niza[1024],
    stog_s_donjim_granicama[1024], stog_s_gornjim_granicama[1024], vrh_stoga;
void merge_sort();
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
  merge_sort();
  auto drugoVrijeme = std::chrono::high_resolution_clock::now();
  std::cout << "Potprogram u AEC-u je zavrsio." << std::endl;
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
  std::cout << "AEC-ov merge_sort vrtio se "
            << (drugoVrijeme - prvoVrijeme).count() << " procesorskih taktova."
            << std::endl;
  return 0;
}
