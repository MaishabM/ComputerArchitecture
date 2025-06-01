#include <bits/stdc++.h>
using namespace std;
const int n = 4;

bitset<n> toBitset(int num) {
    if (num > 0)
        return bitset<n>(num);
    return bitset<n>((1 << n) + num);
}

int toSigned(const bitset<n>& b) {
    if (b[n - 1] == 0)
        return b.to_ulong();
    return b.to_ulong() - (1 << n);
}

void rdivision(int dividend, int divisor) {
    // Store sign of quotient and remainder
    bool negQuotient = (dividend < 0) ^ (divisor < 0);
    bool negRemainder = (dividend < 0);

    //absolute values
    dividend = abs(dividend);
    divisor = abs(divisor);

    bitset<n> Q = toBitset(dividend);
    bitset<n> M = toBitset(divisor);
    bitset<n + 1> A;

    cout << "Initial: ";
    cout << "A: " << A << " Q: " << Q << " M: " << M << endl << endl;

    for (int i = 0; i < n; ++i) {
        // Left shift A and Q
        A = A << 1;
        A[0] = Q[n - 1];
        Q = Q << 1;

        cout << "Step " << i + 1 << " - After shift: ";
        cout << "A: " << A << " Q: " << Q << endl;

        // A = A - M
        int temp = A.to_ulong() - M.to_ulong();
        A = bitset<n + 1>(temp);

        cout << "Step " << i + 1 << " - After subtraction: ";
        cout << "A: " << A << " Q: " << Q << endl;

        // If A < 0 → restore A, set Q[0] = 0
        if (A[n] == 1) {
            A = bitset<n + 1>(temp + M.to_ulong());  // Restore
            Q[0] = 0;
        }
        else {
            Q[0] = 1;
        }

        cout << "Step " << i + 1 << " - Final: ";
        cout << "A: " << A << " Q: " << Q << endl << endl;
    }

    int quotient = Q.to_ulong();
    int remainder = A.to_ulong();

    if (negQuotient) quotient = -quotient;
    if (negRemainder) remainder = -remainder;

    cout << "Final Quotient (Binary): " << Q << endl;
    cout << "Final Quotient (Decimal): " << quotient << endl;
    cout << "Final Remainder (Binary): " << A << endl;
    cout << "Final Remainder (Decimal): " << remainder << endl;
}

int main() {
    int dividend, divisor;
    cout << "Enter dividend: ";
    cin >> dividend;
    cout << "Enter divisor: ";
    cin >> divisor;

    rdivision(dividend, divisor);
}
