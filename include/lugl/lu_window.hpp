#ifndef LUGL_WINDOW_HPP
#define LUGL_WINDOW_HPP

#include <SDL2/SDL.h>
#include <string>

enum WindowFlags
{
    WINDOW_DEFAULT   = 0,
    WINDOW_RESIZABLE = 1 << 0,
    WINDOW_MAXIMIZED = 1 << 1,
};

class luWindow
{
public:
    luWindow( const std::string & title, int width, int height, int flags = 0 );
    ~luWindow();

    bool shouldClose();

private:
    SDL_Window *  window;
    SDL_GLContext glContext;

    u_int8_t shouldCloseFlag : 1 { false };

    void pollEvents();
};

#endif /** LUGL_WINDOW_HPP */
