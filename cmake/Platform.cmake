# Helper macro to define compile definitions
macro(define_platform_definitions target)

  # --------------------------------------------------------------------
  # Compiler Definitions
  # --------------------------------------------------------------------
  if(MSVC)
    target_compile_definitions(${target} PRIVATE LUGL_COMPILER_MSVC=1
                                                 LUGL_COMPILER_NAME="MSVC")
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    target_compile_definitions(${target} PRIVATE LUGL_COMPILER_CLANG=1
                                                 LUGL_COMPILER_NAME="Clang")
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_definitions(${target} PRIVATE LUGL_COMPILER_GCC=1
                                                 LUGL_COMPILER_NAME="GCC")
  else()
    target_compile_definitions(
      ${target} PRIVATE LUGL_COMPILER_OTHER=1
                        LUGL_COMPILER_NAME=${CMAKE_CXX_COMPILER_ID})
  endif()

  # --------------------------------------------------------------------
  # Platform Definitions
  # --------------------------------------------------------------------
  if(WIN32)
    target_compile_definitions(${target} PRIVATE LUGL_PLATFORM_WINDOWS=1
                                                 LUGL_PLATFORM_NAME="windows")
  elseif(ANDROID)
    target_compile_definitions(${target} PRIVATE LUGL_PLATFORM_ANDROID=1
                                                 LUGL_PLATFORM_NAME="android")
  elseif(EMSCRIPTEN)
    target_compile_definitions(${target} PRIVATE LUGL_PLATFORM_EMSCRIPTEN=1
                                                 LUGL_PLATFORM_NAME="html5")
  elseif(UNIX AND NOT APPLE)
    target_compile_definitions(${target} PRIVATE LUGL_PLATFORM_LINUX=1
                                                 LUGL_PLATFORM_NAME="linux")
  elseif(APPLE)
    if(IOS)
      target_compile_definitions(${target} PRIVATE LUGL_PLATFORM_IOS=1
                                                   LUGL_PLATFORM_NAME="ios")
    else()
      target_compile_definitions(${target} PRIVATE LUGL_PLATFORM_OSX=1
                                                   LUGL_PLATFORM_NAME="osx")
    endif()
  else()
    message(FATAL_ERROR "Unsupported platform")
  endif()

  # --------------------------------------------------------------------
  # Architecture Definitions
  # --------------------------------------------------------------------
  # http://sourceforge.net/apps/mediawiki/predef/index.php?title=Architectures
  if(CMAKE_SYSTEM_PROCESSOR MATCHES "arm*")
    target_compile_definitions(
      ${target} PRIVATE LUGL_CPU_ARM=1 LUGL_CACHE_LINE_SIZE=64
                        LUGL_CPU_NAME="ARM")
  elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "mips*")
    target_compile_definitions(
      ${target} PRIVATE LUGL_CPU_MIPS=1 LUGL_CACHE_LINE_SIZE=64
                        LUGL_CPU_NAME="MIPS")
  elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "ppc*")
    set(LUGL_CPU_PPC TRUE)
    target_compile_definitions(
      ${target} PRIVATE LUGL_CPU_PPC=1 LUGL_CACHE_LINE_SIZE=128
                        LUGL_CPU_NAME="PPC")
  elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86*|i386|i686|x86_64")
    target_compile_definitions(
      ${target} PRIVATE LUGL_CPU_X86=1 LUGL_CACHE_LINE_SIZE=64
                        LUGL_CPU_NAME="x86")
  else()
    target_compile_definitions(
      ${target} PRIVATE LUGL_CPU_JIT=1 LUGL_CACHE_LINE_SIZE=64
                        LUGL_CPU_NAME=${CMAKE_SYSTEM_PROCESSOR})
  endif()

  # --------------------------------------------------------------------
  # Bitness Definitions
  # --------------------------------------------------------------------
  if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    target_compile_definitions(${target} PRIVATE LUGL_ARCH_64BIT=1
                                                 LUGL_ARCH_NAME="64-bit")
  else()
    target_compile_definitions(${target} PRIVATE LUGL_ARCH_32BIT=1
                                                 LUGL_ARCH_NAME="32-bit")
  endif()

  # --------------------------------------------------------------------
  # Endianness Definitions
  # --------------------------------------------------------------------
  if(LUGL_CPU_PPC)
    target_compile_definitions(${target} PRIVATE LUGL_CPU_ENDIAN_BIG=1)
  else()
    target_compile_definitions(${target} PRIVATE LUGL_CPU_ENDIAN_LITTLE=1)
  endif()

  # --------------------------------------------------------------------
  # Display Info
  # -------------------------------------------------------------------
  message(STATUS)
  message(STATUS "Compiler: ${CMAKE_CXX_COMPILER_ID}")
  message(STATUS "Platform: ${CMAKE_SYSTEM_NAME}")
  message(STATUS "Architecture: ${CMAKE_SYSTEM_PROCESSOR}")

  if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "Bitness: 64-bit")
  else()
    message(STATUS "Bitness: 32-bit")
  endif()

  if(LUGL_CPU_PPC)
    message(STATUS "Endianness: Big Endian")
  else()
    message(STATUS "Endianness: Little Endian")
  endif()

  message(STATUS)
endmacro()
