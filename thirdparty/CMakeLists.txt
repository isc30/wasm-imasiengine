# DownloadProject
include(downloadproject/DownloadProject.cmake)

# Google Test
add_subdirectory_with_folder("GoogleTest" googletest)

# SDL2
if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    SET(SDL2_PATH ${CMAKE_CURRENT_SOURCE_DIR}/SDL2-2.0.9 CACHE PATH "SDL2 Library Path")
endif()
