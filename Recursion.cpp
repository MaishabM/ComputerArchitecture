#include<bits/stdc++.h>
using namespace std;
int fact(int n) {
    if(n==1)
       return 1;
    else
       return n*fact(n-1);
}
int main() {
    int x;
    cin >> x;

    cout << "The factorial of " << x << " is: " << fact(x) << endl;
}