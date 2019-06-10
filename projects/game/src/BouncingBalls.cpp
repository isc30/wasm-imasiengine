#include "BouncingBalls.hpp"

#include "Components/SpriteComponent.hpp"
#include "Components/TransformComponent.hpp"

#include <Magnum/Shaders/Flat.h>
#include <Magnum/GL/Mesh.h>
#include <Magnum/MeshTools/Compile.h>
#include <Magnum/Trade/MeshData2D.h>
#include <Magnum/Primitives/Circle.h>
#include <Magnum/Math/Vector3.h>
#include <Magnum/Math/Color.h>

#include <random>

using namespace Magnum;
using namespace Math::Literals;

void BouncingBalls::createRandomBall()
{
    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> dist_color(0, 0xff);
    std::uniform_int_distribution<std::mt19937::result_type> dist_speed(1, 50);
    std::uniform_int_distribution<std::mt19937::result_type> dist_mass(1, 15);
    std::uniform_int_distribution<std::mt19937::result_type> dist_position_x(0, _context.viewportSize.x());
    std::uniform_int_distribution<std::mt19937::result_type> dist_position_y(0, _context.viewportSize.y());
    std::uniform_int_distribution<std::mt19937::result_type> dist_direction(0, 2000);

    auto ball1 = _registry.create();

    float r = dist_color(rng) / 255.f;
    float g = dist_color(rng) / 255.f;
    float b = dist_color(rng) / 255.f;

    _registry.assign<SpriteComponent>(ball1,
        SpriteComponent{
            _mesh,
            Color4{Vector3{r, g, b}},
        });

    float mass = (float)dist_mass(rng);

    _registry.assign<TransformComponent>(ball1,
        TransformComponent{
            Vector2{(float)dist_position_x(rng), (float)dist_position_y(rng)},
            Vector2{mass, mass},
        });

    float direction_x = dist_direction(rng) / 1000.f - 1.f;
    float direction_y = dist_direction(rng) / 1000.f - 1.f;
    float speed = dist_speed(rng) / 10.f;

    _registry.assign<PhysicsComponent>(ball1,
        PhysicsComponent{
            Vector2{direction_x, direction_y}.normalized(),
            speed,
            mass
        });
}

BouncingBalls::BouncingBalls(GameContext& context)
    : _context{context}
{
    _mesh = MeshTools::compile(Primitives::circle2DSolid(64));
}

void BouncingBalls::init()
{
    for (int i = 0; i < 500; ++i)
    {
        createRandomBall();
    }
}

void BouncingBalls::tick()
{
    _physicsSystem.tick(_registry);
    _collisionSystem.tick(_registry);
}

void BouncingBalls::render(const Matrix3& projectionMatrix)
{
    _renderSystem.render(projectionMatrix, _registry);
}
