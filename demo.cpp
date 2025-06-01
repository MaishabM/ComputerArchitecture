#include<bits/stdc++.h>
using namespace std;
const int n=4;

void restoring(int dd, int ds) {
    bitset<n> M = bitset<n>(ds);
    bitset<n> Q = bitset<n>(dd);
    bitset<n+1> A;

    for(int i=0; i<n; i++) {
        A = A << 1;
        A[0] = Q[n-1];
        Q = Q << 1;     // left shift

        // A = A-M
        int temp = A.to_ulong() - M.to_ulong();
        A = bitset<n+1>(temp);

        // if A overflows,restore A and Q[0] = 0
        if(temp < 0) {
            A = bitset<n+1>(temp+M.to_ulong());
            Q[0] = 0;
        }
        else
            Q[0] = 1;
    }
    int quot = Q.to_ulong();
    int rem = A.to_ulong();

    cout << "The quotient in binary: " << Q << endl;
    cout << "The quotient in decimal: " << quot << endl;
    cout << "The remainder in binary: " << A << endl;
    cout << "The remainder in decimal: " << rem << endl;

}

int main() {
    int dd,ds;
    cout << "Enter dividend: ";
    cin >> dd;
    cout << "Enter divisor: ";
    cin >> ds;

    restoring(dd,ds);
}
