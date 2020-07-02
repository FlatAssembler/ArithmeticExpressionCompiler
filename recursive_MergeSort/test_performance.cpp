#include <algorithm>
#include <chrono>
#include <iostream>
#include <iterator>
#include <random>

extern "C" {
float result, originalni_niz[32768 * 2], kopija_originalnog_niza[32768 * 2],
    pomocni_niz[32768 * 2], i, gdje_smo_u_prvom_nizu, gdje_smo_u_drugom_nizu,
    gornja_granica, donja_granica, sredina_niza, stog_sa_sredinama_niza[1024],
    stog_s_donjim_granicama[1024], stog_s_gornjim_granicama[1024], vrh_stoga;
void merge_sort();
}

void merge_sort_in_cpp(int donja_granica, int gornja_granica) {
  if (gornja_granica - donja_granica < 2)
    return;
  merge_sort_in_cpp(donja_granica, (donja_granica + gornja_granica) / 2);
  merge_sort_in_cpp((donja_granica + gornja_granica) / 2, gornja_granica);
  std::merge(&kopija_originalnog_niza[donja_granica],
             &kopija_originalnog_niza[(donja_granica + gornja_granica) / 2],
             &kopija_originalnog_niza[(donja_granica + gornja_granica) / 2],
             &kopija_originalnog_niza[gornja_granica],
             &pomocni_niz[donja_granica]);
  std::copy(&pomocni_niz[donja_granica], &pomocni_niz[gornja_granica],
            &kopija_originalnog_niza[donja_granica]);
}

int main() {
  std::cout << "n\tAEC merge_sort to std::sort\tAEC merge_sort to "
               "merge_sort_in_cpp\n";
  for (int n = 1000; n <= 65000; n += 1000) {
    std::generate_n(&originalni_niz[0], n, [=]() -> float {
      auto distribution = std::uniform_real_distribution<float>(-n, n);
      auto generator = std::default_random_engine();
      return distribution(generator);
    });
    std::copy_n(&originalni_niz[0], n, &kopija_originalnog_niza[0]);
    gornja_granica = n;
    donja_granica = 0;
    vrh_stoga = -1;
    auto prvoVrijeme = std::chrono::high_resolution_clock::now();
    merge_sort();
    auto drugoVrijeme = std::chrono::high_resolution_clock::now();
    std::sort(&kopija_originalnog_niza[0], &kopija_originalnog_niza[n]);
    auto treceVrijeme = std::chrono::high_resolution_clock::now();
    std::random_shuffle(&kopija_originalnog_niza[0],
                        &kopija_originalnog_niza[n]);
    auto cetvrtoVrijeme = std::chrono::high_resolution_clock::now();
    merge_sort_in_cpp(0, n);
    auto petoVrijeme = std::chrono::high_resolution_clock::now();
    if (!std::equal(&originalni_niz[0], &originalni_niz[n],
                    &kopija_originalnog_niza[0])) {
      std::cerr << "C++-ov std::sort nije dobio isti rezultat za velicinu niza"
                << n << "!" << std::endl;
      return 1;
    }
    std::cout << n << '\t'
              << (drugoVrijeme - prvoVrijeme).count() /
                     (treceVrijeme - drugoVrijeme).count()
              << '\t'
              << (drugoVrijeme - prvoVrijeme).count() /
                     (petoVrijeme - cetvrtoVrijeme).count()
              << '\n';
  }
  std::flush(std::cout);
  return 0;
}
