# --------------------------------------------------------------------
# spdlog
# --------------------------------------------------------------------
if(NOT EMSCRIPTEN)
  find_package(spdlog CONFIG REQUIRED)
  list(APPEND LIBS spdlog::spdlog_header_only)
endif()
