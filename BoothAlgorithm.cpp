#include <bits/stdc++.h>
using namespace std;

const int n = 4;

// Convert signed int to n-bit two's complement bitset
bitset<n> toBitset(int num) {
    if (num >= 0)
        return bitset<n>(num);

    return bitset<n>((1 << n) + num);  // two's complement for negative
}

// Convert n-bit two's complement bitset to signed int
int toSigned(const bitset<n>& b) {
    if (b[n - 1] == 0)
        return b.to_ulong();           // positive

    return b.to_ulong() - (1 << n);    // negative
}

// Perform Arithmetic Shift Right on (A, Q, Q1)
void ASR(bitset<n> &A, bitset<n> &Q, int &Q1) {
    int A_msb = A[n - 1];
    int Q0 = Q[0];
    Q1 = Q0;

    // Right shift Q
    for (int i = 0; i < n - 1; i++) Q[i] = Q[i + 1];
    Q[n - 1] = A[0];

    // Right shift A
    for (int i = 0; i < n - 1; i++) A[i] = A[i + 1];
    A[n - 1] = A_msb;
}

void booth(int multiplier, int multiplicand) {
    bitset<n> M = toBitset(multiplicand);
    bitset<n> M_neg = toBitset(-multiplicand);
    bitset<n> Q = toBitset(multiplier);
    bitset<n> A;
    int Q1 = 0;

    cout << "Initial: ";
    cout << "A: " << A << " Q: " << Q << " Prev LSB: " << Q1 << endl;

    for (int i = 0; i < n; ++i) {
        int Q0 = Q[0];

        // Booth's Decision Logic
        if (Q0 == 1 && Q1 == 0)
            A = toBitset(toSigned(A) + toSigned(M_neg));
        else if (Q0 == 0 && Q1 == 1)
            A = toBitset(toSigned(A) + toSigned(M));

        cout << "Before ASR: " << "A: " << A << " Q: " << Q << " Prev LSB: " << Q1 << endl;
        ASR(A, Q, Q1);
        cout << "After ASR: " << "A: " << A << " Q: " << Q << " Prev LSB: " << Q1 << endl;

        cout << "\nStep " << i + 1 << ": ";
        cout << "A: " << A << " Q: " << Q << " Prev LSB: " << Q1 << endl;
    }

    bitset<2 * n> product;
    for (int i = 0; i < n; ++i) {
        product[i] = Q[i];          // LSB part
        product[i + n] = A[i];      // MSB part
    }

    // Convert 2n-bit binary to signed int
    int result;
    if (product[2 * n - 1] == 0)
        result = product.to_ulong();
    else
        result = product.to_ulong() - (1 << (2 * n));

    cout << "\nFinal Product (Binary): " << product << endl;
    cout << "Final Product (Decimal): " << result << endl;
}

int main() {
    int multiplier, multiplicand;
    cout << "Enter multiplier: ";
    cin >> multiplier;
    cout << "Enter multiplicand: ";
    cin >> multiplicand;

    booth(multiplier, multiplicand);
}