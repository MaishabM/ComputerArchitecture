#include <bits/stdc++.h>
using namespace std;

const int n = 4;

bitset<n> toBitset(int num) {
    if (num >= 0) return bitset<n>(num);
    return bitset<n>((1 << n) + num);
}

int toSigned(bitset<n> bits) {
    if (bits[n - 1] == 0) return bits.to_ulong();
    return bits.to_ulong() - (1 << n);
}

void sequential(bitset<n> M, bitset<n> Q) {
    bitset<n> A;

    cout << "Initial State:\n";
    cout << "M: " << M << "  Q: " << Q << "  A: " << A << endl;

    for (int i = 0; i < n; ++i) {
        if (Q[0] == 1)
            A = toBitset(toSigned(A) + toSigned(M));

        int amsb = A[n - 1];

        // Shift Q right and bring A[0] into Q[n-1]
        Q >>= 1;
        Q[n - 1] = A[0];

        // Shift A right and retain its sign bit
        A >>= 1;
        A[n - 1] = amsb;

        cout << "Step " << i + 1 << ": ";
        cout << "A: " << A << "  Q: " << Q << "\n";
    }

    // Combine A and Q for final 8-bit result
    bitset<2 * n> result;
    for (int i = 0; i < n; ++i) {
        result[i] = Q[i];         // LSB part
        result[i + n] = A[i];     // MSB part
    }

    // Convert 8-bit two's complement to signed integer
    int finalResult;
    if(result[2 * n - 1] == 0)
        finalResult = result.to_ulong();
    else
        finalResult = result.to_ulong() - (1 << (2 * n));

    cout << "\nFinal Binary Result: " << result << "\n";
    cout << "Final Decimal Result: " << finalResult << "\n";
}

int main() {
    bitset<n> M, Q;
    cout << "Enter 4-bit binary multiplicand: ";
    cin >> M;
    cout << "Enter 4-bit binary multiplier: ";
    cin >> Q;
    sequential(M, Q);
}
