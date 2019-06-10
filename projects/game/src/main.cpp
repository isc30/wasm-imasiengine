#include "BouncingBalls.hpp"

#include <Magnum/Platform/Sdl2Application.h>

#include <Magnum/GL/DefaultFramebuffer.h>
#include <Magnum/GL/Buffer.h>
#include <Magnum/GL/Mesh.h>
#include <Magnum/Shaders/Flat.h>
#include <Magnum/MeshTools/Compile.h>
#include <Magnum/Trade/MeshData2D.h>
#include <Magnum/Primitives/Circle.h>
#include <Magnum/Primitives/Square.h>

using namespace Magnum;
using namespace Math::Literals;

class MyApplication: public Platform::Application
{
    public:
        explicit MyApplication(const Arguments& arguments);

    private:
        void viewportEvent(ViewportEvent& event) override;
        void mouseMoveEvent(MouseMoveEvent& event) override;
        void drawEvent() override;

        Vector2i mouseScreenSpacePosition() const;

        Matrix3 _cameraProjection;
        Vector2i _mousePosition;

        GameContext _context;
        BouncingBalls _bouncingBalls{_context};
};

MyApplication::MyApplication(const Arguments& arguments)
    : Platform::Application{arguments}
{
    _context.viewportSize = framebufferSize();
    _cameraProjection = Matrix3::projection({static_cast<Vector2>(_context.viewportSize)});

    _bouncingBalls.init();

    #ifndef CORRADE_TARGET_EMSCRIPTEN
        setSwapInterval(1);
    #endif

    #if !defined(CORRADE_TARGET_EMSCRIPTEN) && !defined(CORRADE_TARGET_ANDROID)
        setMinimalLoopPeriod(16);
    #endif
}

void MyApplication::mouseMoveEvent(MouseMoveEvent& event)
{
    _mousePosition = event.position();
}

void MyApplication::viewportEvent(ViewportEvent& event)
{
    _context.viewportSize = event.framebufferSize();
    GL::defaultFramebuffer.setViewport({{}, _context.viewportSize});
    _cameraProjection = Matrix3::projection({static_cast<Vector2>(_context.viewportSize)});
}

void MyApplication::drawEvent()
{
    _context.mousePosition = mouseScreenSpacePosition();
    _bouncingBalls.tick();

    GL::defaultFramebuffer.clear(GL::FramebufferClear::Color);
    _bouncingBalls.render(_cameraProjection);
    swapBuffers();
    redraw();
}

Vector2i MyApplication::mouseScreenSpacePosition() const
{
    return Vector2i
    {
        _mousePosition.x(),
        framebufferSize().y() - _mousePosition.y()
    };
}

MAGNUM_APPLICATION_MAIN(MyApplication)
