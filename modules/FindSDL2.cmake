include_guard(GLOBAL)

if(DEFINED SDL2_PATH)
    list(APPEND CMAKE_PREFIX_PATH ${SDL2_PATH})
endif()

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
                set(_SDL2_BIN_PATH_SUFFIX x86_64-w64-mingw32/bin)
                list(APPEND _SDL2_PATH_SUFFIXES x86_64-w64-mingw32/include/SDL2)
            elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
                set(_SDL2_LIBRARY_PATH_SUFFIX i686-w64-mingw32/lib)
                set(_SDL2_BIN_PATH_SUFFIX i686-w64-mingw32/bin)
                list(APPEND _SDL2_PATH_SUFFIXES i686-w64-mingw32/include/SDL2)
            endif()
        endif()
    endif()

    # Find Debug library
    find_library(SDL2_LIBRARY_DEBUG
        NAMES SDL2d SDL-2.0d
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})

    # Find Release library
    find_library(SDL2_LIBRARY_RELEASE
        NAMES SDL2 SDL-2.0
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})
    
    # Set SDL2_LIBRARY based on current build configuration
    include(SelectLibraryConfigurations)
    select_library_configurations(SDL2)

    # Mark library as required for the linker
    set(SDL2_LIBRARY_NEEDED SDL2_LIBRARY)

    # Export current shared DLL for Windows
    find_file(SDL2_LIBRARY_DLLS
        NAMES SDL2.dll
        PATH_SUFFIXES ${_SDL2_BIN_PATH_SUFFIX} ${_SDL2_LIBRARY_PATH_SUFFIX})
endif()

# Include dir (declare SDL2_INCLUDE_DIR)
find_path(SDL2_INCLUDE_DIR
    NAME SDL_scancode.h
    PATH_SUFFIXES ${_SDL2_PATH_SUFFIXES})

message("[SDL2] SDL2_INCLUDE_DIR: " ${SDL2_INCLUDE_DIR})
message("[SDL2] SDL2_LIBRARY: " ${SDL2_LIBRARY})
message("[SDL2] SDL2_LIBRARY_DLLS: " ${SDL2_LIBRARY_DLLS})

# Resolve package (errors if includes aren't found)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2 REQUIRED_VARS
    SDL2_INCLUDE_DIR
    ${SDL2_LIBRARY_NEEDED})

# Advance GUI variables
mark_as_advanced(
    SDL2_PATH
    SDL2_FOUND
    SDL2_LIBRARY
    SDL2_INCLUDE_DIR
    SDL2_LIBRARY_DLLS)

# SDL2::Core target
if(SDL2_FOUND AND NOT TARGET SDL2::Core)
    add_library(SDL2::Core INTERFACE IMPORTED)
    target_include_directories(SDL2::Core INTERFACE ${SDL2_INCLUDE_DIR})
    target_link_libraries(SDL2::Core INTERFACE ${SDL2_LIBRARY})
endif()

# Enable EMSCRIPTEN compiler flags for SDL2 and WebGL
if (DEFINED EMSCRIPTEN)
    string(APPEND CMAKE_CXX_FLAGS " -s USE_WEBGL2=1")
    string(APPEND CMAKE_CXX_FLAGS " -s USE_SDL=2")
endif()
