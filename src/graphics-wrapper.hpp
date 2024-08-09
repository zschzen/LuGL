#ifndef LUGL_GRAPHICS_WRAPPER_HPP
#define LUGL_GRAPHICS_WRAPPER_HPP

#if defined( __EMSCRIPTEN__ )
#    include <GLES2/gl2.h>
#elif __APPLE__
#    ifndef GL_SILENCE_DEPRECATION
#        define GL_SILENCE_DEPRECATION
#    endif
#    include "TargetConditionals.h"
#    if TARGET_OS_IPHONE
#        include <OpenGLES/ES2/gl.h>
#    else
#        include <OpenGL/gl3.h>
#    endif
#elif __ANDROID__
#    include <GLES2/gl2.h>
#elif WIN32
#    define GLEW_STATIC
#    include <GL/glew.h>
#endif

#endif /** LUGL_GRAPHICS_WRAPPER_HPP */
