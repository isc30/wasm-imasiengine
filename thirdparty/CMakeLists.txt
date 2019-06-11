# SDL2
if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    set(MSVC2017_COMPATIBILITY ON CACHE BOOL "Force compatibility mode for Visual Studio 2017")
    SET(SDL2_PATH ${CMAKE_CURRENT_SOURCE_DIR}/SDL2/MSVC/SDL2-2.0.9 CACHE PATH "SDL2_PATH")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    SET(SDL2_PATH ${CMAKE_CURRENT_SOURCE_DIR}/SDL2/MINGW/SDL2-2.0.9 CACHE PATH "SDL2_PATH")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Emscripten")
endif()

if(DEFINED SDL2_PATH)
    list(APPEND CMAKE_PREFIX_PATH ${SDL2_PATH})
endif()

# Corrade
add_subdirectory(corrade)

# Magnum
if(EMSCRIPTEN)
    set(WITH_EMSCRIPTENAPPLICATION ON CACHE BOOL "Force Emscripten application")
else()
    set(WITH_SDL2APPLICATION ON CACHE BOOL "Force SDL application")
endif()
add_subdirectory(magnum)

# DownloadProject
include(downloadproject/DownloadProject.cmake)

# Google Test
add_subdirectory(googletest)
