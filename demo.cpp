#include<bits/stdc++.h>
using namespace std;
const int n=4;

bitset<n> toBitset(int num) {
    if(num>=0)
        return bitset<n>(num);

    return bitset<n>((1<<n) + num);
}

int toSigned(const bitset<n> &num) {
    if(num[n-1]==0)
        return num.to_ulong();

    return num.to_ulong() - (1<<n);
}

void ASR(bitset<n> &A, bitset<n> &Q, int &LSB){
    LSB = Q[0];
    int A_msb = A[n-1];

    for(int i=0; i<n-1; i++) {
        Q[i] = Q[i+1];
    }
    Q[n-1] = A[0];

    for(int i=0; i<n-1; i++) {
        A[i] = A[i+1];
    }
    A[n-1] = A_msb;
}


void booth(int multiplier,int multiplicand) {
    bitset<n> M = toBitset(multiplicand);
    bitset<n> M_neg = toBitset(-multiplicand);
    bitset<n> Q = toBitset(multiplier);
    bitset<n> A;
    int LSB = 0;

    cout << "Initial: ";
    cout << "A: " << A << " Q: " << Q << " Prev LSB: " << LSB << endl;

    for(int i=0; i<n; i++) {
        int Q0 = Q[0];

        if(Q0==1 && LSB==0)
            A = toBitset(toSigned(A) + toSigned(M_neg));
        else if(Q0==0 && LSB==1)
            A = toBitset(toSigned(A) + toSigned(M));

        cout << "Before ASR: " << "A: " << A << " Q: " << Q << " Prev LSB: " << LSB << endl;
        ASR(A,Q,LSB);
        cout << "After ASR: " << "A: " << A << " Q: " << Q << " Prev LSB: " << LSB << endl;

        cout << "\nStep " << i+1 << ": ";
        cout << "A: " << A << " Q: " << Q << " Prev LSB: " << LSB << endl;
    }

    //Final result
    bitset<2*n> product;
    for(int i=0; i<n; i++) {
        product[i] = Q[i];
        product[i+n] = A[i];
    }

    int result;
    if(product[2*n-1]==0)
        result = product.to_ulong();
    else
        result = product.to_ulong() - (1 << (2*n));

    cout << "The product in binary: " << product << endl;
    cout << "The product in decimal: " << result;

}

int main() {
    int multiplier,multiplicand;
    cout << "Enter multiplier: ";
    cin >> multiplier;

    cout << "Enter multiplicand: ";
    cin >> multiplicand;

    booth(multiplier,multiplicand);
}
