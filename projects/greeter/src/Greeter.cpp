#include "Greeter.hpp"

std::string Greeter::Greet(const std::string& name) const noexcept
{
    if (name == "Ivan")
    {
        return "Sir";
    }

    if (name == "Uxue")
    {
        return "Lady";
    }

    return "Hi";
}
