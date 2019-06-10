#pragma once

#include <Magnum/Math/Vector2.h>
#include <Magnum/Magnum.h>

struct GameContext
{
    Magnum::Vector2i mousePosition;
    Magnum::Vector2i viewportSize;
};
