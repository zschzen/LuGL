#include "lugl/lu_window.hpp"
#include <SDL.h>

luWindow::luWindow( const std::string & title, int width, int height,
                    int flags )
{
    SDL_Init( SDL_INIT_VIDEO | SDL_INIT_EVENTS );

    Uint32 sdl_flags = SDL_WINDOW_OPENGL;
    if( flags & WINDOW_RESIZABLE )
        {
            sdl_flags |= SDL_WINDOW_RESIZABLE;
        }
    if( flags & WINDOW_MAXIMIZED )
        {
            sdl_flags |= SDL_WINDOW_MAXIMIZED;
        }

    window =
        SDL_CreateWindow( title.c_str(), SDL_WINDOWPOS_CENTERED,
                          SDL_WINDOWPOS_CENTERED, width, height, sdl_flags );
    glContext = SDL_GL_CreateContext( window );

    SDL_GL_SetSwapInterval( 1 );
}

luWindow::~luWindow()
{
    SDL_GL_DeleteContext( glContext );
    SDL_DestroyWindow( window );
    SDL_Quit();
}

bool
luWindow::pollEvents()
{
    SDL_Event event;
    while( SDL_PollEvent( &event ) )
        {
            switch( event.type )
                {
                case SDL_QUIT:
                    return true;

                case SDL_KEYDOWN:
                    if( event.key.keysym.sym == SDLK_ESCAPE )
                        {
                            return true;
                        }
                    break;
                default:
                    break;
                }
        }

    return false;
}

bool
luWindow::shouldClose()
{
    return pollEvents();
}
