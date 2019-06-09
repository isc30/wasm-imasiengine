#include <Magnum/GL/DefaultFramebuffer.h>
#include <Magnum/Platform/Sdl2Application.h>

#include <Magnum/GL/Buffer.h>
#include <Magnum/GL/DefaultFramebuffer.h>
#include <Magnum/GL/Mesh.h>
#include <Magnum/Platform/Sdl2Application.h>
#include <Magnum/Shaders/VertexColor.h>

using namespace Magnum;

class MyApplication: public Platform::Application
{
    public:
        explicit MyApplication(const Arguments& arguments);

    private:
        void drawEvent() override;

        GL::Mesh _mesh;
        Shaders::VertexColor2D _shader;
};

MyApplication::MyApplication(const Arguments& arguments)
    : Platform::Application{arguments}
{
    using namespace Math::Literals;

    struct TriangleVertex
    {
        Vector2 position;
        Color3 color;
    };

    const TriangleVertex data[]
    {
        {{-0.5f, -0.5f}, 0xff0000_rgbf},    /* Left vertex, red color */
        {{ 0.5f, -0.5f}, 0x00ff00_rgbf},    /* Right vertex, green color */
        {{ 0.0f,  0.5f}, 0x0000ff_rgbf}     /* Top vertex, blue color */
    };

    GL::Buffer buffer;
    buffer.setData(data);

    _mesh.setCount(3)
         .addVertexBuffer(std::move(buffer), 0,
            Shaders::VertexColor2D::Position{},
            Shaders::VertexColor2D::Color3{});
}

void MyApplication::drawEvent()
{
    GL::defaultFramebuffer.clear(GL::FramebufferClear::Color);

    _mesh.draw(_shader);

    swapBuffers();
}

MAGNUM_APPLICATION_MAIN(MyApplication)
