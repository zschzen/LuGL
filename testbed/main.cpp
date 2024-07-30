#include "lugl/lugl.hpp"

#if defined( PLATFORM_WEB )
#include <emscripten/emscripten.h>
#endif

luWindow *         window;
luOpenGLRenderer * renderer;

void
main_loop()
{
#if defined( PLATFORM_WEB )
    if( window->shouldClose() )
        {
            emscripten_cancel_main_loop();
            return;
        }
#endif

    // Begin rendering
    renderer->beginRender();
    // End rendering
    renderer->endRender();
}

int
main()
{
    window = new luWindow( "lugl - basic window", 800, 450, WINDOW_DEFAULT );

    // Initialize the renderer
    renderer = new luOpenGLRenderer();
    renderer->init();

#if defined( PLATFORM_WEB )
    emscripten_set_main_loop( main_loop, 0, 1 );
#else
    // Main loop
    while( !window->shouldClose() )
        {
            main_loop();
        }
#endif

    delete window;
    delete renderer;

    return 0;
}
