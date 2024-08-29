#ifndef LUGL_PLATFORM_HPP
#define LUGL_PLATFORM_HPP

enum class Platform
{
    mac,
    ios,
    android,
    emscripten,
    windows,
    linux
};

inline Platform
getCurrentPlatform()
{
#if defined( __EMSCRIPTEN__ )
    return Platform::emscripten;
#elif __APPLE__
#    if TARGET_OS_IPHONE
    return Platform::ios;
#    else
    return Platform::mac;
#    endif
#elif __ANDROID__
    return Platform::android;
#elif WIN32
    return Platform::windows;
#elif __linux__
    return Platform::linux;
#endif
}

#endif //LUGL_PLATFORM_HPP
