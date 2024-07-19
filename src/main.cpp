#include "lugl/lugl.hpp"

int
main()
{
    // Create a window with the title "lugl example - basic window", dimensions
    // 800x450, and make it resizable and maximized
    luWindow window( "lugl - basic window", 800, 450, WINDOW_DEFAULT );
    luOpenGLRenderer renderer;

    // Initialize the renderer
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

