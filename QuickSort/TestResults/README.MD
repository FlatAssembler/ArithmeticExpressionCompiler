The results of the tests comparing the speeds of the programs sorting relatively large (around 10'000 elements) arrays.

The most important conclusion of my measurements is that the number of comparisons done by a naive implementation of QuickSort can be predicted by the formula:

f(n,s)=exp((ln(n)+ln(ln(n)))\*1.05+(ln(n)-ln(ln(n)))\*0.85\*abs(2.38854\*pow(s,7)-0.284258\*pow(s,6)-1.87104\*pow(s,5)+0.372637\*pow(s,4)+0.167242\*pow(s,3)-0.0884977\*pow(s,2)+0.315119\*s))

In that formula, 'n' is the number of elements in an array, and 's' is the pre-sortedness of an array. If an element is sorted before QuickSort is called, 's' is 1. If it's reverse-sorted, 's' is -1. If 's' is randomly shuffled, 's' is approximately 0.
