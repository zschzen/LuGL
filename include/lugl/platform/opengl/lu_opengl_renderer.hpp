#ifndef LUGL_OPENGL_RENDERER_HPP
#define LUGL_OPENGL_RENDERER_HPP

#include "lugl/lu_renderer.hpp"

class luOpenGLRenderer : public luRenderer
{
public:
    void init() override;
    void beginRender() override;
    void endRender() override;

    void clearScreen();
};

#endif /** LUGL_OPENGL_RENDERER_HPP */
