#ifndef LUGL_RENDERER_HPP
#define LUGL_RENDERER_HPP

class luRenderer
{
public:
    virtual void init()        = 0;
    virtual void beginRender() = 0;
    virtual void endRender()   = 0;
    virtual ~luRenderer()      = default;
};

#endif /** LUGL_RENDERER_HPP */
