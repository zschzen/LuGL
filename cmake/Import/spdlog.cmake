# --------------------------------------------------------------------
# spdlog
# --------------------------------------------------------------------
if(NOT EMSCRIPTEN)
  find_package(spdlog CONFIG REQUIRED)
  list(APPEND LIBS spdlog::spdlog)
  # target_link_libraries(main PRIVATE spdlog::spdlog_header_only)
endif()
