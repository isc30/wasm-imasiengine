#include <gtest/gtest.h>

#include "Calculator.hpp"

TEST(Calculator, Sum_ReturnsProperResult)
{
    Calculator calculator;
    int result = calculator.Sum(1, 2);

    EXPECT_EQ(3, result);
}
