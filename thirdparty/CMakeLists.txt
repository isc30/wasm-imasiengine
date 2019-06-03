# DownloadProject
include(downloadproject/DownloadProject.cmake)

# Google Test
add_subdirectory_with_folder("GoogleTest" googletest)

# SDL2
SET(SDL2_PATH ${CMAKE_CURRENT_SOURCE_DIR}/SDL2-2.0.9)
SET(SDL2_LIB ${SDL2_PATH}/lib/x64)
SET(SDL2_INCLUDE ${SDL2_PATH}/include)
