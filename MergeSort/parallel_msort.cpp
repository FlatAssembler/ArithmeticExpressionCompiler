#include <cmath>
#include <ctime>
#include <mutex>
#include <thread>
#include <iostream>
#include <algorithm>

int *original_array,*auxiliary_array;
std::mutex protector_of_the_global_counter;
int global_counter=0;
std::mutex protector_of_the_thread_counter;
int number_of_threads=0;


template<typename T>
class Counting_Comparator {
    private:
    bool was_allocated;
    int *local_counter;
    public:
    Counting_Comparator() {
        was_allocated=true;
        local_counter=new int(0);
    }
    Counting_Comparator(int *init) {
        was_allocated=false;
        local_counter=init;
    }
    int get_count() {return *local_counter;}
    bool operator() (T first, T second) {
        (*local_counter)++;
        return first<second;
    }
    Counting_Comparator(const Counting_Comparator<T> &x) {
        was_allocated=x.was_allocated;
        local_counter=x.local_counter;
    }
    ~Counting_Comparator() {
        if (was_allocated) delete local_counter;
    }
};

struct limits {
    int lower_limit,upper_limit,reccursion_depth;
};

void parallel_merge_sort(limits argument) {
    int lower_limit=argument.lower_limit;
    int upper_limit=argument.upper_limit;
    if (upper_limit-lower_limit<2) return; //An array of length less than 2 is already sorted.
    int reccursion_depth=argument.reccursion_depth;
    int middle_of_the_array=(upper_limit+lower_limit)/2;
    limits left_part={lower_limit,middle_of_the_array,reccursion_depth+1},
            right_part={middle_of_the_array,upper_limit,reccursion_depth+1};
    if (reccursion_depth<log2(std::thread::hardware_concurrency())) { //Making more threads than there are CPU cores is counter-productive.
        try {
        std::thread left_thread(parallel_merge_sort,left_part),right_thread(parallel_merge_sort,right_part);
        protector_of_the_thread_counter.lock();
        number_of_threads+=2;
        protector_of_the_thread_counter.unlock();
        left_thread.join();
        right_thread.join();
        }
        catch(std::system_error error) {
            std::cerr <<"Can't create a new thread, error \"" <<error.what() <<"\"!" <<std::endl;
            delete[] original_array;
            delete[] auxiliary_array;
            exit(1);
        }
    }
    else
    {
        parallel_merge_sort(left_part);
        parallel_merge_sort(right_part);
    }
    int local_counter=0;
    Counting_Comparator<int> comparator_functor(&local_counter);
    std::merge(original_array+lower_limit,
            original_array+middle_of_the_array,
            original_array+middle_of_the_array,
            original_array+upper_limit,
            auxiliary_array+lower_limit,
            comparator_functor);
    protector_of_the_global_counter.lock();
    global_counter+=comparator_functor.get_count();
    protector_of_the_global_counter.unlock();
    std::copy(auxiliary_array+lower_limit,
            auxiliary_array+upper_limit,
            original_array+lower_limit);
}

int main(void) {
    using std::cout;
    using std::cin;
    using std::endl;
    cout <<"Enter how many numbers you will input." <<endl;
    int n;
    cin >>n;
    try {
        original_array=new int[n];
        auxiliary_array=new int[n];
    }
    catch (...) {
        std::cerr <<"Not enough memory!?" <<endl;
        return 1;
    }
    cout <<"Enter those numbers:" <<endl;
    for (int i=0; i<n; i++)
        cin >>original_array[i];
    limits entire_array={0,n,0};
    number_of_threads=1;
    clock_t processor_time=clock();
    try {
    std::thread root_of_the_reccursion(parallel_merge_sort,entire_array);
    root_of_the_reccursion.join();
    }
    catch (std::system_error error) {
        std::cerr <<"Can't create a new thread, error \"" <<error.what() <<"\"!" <<endl;
        delete[] original_array;
        delete[] auxiliary_array;
        return 1;
    }
    processor_time=clock()-processor_time;
    cout <<"The sorted array is:" <<endl;
    for (int i=0; i<n; i++)
        cout <<original_array[i] <<'\n';
    delete[] original_array;
    delete[] auxiliary_array;
    cout <<"It took MergeSort " <<global_counter <<" comparisons to sort it." <<endl;
    cout <<"It used " <<number_of_threads <<" threads." <<endl;
    cout <<"It took " <<float(processor_time)/CLOCKS_PER_SEC*1000 <<" miliseconds." <<endl;
    cout <<"The expected number of comparisons, by the formula n*ln(n), would be: " <<n*log(n) <<endl;
}
