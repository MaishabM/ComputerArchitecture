#include<bits/stdc++.h>
using namespace std;

void addBinary(vector<int>& A, const vector<int>& M) {
    int carry = 0;
    for (int i = A.size() - 1; i >= 0; i--) {
        int sum = A[i] + M[i] + carry;
        A[i] = sum % 2;
        carry = sum / 2;
    }
}

void twoComplement(vector<int>& M) {
    vector<int> one(M.size(), 0);
    one.back() = 1;
    
    for (int i = 0; i < M.size(); i++) {
        M[i] = 1 - M[i]; // Bitwise complement
    }
    
    addBinary(M, one); // Add 1 to get two's complement
}

void arithmeticRightShift(vector<int>& A, vector<int>& Q, int& Q_1) {
    Q_1 = Q.back();
    for (int i = Q.size() - 1; i > 0; i--) {
        Q[i] = Q[i - 1];
    }
    Q[0] = A.back();
    
    for (int i = A.size() - 1; i > 0; i--) {
        A[i] = A[i - 1];
    }
}

void boothMultiplication(int multiplicand, int multiplier) {
    const int n = 8; // Assume 8-bit multiplication
    vector<int> M(n, 0), Q(n, 0), A(n, 0);
    int Q_1 = 0;

    // Convert to binary
    for (int i = n - 1, num = multiplicand; num && i >= 0; i--, num /= 2)
        M[i] = num % 2;
    
    for (int i = n - 1, num = multiplier; num && i >= 0; i--, num /= 2)
        Q[i] = num % 2;
    
    vector<int> M_neg = M;
    twoComplement(M_neg);

    cout << "Initial values:\n";
    cout << "A: ";
    for (int bit : A) cout << bit;
    cout << " | Q: ";
    for (int bit : Q) cout << bit;
    cout << " | Q-1: " << Q_1 << endl;

    for (int count = 0; count < n; count++) {
        int Q0 = Q.back();
        if (Q0 == 1 && Q_1 == 0)
            addBinary(A, M_neg); // A = A - M
        else if (Q0 == 0 && Q_1 == 1)
            addBinary(A, M); // A = A + M

        arithmeticRightShift(A, Q, Q_1);

        cout << "Step " << count + 1 << ":\n";
        cout << "A: ";
        for (int bit : A) cout << bit;
        cout << " | Q: ";
        for (int bit : Q) cout << bit;
        cout << " | Q-1: " << Q_1 << endl;
    }

    cout << "\nFinal Product: ";
    for (int bit : A) cout << bit;
    for (int bit : Q) cout << bit;
    cout << endl;
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
