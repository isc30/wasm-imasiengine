#pragma once

#include "Components/PhysicsComponent.hpp"
#include "Components/TransformComponent.hpp"

#include <entt/entt.hpp>

class PhysicsSystem
{
    public:
        void tick(
            entt::registry& registry)
        {
            registry
                .view<PhysicsComponent, TransformComponent>()
                .each([&](
                    const auto& entity,
                    PhysicsComponent& physics,
                    TransformComponent& transform)
                {
                    transform.position += physics.direction * physics.speed;
                });
        }
};
