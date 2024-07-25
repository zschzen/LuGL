#include "lugl/lugl.hpp"

int
main()
{
    luWindow window( "lugl - basic window", 800, 450, WINDOW_DEFAULT );

    // Initialize the renderer
    luOpenGLRenderer renderer;

    renderer.init();
    // Main loop
    while( !window.shouldClose() )
        {
            // Begin rendering
            renderer.beginRender();
            // End rendering
            renderer.endRender();
        }

    return 0;
}
