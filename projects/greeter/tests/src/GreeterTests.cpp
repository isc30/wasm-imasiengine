#include <iostream>
#include <gtest/gtest.h>

#include "Greeter.hpp"

TEST(Greeter, given_Ivan_when_Greet_is_called_returns_Sir)
{
    Greeter greeter;
    std::string result = greeter.Greet("Ivan");

    EXPECT_EQ(result, "Sir");
}

TEST(Greeter, given_Uxue_when_Greet_is_called_returns_Lady)
{
    Greeter greeter;
    std::string result = greeter.Greet("Uxue");

    EXPECT_EQ(result, "Lady");
}

TEST(Greeter, given_any_name_when_Greet_is_called_returns_Hi)
{
    Greeter greeter;
    std::string result = greeter.Greet("Paco");

    EXPECT_EQ(result, "Hi");
}
