#pragma once

#include <Magnum/Math/Vector2.h>
#include <Magnum/Magnum.h>

struct PhysicsComponent
{
    Magnum::Vector2 direction;
    float speed;
    float mass;

    explicit PhysicsComponent(
        Magnum::Vector2 direction,
        float speed,
        float mass)

        : direction{direction}
        , speed{speed}
        , mass{mass}
    {
    }
};