#pragma once

#include "Components/PhysicsComponent.hpp"
#include "Components/TransformComponent.hpp"

#include "GameContext.hpp"

#include <entt/entt.hpp>

class CollisionSystem
{
    public:

        explicit CollisionSystem(const GameContext& context)
            : _context{context}
        {
        }

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
                    bool collisionHappened = false;

                    if (transform.position.x() < 0)
                    {
                        transform.position.x() = 0;
                        physics.direction.x() *= -1;
                        collisionHappened = true;
                    }

                    if (transform.position.x() > _context.viewportSize.x())
                    {
                        transform.position.x() = (float)_context.viewportSize.x();
                        physics.direction.x() *= -1;
                        collisionHappened = true;
                    }

                    if (transform.position.y() < 0)
                    {
                        transform.position.y() = 0;
                        physics.direction.y() *= -1;
                        collisionHappened = true;
                    }

                    if (transform.position.y() > _context.viewportSize.y())
                    {
                        transform.position.y() = (float)_context.viewportSize.y();
                        physics.direction.y() *= -1;
                        collisionHappened = true;
                    }

                    if (collisionHappened)
                    {
                        //physics.mass += 1;
                        //transform.scale = Vector2{physics.mass, physics.mass};
                    }
                });
        }

    private:

        const GameContext& _context;
};
