if (NOT DEFINED EMSCRIPTEN AND NOT DEFINED SDL2_PATH)
    message(FATAL_ERROR "SDL2_PATH not set")
endif()

add_library(SDL2 INTERFACE)
add_library(SDL2main INTERFACE)

if(NOT DEFINED EMSCRIPTEN)
    list(APPEND CMAKE_PREFIX_PATH ${SDL2_PATH})

    SET(SDL2_INCLUDE ${SDL2_PATH}/include)
    SET(SDL2_LIB ${SDL2_PATH}/lib/x64)
    SET(SDL2_DLL ${SDL2_LIB}/SDL2.dll)

    target_include_directories(SDL2 INTERFACE ${SDL2_INCLUDE})
    target_link_libraries(SDL2 INTERFACE ${SDL2_LIB}/SDL2.lib)

    target_include_directories(SDL2main INTERFACE ${SDL2_INCLUDE})
    target_link_libraries(SDL2main INTERFACE ${SDL2_LIB}/SDL2main.lib)

    mark_as_advanced(SDL2_PATH SDL2_INCLUDE SDL2_LIB SDL2_DLL)
endif()
