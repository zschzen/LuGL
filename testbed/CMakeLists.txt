set(TESTBED_SOURCE_FILES ./main.cpp ./Application.cpp)

set(TESTBED_HEADER_FILES ./Application.hpp)

add_executable(testbed)
target_sources(testbed PRIVATE ${TESTBED_SOURCE_FILES} ${TESTBED_HEADER_FILES})
target_include_directories(testbed PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(testbed PUBLIC lugl)

set_target_properties(
  testbed
  PROPERTIES CXX_STANDARD 20
             CXX_STANDARD_REQUIRED YES
             CXX_EXTENSIONS NO)

if(EMSCRIPTEN)
  set_target_properties(
    testbed
    PROPERTIES
      LINK_FLAGS
      "--emrun
      WASM=1 -s
      ASYNCIFY -s
      GL_ENABLE_GET_PROC_ADDRESS=1 -s
      ALLOW_MEMORY_GROWTH")
  target_link_options(testbed PRIVATE -sNO_DISABLE_EXCEPTION_CATCHING)
  target_compile_options(testbed PRIVATE -sNO_DISABLE_EXCEPTION_CATCHING)
endif()

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${TESTBED_SOURCE_FILES}
                                                    ${TESTBED_HEADER_FILES})
