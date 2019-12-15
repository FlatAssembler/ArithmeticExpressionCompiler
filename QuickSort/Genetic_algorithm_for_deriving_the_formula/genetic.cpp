/*
    So, this is the program with which the formula for the number of comparisons done by a naive implementation of QuickSort:
    f(n,s)=exp((ln(n)+ln(ln(n)))*1.05+(ln(n)-ln(ln(n)))*0.83*abs(2.38854*pow(s,7)-0.284258*pow(s,6)-1.87104*pow(s,5)+0.372637*pow(s,4)+0.167242*pow(s,3)-0.0884977*pow(s,2)+0.315119*s))
    was derived, where 'n' represents the number of elements in an array, and 's' represents the sortedness of the array.
    More explanation is available there:
    https://github.com/FlatAssembler/ArithmeticExpressionCompiler/blob/master/QuickSort/TestResults/README.MD
*/

#include <cmath>
#include <ctime>
#include <vector>
#include <sstream>
#include <cassert>
#include <iostream>
#include <algorithm>

using namespace std;

const double granica=3;
const int stupanj=8;

double evaluatePolynomFor(vector<double> polje, double x) {
    double ret=0;
    for (int i=0; i<polje.size(); i++)
        ret+=pow(x,polje.size()-i-1)*polje[i];
    return ret;
}

double randomDouble() {
    return double(rand())/RAND_MAX*2*granica-granica;
}

string convertToString(vector<double> polje) {
    ostringstream out;
    for (int i=0; i<polje.size(); i++) {
        out <<polje[i];
        if (i<polje.size()-1) {
            if (i==polje.size()-2)
                out <<"*s";
            else
                out <<"*pow(s," <<polje.size()-i-1 <<')';
            if (polje[i+1]>0)
                out <<'+';
        }
    }
    out <<flush;
    return out.str();
}

double pogreska(vector<double> polje, bool debug=false) {
    /*
        Coordinates read from the blue curve in the diagram
        https://github.com/FlatAssembler/ArithmeticExpressionCompiler/raw/master/QuickSort/TestResults/number_of_sorted_elements_logarithm_double_shuffled.png
        (442,416)
        (450,398)
        (480,395)
        (560,386)
        (758,322)
        (712,355)
        (638,374)
        (802,121)
    */
    const double pocetniX[]={442,450,480,560,758,712,638,802};
    const double pocetniY[]={416,398,395,386,322,355,374,121};
    vector<double> x,y;
    x.push_back(0);
    y.push_back(0);
    for (int i=1; i<8; i++)
        x.push_back((pocetniX[i]-pocetniX[0])/(pocetniX[7]-pocetniX[0]));
    for (int i=1; i<8; i++)
        y.push_back((pocetniY[0]-pocetniY[i])/(pocetniY[0]-pocetniY[7]));
    for (int i=1; i<8; i++) {
        x.push_back(-x[i]);
        y.push_back(-y[i]);
    }
    double ret=0;
    if (debug) {
        cout <<"Debugiranje funkcije \"pogreska\":" <<endl;
        cout <<"f(s)=" <<convertToString(polje) <<endl;
    }
    for (int i=0; i<x.size(); i++) {
        ret+=abs(evaluatePolynomFor(polje,x[i])-y[i])*
            ((abs(x[i])<1./10 || abs(x[i]+1)<1./10 || abs(x[i]-1)<1./10)?((sqrt(5)+1)/2):(1))
            +((x[i]<0)?(abs(evaluatePolynomFor(polje,x[i])+evaluatePolynomFor(polje,-x[i]))/2.):(0)) //Because it's important for the curve to be symmetric.
            +abs(polje[polje.size()-1])/4; //And it's important for it to have a root at x=0.
        if (debug) {
            cout <<"f(" <<x[i] <<")=" <<evaluatePolynomFor(polje,x[i]) <<endl;
            cout <<"Ocekivani odgovor: " <<y[i] <<endl;
            cout <<"Dosadasnja zbrojena pogreska: " <<ret <<endl;
        }
    }
    return ret;
}

bool usporedba(vector<double> prvi,vector<double> drugi) {
    return pogreska(prvi)<pogreska(drugi);
}

vector<double> mutiraj(vector<double> polje) {
    vector<double> ret;
    int tmp=rand()%polje.size();
    for (int i=0; i<polje.size(); i++)
        ret.push_back(polje[i]+randomDouble()*log(i+2)*(!(rand()%3)));
    return ret;
}

vector<double> krizaj(vector<double> prvi,vector<double> drugi) {
    vector<double> tmp;
    assert(prvi.size()==drugi.size());
    if (prvi==drugi)
        return mutiraj(prvi);
    int brojac=0;
    do {
    tmp.erase(tmp.begin(),tmp.end());
    for (int i=0; i<prvi.size(); i++)
        if (!(rand()%3))
            tmp.push_back((prvi[i]+drugi[i])/2);
        else if (rand()%2)
            tmp.push_back(prvi[i]);
        else
            tmp.push_back(drugi[i]);
    brojac++;
    if (brojac>=10) return mutiraj(drugi);
    }
    while (tmp==prvi || tmp==drugi);
    return tmp;
}

int main() {
    srand(time(0));
    vector<vector<double>> polje;
    for (int i=0; i<12*12; i++) {
        vector<double> tmp;
        for (int i=0; i<stupanj; i++)
            tmp.push_back(randomDouble());
        polje.push_back(tmp);
    }
    sort(polje.begin(),polje.end(),usporedba);
    cout <<"1. iteracija: f(s)=" <<convertToString(polje[0]) <<endl;
    cout <<"f(0)=" <<evaluatePolynomFor(polje[0],0) <<endl;
    cout <<"f(0.5)=" <<evaluatePolynomFor(polje[0],0.5) <<endl;
    cout <<"f(-0.5)=" <<evaluatePolynomFor(polje[0],-.5) <<endl;
    cout <<"f(1)=" <<evaluatePolynomFor(polje[0],1) <<endl;
    cout <<"f(-1)=" <<evaluatePolynomFor(polje[0],-1) <<endl;
    cout <<"Pogreska: " <<pogreska(polje[0],true) <<endl;
    polje.erase(polje.begin()+12,polje.end());
    for (int i=2; i<=12*12*12*2; i++) {
        for (int i=0; i<12; i++)
            for (int j=0; j<12; j++)
                if (i-j) polje.push_back(krizaj(polje[i],polje[j]));
        for (int i=0; i<12; i++)
            polje.push_back(mutiraj(polje[i]));
        for (int i=0; i<polje.size(); i++)
            if (isnan(pogreska(polje[i]))){
                polje.erase(polje.begin()+i);
                i--;
            }
        sort(polje.begin(),polje.end(),usporedba);
        cout <<i <<". iteracija: f(s)=" <<convertToString(polje[0]) <<endl;
        cout <<"f(0)=" <<evaluatePolynomFor(polje[0],0) <<endl;
        cout <<"f(0.5)=" <<evaluatePolynomFor(polje[0],0.5) <<endl;
        cout <<"f(-0.5)=" <<evaluatePolynomFor(polje[0],-.5) <<endl;
        cout <<"f(1)=" <<evaluatePolynomFor(polje[0],1) <<endl;
        cout <<"f(-1)=" <<evaluatePolynomFor(polje[0],-1) <<endl;
        cout <<"Pogreska: " <<pogreska(polje[0]) <<endl;
        polje.erase(polje.begin()+12,polje.end());
        if (i==12*12*12) {
            polje.erase(polje.begin()+6,polje.end());
            for (int i=0; i<12*12; i++) {
                vector<double> tmp;
                for (int i=0; i<stupanj; i++)
                    tmp.push_back(randomDouble());
                polje.push_back(tmp);
            }
            sort(polje.begin(),polje.end(),usporedba);
            polje.erase(polje.begin()+12,polje.end());
        }
    }
    return 0;
}
