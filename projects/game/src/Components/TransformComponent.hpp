#pragma once

#include <Magnum/Math/Vector2.h>
#include <Magnum/Magnum.h>

struct TransformComponent
{
    Magnum::Vector2 position;
    Magnum::Vector2 scale;

    explicit TransformComponent(
        Magnum::Vector2 position,
        Magnum::Vector2 scale)

        : position{position}
        , scale{scale}
    {
    }
};
