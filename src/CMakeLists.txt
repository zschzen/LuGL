set(LUGL_SOURCE_FILES
  ./main.cpp
  ./lu_window.cpp
  ./lu_renderer.cpp
  ./lu_opengl_renderer.cpp
)

set(LUGL_HEADER_FILES
  ../include/lugl/lugl.hpp
  ../include/lugl/lu_renderer.hpp
  ../include/lugl/lu_window.hpp
  ../include/lugl/platform/opengl/lu_opengl_renderer.hpp
)


add_executable(lugl ${LUGL_SOURCE_FILES} ${LUGL_HEADER_FILES})

target_include_directories(lugl
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../include>
  $<INSTALL_INTERFACE:include>
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)


#
# Link dependencies
#
find_package(GLEW REQUIRED)
target_link_libraries(lugl PRIVATE GLEW::GLEW)

find_package(SDL2 CONFIG REQUIRED)
target_link_libraries(lugl
    PRIVATE
    $<TARGET_NAME_IF_EXISTS:SDL2::SDL2main>
    $<IF:$<TARGET_EXISTS:SDL2::SDL2>,SDL2::SDL2,SDL2::SDL2-static>
)

source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}" PREFIX "src" FILES ${LUGL_SOURCE_FILES})
source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}/../include" PREFIX "include" FILES ${LUGL_HEADER_FILES})
