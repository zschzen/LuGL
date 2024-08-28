# --------------------------------------------------------------------
# SDL Configuration
# --------------------------------------------------------------------
set(SDL_LIBC ON CACHE BOOL "" FORCE)
set(SDL_TEST OFF CACHE BOOL "" FORCE)

message(STATUS "Using LuGL's SDL")

find_package(SDL2 CONFIG REQUIRED)
list(APPEND LIBS
$<TARGET_NAME_IF_EXISTS:SDL2::SDL2main>
$<IF:$<TARGET_EXISTS:SDL2::SDL2>,SDL2::SDL2,SDL2::SDL2-static>
)
