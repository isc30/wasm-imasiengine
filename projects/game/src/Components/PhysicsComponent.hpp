#pragma once

#include <Magnum/Math/Vector2.h>
#include <Magnum/Magnum.h>

struct PhysicsComponent
{
    Magnum::Vector2 direction;
    float speed;

    explicit PhysicsComponent(
        Magnum::Vector2 direction,
        float speed)

        : direction{direction}
        , speed{speed}
    {
    }
};