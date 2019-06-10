#pragma once

#include <entt/entt.hpp>
#include <Magnum/Shaders/Flat.h>
#include <Magnum/Math/Matrix3.h>
#include <Magnum/Magnum.h>

#include <chrono>

class SpriteRenderSystem
{
    public:
        void render(
            float deltaTick,
            const Magnum::Matrix3& projectionMatrix,
            entt::registry& registry);

    private:
        Magnum::Shaders::Flat2D _shader{};
};
