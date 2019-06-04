if (NOT DEFINED EMSCRIPTEN AND NOT DEFINED SDL2_PATH)
    message(FATAL_ERROR "SDL2_PATH not set")
endif()

list(APPEND CMAKE_PREFIX_PATH ${SDL2_PATH})

if(DEFINED EMSCRIPTEN)
    set(_SDL2_PATH_SUFFIXES SDL)
else()
    set(_SDL2_PATH_SUFFIXES SDL2)

    if(WIN32)
        if(MSVC)

            if(CMAKE_SIZEOF_VOID_P EQUAL 8)
                set(_SDL2_LIBRARY_PATH_SUFFIX lib/x64)
            elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
                set(_SDL2_LIBRARY_PATH_SUFFIX lib/x86)
            endif()

        elseif(MINGW)
            if(CMAKE_SIZEOF_VOID_P EQUAL 8)
                set(_SDL2_LIBRARY_PATH_SUFFIX x86_64-w64-mingw32/lib)
                list(APPEND _SDL2_PATH_SUFFIXES x86_64-w64-mingw32/include/SDL2)
            elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
                set(_SDL2_LIBRARY_PATH_SUFFIX i686-w64-mingw32/lib)
                list(APPEND _SDL2_PATH_SUFFIXES i686-w64-mingw32/include/SDL2)
            endif()
        endif()
    endif()

    find_library(SDL2_LIBRARY_RELEASE
        NAMES SDL2
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})

    find_library(SDL2_LIBRARY_DEBUG
        NAMES SDL2d
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})

    set(SDL2_LIBRARY_NEEDED SDL2_LIBRARY)
endif()

# Include dir
find_path(SDL2_INCLUDE_DIR
    NAMES SDL_scancode.h
    PATH_SUFFIXES ${_SDL2_PATH_SUFFIXES})

message("Found SDL2 include: " ${SDL2_INCLUDE_DIR})

if(NOT TARGET SDL2::SDL2)

    message("Using Precompiled SDL from " ${_SDL2_LIBRARY_PATH_SUFFIX})

    add_library(SDL2::SDL2 INTERFACE IMPORTED)
    add_library(SDL2::SDL2main INTERFACE IMPORTED)

    if(NOT DEFINED EMSCRIPTEN)
        SET(SDL2_LIB_DIR ${SDL2_PATH}/${_SDL2_LIBRARY_PATH_SUFFIX})
        SET(SDL2_DLL ${SDL2_LIB_DIR}/SDL2.dll)

        target_include_directories(SDL2::SDL2 INTERFACE ${SDL2_INCLUDE_DIR})
        target_link_libraries(SDL2::SDL2 INTERFACE ${SDL2_LIB_DIR}/SDL2.lib)

        target_include_directories(SDL2::SDL2main INTERFACE ${SDL2_INCLUDE_DIR})
        target_link_libraries(SDL2::SDL2main INTERFACE ${SDL2_LIB_DIR}/SDL2main.lib)

        mark_as_advanced(SDL2_PATH SDL2_INCLUDE_DIR SDL2_LIB_DIR SDL2_DLL)
    endif()
endif()
