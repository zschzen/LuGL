# --------------------------------------------------------------------
# Policy Configuration
# --------------------------------------------------------------------
# Set OpenGL_GL_PREFERENCE to new "GLVND" even when legacy library exists and
# CMake is <= 3.10 See https://cmake.org/cmake/help/latest/policy/CMP0072.html
# for more information.
if(POLICY CMP0072)
  cmake_policy(SET CMP0072 NEW)
endif()

# --------------------------------------------------------------------
# Platform-Specific Configuration
# --------------------------------------------------------------------
if(${PLATFORM} MATCHES "Desktop")
  set(PLATFORM_CPP "PLATFORM_DESKTOP")

  if(APPLE)
    set(OpenGL_Version "GRAPHICS_API_OPENGL_33")
    find_library(OPENGL_LIBRARY OpenGL)
    list(APPEND LIBS ${OPENGL_LIBRARY})
    link_libraries(${OPENGL_LIBRARY})
    if(NOT CMAKE_SYSTEM_VERSION VERSION_LESS 18.0.0)
      add_definitions(-DGL_SILENCE_DEPRECATION)
      message(
        AUTHOR_WARNING
          "OpenGL has been deprecated in macOS 10.14 (Mojave) and later versions."
      )
    endif()
    list(
      APPEND
      LIBS
      "-framework Cocoa"
      "-framework IOKit"
      "-framework CoreFoundation"
      "-framework CoreVideo"
      "-framework OpenGL"
      "-framework QuartzCore")
  elseif(WIN32)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    find_package(OpenGL QUIET)
    list(APPEND LIBS ${OPENGL_LIBRARY} winmm)
  elseif(UNIX)
    find_library(pthread NAMES pthread)
    find_package(OpenGL QUIET)
    if("${OPENGL_LIBRARIES}" STREQUAL "")
      set(OPENGL_LIBRARIES "GL")
    endif()

    list(APPEND LIBS m pthread ${OPENGL_LIBRARIES} ${OSS_LIBRARY})
  endif()

elseif(${PLATFORM} MATCHES "Web")
  set(PLATFORM_CPP "PLATFORM_WEB")
  set(OpenGL_Version "GRAPHICS_API_OPENGL_ES2")
  set(CMAKE_C_FLAGS
      "${CMAKE_C_FLAGS} --use-port=sdl2 -s ASSERTIONS=1 --profiling")
  set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")

elseif(${PLATFORM} MATCHES "Android")
  set(PLATFORM_CPP "PLATFORM_ANDROID")
  set(OpenGL_Version "GRAPHICS_API_OPENGL_ES2")
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
  list(APPEND LUGL_SOURCE_FILES
       ${ANDROID_NDK}/sources/android/native_app_glue/android_native_app_glue.c)
  include_directories(${ANDROID_NDK}/sources/android/native_app_glue)
  set(CMAKE_SHARED_LINKER_FLAGS
      "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--exclude-libs,libatomic.a -Wl,--build-id -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now -Wl,--warn-shared-textrel -Wl,--fatal-warnings -u ANativeActivity_onCreate -Wl,-undefined,dynamic_lookup"
  )

  find_library(OPENGL_LIBRARY OpenGL)
  list(
    APPEND
    LIBS
    m
    log
    android
    EGL
    GLESv2
    OpenSLES
    atomic
    c)
endif()

# --------------------------------------------------------------------
# Graphics API Configuration
# --------------------------------------------------------------------
if(NOT ${OPENGL_VERSION} MATCHES "Auto")
  set(SUGGESTED_GRAPHICS "${GRAPHICS}")
  if(${OPENGL_VERSION} MATCHES "4.3")
    set(OpenGL_Version "GRAPHICS_API_OPENGL_43")
  elseif(${OPENGL_VERSION} MATCHES "3.3")
    set(OpenGL_Version "GRAPHICS_API_OPENGL_33")
  elseif(${OPENGL_VERSION} MATCHES "2.1")
    set(OpenGL_Version "GRAPHICS_API_OPENGL_21")
  elseif(${OPENGL_VERSION} MATCHES "1.1")
    set(OpenGL_Version "GRAPHICS_API_OPENGL_11")
  elseif(${OPENGL_VERSION} MATCHES "ES 2.0")
    set(OpenGL_Version "GRAPHICS_API_OPENGL_ES2")
  elseif(${OPENGL_VERSION} MATCHES "ES 3.0")
    set(OpenGL_Version "GRAPHICS_API_OPENGL_ES3")
  endif()

  if("${SUGGESTED_GRAPHICS}" AND NOT "${SUGGESTED_GRAPHICS}" STREQUAL
                                 "${GRAPHICS}")
    message(
      WARNING
        "You are overriding the suggested GRAPHICS=${SUGGESTED_GRAPHICS} with ${GRAPHICS}! This may fail"
    )
  endif()
endif()

# Set default graphics API if not already set
if(NOT GRAPHICS)
  set(OpenGL_Version "GRAPHICS_API_OPENGL_33")
endif()

