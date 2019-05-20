#include <iostream>
#include "Calculator.hpp"

int main()
{
    std::cout << "Hello World!" << std::endl;

    Calculator calculator;
    int result = calculator.Sum(34, 453);

    std::cout << "Result: " << result << std::endl;

    return 0;
}
