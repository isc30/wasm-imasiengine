#include "Greeter.hpp"

std::string Greeter::Greet(std::string_view name) const noexcept
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
