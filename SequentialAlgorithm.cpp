#include <iostream>
#include <bitset>
using namespace std;

const int n = 8; // Bit-width for binary representation

// Function to convert signed int to n-bit two's complement bitset
bitset<n> toBitset(int num) {
    if (num >= 0) return bitset<n>(num);
    return bitset<n>((1 << n) + num); // Two's complement
}

// Function to convert n-bit two's complement bitset to signed int
int toSigned(const bitset<n>& bits) {
    if (bits[n - 1] == 0) return bits.to_ulong(); // Positive
    return bits.to_ulong() - (1 << n);            // Negative
}

void sequentialMultiplication(int multiplicand, int multiplier) {
    bitset<n> M = toBitset(multiplicand); // Multiplicand
    bitset<n> Q = toBitset(multiplier);   // Multiplier
    bitset<n> A;                          // Accumulator initialized to 0

    cout << "Initial State: ";
    cout << "M: " << M << " Q: " << Q << " A: " << A << "\n\n";

    for (int i = 0; i < n; ++i) {
        if (Q[0] == 1) {
            // A = A + M
            int sum = toSigned(A) + toSigned(M);
            A = toBitset(sum);
        }

        // Right shift [A Q] logically
        bool A_msb = A[n - 1];
        bool Q0 = Q[0];

        Q >>= 1;
        Q[n - 1] = A[0];

        A >>= 1;
        A[n - 1] = A_msb;

        cout << "Step " << i + 1 << ": ";
        cout << "M: " << M << " Q: " << Q << " A: " << A << "\n\n";
    }

    // Combine A and Q for final result
    bitset<2 * n> result;
    for (int i = 0; i < n; ++i) {
        result[i] = Q[i];
        result[i + n] = A[i];
    }

    int finalProduct = (int16_t)result.to_ulong(); // Cast to signed 16-bit int
    cout << "Final Binary Result: " << result << "\n";
    cout << "Final Decimal Result: " << finalProduct << "\n";
}

int main() {
    int multiplicand, multiplier;
    cout << "Enter multiplicand: ";
    cin >> multiplicand;
    cout << "Enter multiplier: ";
    cin >> multiplier;

    sequentialMultiplication(multiplicand, multiplier);
    return 0;
}