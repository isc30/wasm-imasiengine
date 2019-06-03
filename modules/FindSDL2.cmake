if (NOT DEFINED EMSCRIPTEN AND NOT DEFINED SDL2_PATH)
    message(FATAL_ERROR "SDL2_PATH not set")
endif()

SET(SDL2_LIB ${SDL2_PATH}/lib/x64)
SET(SDL2_INCLUDE ${SDL2_PATH}/include)

add_library(SDL2 SHARED IMPORTED)
set_property(TARGET SDL2 PROPERTY
    IMPORTED_LOCATION "${SDL2_LIB}/SDL2.lib")

add_library(SDL2main SHARED IMPORTED)
set_property(TARGET SDL2main PROPERTY
    IMPORTED_LOCATION "${SDL2_LIB}/SDL2main.lib")

include_directories(${SDL2_INCLUDE})
link_directories(${SDL2_LIB})

# Enable native SDL2 in Emscripten
if (DEFINED EMSCRIPTEN)
    string(APPEND CMAKE_CXX_FLAGS_INIT " -s ERROR_ON_MISSING_LIBRARIES=0 -s USE_SDL=2")
endif()
