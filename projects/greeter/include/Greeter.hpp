#include <iostream>
#include <string_view>

class Greeter
{
public:
    std::string Greet(std::string_view name) const noexcept;
};
