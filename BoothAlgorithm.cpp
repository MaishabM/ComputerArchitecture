#include <bits/stdc++.h>
using namespace std;

const int n = 8; // Bit width

void arithmeticRightShift(bitset<n>& A, bitset<n>& Q, int& Q_1) {
    int new_A_MSB = A[n - 1];
    Q_1 = Q[0];

    // Shift Q right
    for (int i = 0; i < n - 1; i++) Q[i] = Q[i + 1];
    Q[n - 1] = A[0];

    // Shift A right
    for (int i = 0; i < n - 1; i++) A[i] = A[i + 1];
    A[n - 1] = new_A_MSB;
}

void boothMultiplication(int multiplicand, int multiplier) {
    bitset<n> M = bitset<n>(multiplicand);
    bitset<n> Q = bitset<n>(multiplier);
    bitset<n> A;
    bitset<n> M_neg = bitset<n>(-multiplicand);
    int Q_1 = 0;

    cout << "Initial State:\n";
    cout << "A: " << A << " Q: " << Q << " Q-1: " << Q_1 << endl;

    for (int step = 0; step < n; step++) {
        int Q0 = Q[0];
        if (Q0 == 1 && Q_1 == 0) {
            A = bitset<n>( (int)(bitset<n>(A).to_ulong()) + (int)(bitset<n>(M_neg).to_ulong()) );
        } else if (Q0 == 0 && Q_1 == 1) {
            A = bitset<n>( (int)(bitset<n>(A).to_ulong()) + (int)(bitset<n>(M).to_ulong()) );
        }

        arithmeticRightShift(A, Q, Q_1);

        cout << "Step " << step + 1 << ":\n";
        cout << "A: " << A << " Q: " << Q << " Q-1: " << Q_1 << endl;
    }

    // Combine A and Q for final result
    bitset<2 * n> product;
    for (int i = 0; i < n; i++) {
        product[i] = Q[i];
        product[i + n] = A[i];
    }

    cout << "\nFinal Product (binary): " << product << endl;
    cout << "Final Product (decimal): " << (int16_t)(product.to_ulong()) << endl; //int16_t for signed 16-bit value
}

int main() {
    int multiplicand, multiplier;
    cout << "Enter Multiplicand: ";
    cin >> multiplicand;
    cout << "Enter Multiplier: ";
    cin >> multiplier;

    boothMultiplication(multiplicand, multiplier);
    return 0;
}