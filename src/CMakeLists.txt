#--------------------------------------------------------------------
# Source and Header Files
#--------------------------------------------------------------------
set(LUGL_SOURCE_FILES
  ./lu_window.cpp
  ./lu_renderer.cpp
  ./lu_log.cpp
  ./lu_opengl_renderer.cpp
)

set(LUGL_HEADER_FILES
  ../include/lugl/platform/opengl/lu_opengl_renderer.hpp
  ../include/lugl/lu_math.hpp
  ../include/lugl/lu_renderer.hpp
  ../include/lugl/lu_settings.hpp
  ../include/lugl/lu_types.hpp
  ../include/lugl/lu_window.hpp
  ../include/lugl/luapi.hpp
  ../include/lugl/lugl.hpp
)

set(LUGL_PRIVATE_HEADER_FILES
  ./base.hpp
  ./graphics-wrapper.hpp
  ./lu_log.hpp
)

list(APPEND LUGL_INCLUDE_DIR)

#--------------------------------------------------------------------
# Include External Configuration Files
#--------------------------------------------------------------------
if(GRAPHICS_API STREQUAL "Auto" OR GRAPHICS_API STREQUAL "OpenGL")
  include(OpenGLConfigurations)
endif()

# if(GRAPHICS_API STREQUAL "Auto" OR GRAPHICS_API STREQUAL "Vulkan")
#   include(VulkanConfigurations)
# endif()

include(Import/SDL)
include(Import/GLEW)
include(Import/GLM)
include(Import/fmt)
include(Import/spdlog)

#--------------------------------------------------------------------
# Library Setup
#--------------------------------------------------------------------
add_library(lugl ${LUGL_SOURCE_FILES} ${LUGL_HEADER_FILES}
                 ${LUGL_PRIVATE_HEADER_FILES})

include(Platform)
define_platform_definitions(lugl)

target_compile_definitions(lugl PUBLIC "${PLATFORM_CPP}")
target_compile_definitions(lugl PUBLIC "${OpenGL_Version}")

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  target_compile_definitions(lugl PUBLIC LU_DEBUG)
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
  target_compile_definitions(lugl PUBLIC LU_RELEASE)
endif()

# Link libraries
list(REMOVE_DUPLICATES LIBS)
target_link_libraries(lugl PUBLIC ${LIBS})

#--------------------------------------------------------------------
# Include Directories
#--------------------------------------------------------------------
list(REMOVE_DUPLICATES LUGL_INCLUDE_DIR)
target_include_directories(lugl
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    LUGL_INCLUDE_DIR
)

#--------------------------------------------------------------------
# Target Properties
#--------------------------------------------------------------------
set_target_properties(lugl PROPERTIES
  CXX_STANDARD 20
  CXX_STANDARD_REQUIRED YES
  CXX_EXTENSIONS NO
  VERSION ${PROJECT_VERSION}
  SOVERSION ${PROJECT_VERSION_MAJOR}
)

#--------------------------------------------------------------------
# Shared Library Configuration
#--------------------------------------------------------------------
if(BUILD_SHARED_LIBS)
  message(STATUS "Building shared library")
  target_compile_definitions(lugl PUBLIC LU_SHARED)
endif()

#--------------------------------------------------------------------
# Source Groups
#--------------------------------------------------------------------
source_group(
  TREE "${CMAKE_CURRENT_SOURCE_DIR}"
  PREFIX "src"
  FILES ${LUGL_SOURCE_FILES} ${LUGL_PRIVATE_HEADER_FILES}
)
source_group(
  TREE "${CMAKE_CURRENT_SOURCE_DIR}/../include"
  PREFIX "include"
  FILES ${LUGL_HEADER_FILES}
)

#--------------------------------------------------------------------
# Install Configuration
#--------------------------------------------------------------------
include(Install)

#--------------------------------------------------------------------
# Build Information Messages
#--------------------------------------------------------------------
message(STATUS "Target System: ${CMAKE_SYSTEM_NAME}")

# Print the flags for the user
if(DEFINED CMAKE_BUILD_TYPE)
  message(STATUS "Generated build type: ${CMAKE_BUILD_TYPE}")
else()
  message(STATUS "Generated config types: ${CMAKE_CONFIGURATION_TYPES}")
endif()

message(STATUS "Compiling with the flags:")
message(STATUS "\tPLATFORM=${PLATFORM_CPP}")
message(STATUS "\tGRAPHICS_API=${GRAPHICS_API}")
message(STATUS "\tOpenGL_Version=${OpenGL_Version}")
# message(STATUS "\tVulkan_VERSION=${Vulkan_VERSION}")
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  message(STATUS "\tDefinition=LU_DEBUG")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
  message(STATUS "\tDefinition=LU_RELEASE")
endif()
