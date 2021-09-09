#include <iostream>
int main()
{
    auto test = [&](int numer)
    {
        return numer * 2;
    };

    int answer = test(10);
}
