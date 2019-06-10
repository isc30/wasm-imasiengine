#pragma once

#include "GameContext.hpp"

#include "Systems/SpriteRenderSystem.hpp"
#include "Systems/PhysicsSystem.hpp"
#include "Systems/CollisionSystem.hpp"

#include <Magnum/GL/Mesh.h>

#include <entt/entt.hpp>

class BouncingBalls
{
    public:
        explicit BouncingBalls(GameContext& context);
        void init();
        void tick();
        void render(const Magnum::Matrix3& projectionMatrix);

    private:
        void createRandomBall();

        GameContext& _context;
        Magnum::GL::Mesh _mesh;

        entt::registry _registry{};

        SpriteRenderSystem _renderSystem{};
        PhysicsSystem _physicsSystem{};
        CollisionSystem _collisionSystem{_context};
};
