#include "SpriteRenderSystem.hpp"

#include "Components/SpriteComponent.hpp"
#include "Components/TransformComponent.hpp"

using namespace Magnum;

void SpriteRenderSystem::render(
    const Matrix3& projectionMatrix,
    entt::registry& registry)
{
    registry
        .view<SpriteComponent, const TransformComponent>()
        .each([&](
            const auto& entity,
            SpriteComponent& sprite,
            const TransformComponent& transform)
        {
            Matrix3 translation = Matrix3::translation(transform.position);
            Matrix3 scale = Matrix3::scaling(transform.scale);
            Matrix3 modelMatrix = translation * scale;

            Matrix3 screenSpace = Matrix3::translation({-1, -1});

            _shader
                .setTransformationProjectionMatrix(screenSpace * projectionMatrix * modelMatrix)
                .setColor(sprite.color);

            sprite.mesh.get().draw(_shader);
        });
}
