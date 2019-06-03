if (NOT DEFINED EMSCRIPTEN AND NOT DEFINED SDL2_PATH)
    message(FATAL_ERROR "SDL2_PATH not set")
endif()

if (NOT DEFINED EMSCRIPTEN)
    SET(SDL2_INCLUDE ${SDL2_PATH}/include)
    SET(SDL2_LIB ${SDL2_PATH}/lib/x64)
    SET(SDL2_DLL ${SDL2_LIB}/SDL2.dll)

    add_library(SDL2::SDL2 STATIC IMPORTED)
    set_property(TARGET SDL2::SDL2 PROPERTY
        IMPORTED_LOCATION ${SDL2_LIB}/SDL2.lib)

    add_library(SDL2::SDL2main STATIC IMPORTED)
    set_property(TARGET SDL2::SDL2main PROPERTY
        IMPORTED_LOCATION ${SDL2_LIB}/SDL2main.lib)

    include_directories(${SDL2_INCLUDE})
    link_directories(${SDL2_LIB})

    mark_as_advanced(SDL2_PATH SDL2_INCLUDE SDL2_LIB SDL2_DLL)
else()
    # Enable native SDL2 in Emscripten
    string(APPEND CMAKE_CXX_FLAGS_INIT " -s ERROR_ON_MISSING_LIBRARIES=0 -s USE_SDL=2")
endif()
