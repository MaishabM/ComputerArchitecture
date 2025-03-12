#include <bits/stdc++.h>
using namespace std;

const int BITS = 4; // 4-bit division

// Function to add two 4-bit binary numbers
bitset<BITS> add(bitset<BITS> A, bitset<BITS> B) {
    bitset<BITS> sum;
    bool carry = 0;

    for (int i = 0; i < BITS; i++) {
        sum[i] = A[i] ^ B[i] ^ carry;
        carry = (A[i] & B[i]) | (carry & (A[i] ^ B[i]));
    }
    return sum;
}

// Function to compute two's complement (negative representation)
bitset<BITS> twosComplement(bitset<BITS> num) {
    return add(~num, bitset<BITS>(1)); // Invert and add 1
}

// Function to perform Booth's Division Algorithm
void boothDivision(bitset<BITS> dividend, bitset<BITS> divisor) {
    bitset<BITS> A(0);      // Accumulator (initialized to 0)
    bitset<BITS> Q = dividend; // Q = Dividend
    bitset<BITS> M = divisor;  // M = Divisor
    bitset<BITS> negM = twosComplement(M); // -M (Two's complement of M)

    cout << "\nInitial Values:";
    cout << "\nA: " << A << "  Q: " << Q << "  M: " << M << "\n";

    for (int i = 0; i < BITS; i++) {
        // Step 1: Left shift A and Q together
        bool A_msb = A[BITS - 1]; // Store MSB of A
        A <<= 1;
        A[0] = Q[BITS - 1]; // Shift Q's MSB into A's LSB
        Q <<= 1;

        cout << "\nStep " << i + 1 << ":";
        cout << "\nAfter Shift  -  A: " << A << "  Q: " << Q;

        // Step 2: A = A - M (i.e., A = A + (-M))
        A = add(A, negM);
        cout << "\nAfter Subtracting M  -  A: " << A;

        // Step 3: If A is negative, restore A and set Q0 = 0
        if (A[BITS - 1] == 1) {
            A = add(A, M); // Restore A (A = A + M)
            cout << "\nRestored A  -  A: " << A;
            Q[0] = 0;
        } else {
            Q[0] = 1; // Set LSB of Q
        }

        cout << "\nUpdated Q  -  Q: " << Q << "\n";
    }

    // Final quotient and remainder
    cout << "\nFinal Result:";
    cout << "\nQuotient (Q): " << Q.to_ulong() << " (" << Q << ")";
    cout << "\nRemainder (A): " << A.to_ulong() << " (" << A << ")\n";
}

// Main function
int main() {
    int dividend, divisor;
    
    // Take input for dividend and divisor (4-bit signed range: -8 to 7)
    cout << "Enter Dividend (-8 to 7): ";
    cin >> dividend;
    cout << "Enter Divisor (-8 to 7): ";
    cin >> divisor;

    if (dividend < -8 || dividend > 7 || divisor < -8 || divisor > 7) {
        cout << "Error: Values out of range! Use 4-bit numbers only.\n";
        return 1;
    }

    if (divisor == 0) {
        cout << "Error: Division by zero is not allowed!\n";
        return 1;
    }

    // Convert input to 4-bit binary representation
    bitset<BITS> binDividend(dividend);
    bitset<BITS> binDivisor(divisor);

    // Perform Booth's Division
    boothDivision(binDividend, binDivisor);

    return 0;
}
