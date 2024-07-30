# --------------------------------------------------------------------
# GLEW
# --------------------------------------------------------------------
if(NOT EMSCRIPTEN)
  find_package(GLEW REQUIRED)
  list(APPEND LIBS GLEW::GLEW)
endif()
