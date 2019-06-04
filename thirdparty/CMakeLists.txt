# DownloadProject
include(downloadproject/DownloadProject.cmake)

# Google Test
add_subdirectory_with_folder("GoogleTest" googletest)

# SDL2
if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    SET(SDL2_PATH ${CMAKE_CURRENT_SOURCE_DIR}/SDL2/MSVC/SDL2-2.0.9 CACHE PATH "SDL2_PATH")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    SET(SDL2_PATH ${CMAKE_CURRENT_SOURCE_DIR}/SDL2/MINGW/SDL2-2.0.9 CACHE PATH "SDL2_PATH")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Emscripten")
endif()
