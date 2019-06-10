#pragma once

#include <Magnum/GL/Mesh.h>
#include <Magnum/Math/Color.h>
#include <Magnum/Magnum.h>

struct SpriteComponent
{
    std::reference_wrapper<Magnum::GL::Mesh> mesh;
    Magnum::Color4 color;

    explicit SpriteComponent(
        Magnum::GL::Mesh& mesh,
        Magnum::Color4 color)

        : mesh{mesh}
        , color{color}
    {
    }
};
