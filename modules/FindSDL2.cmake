include_guard(GLOBAL)

if(DEFINED SDL2_DIR)
    list(APPEND CMAKE_PREFIX_PATH ${SDL2_DIR})
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
                list(APPEND _SDL2_PATH_SUFFIXES x86_64-w64-mingw32/include/SDL2)
            elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
                set(_SDL2_LIBRARY_PATH_SUFFIX i686-w64-mingw32/lib)
                list(APPEND _SDL2_PATH_SUFFIXES i686-w64-mingw32/include/SDL2)
            endif()
        endif()
    endif()

    # Find Debug library
    find_library(SDL2_LIBRARY_DEBUG
        NAME SDL2d
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})

    # Find Release library
    find_library(SDL2_LIBRARY_RELEASE
        NAME SDL2
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})
    
    # Set SDL2_LIBRARY based on current build configuration
    include(SelectLibraryConfigurations)
    select_library_configurations(SDL2)

    # Populate useful variables
    get_filename_component(SDL2_LIBRARY_DIR ${SDL2_LIBRARY} DIRECTORY)
    get_filename_component(SDL2_LIBRARY_NAME ${SDL2_LIBRARY} NAME_WE)

    # Mark library as required for the linker
    set(SDL2_LIBRARY_NEEDED SDL2_LIBRARY)

    # Export current shared DLL for Windows
    find_file(SDL2_LIBRARY_DLLS
        NAMES ${SDL2_LIBRARY_NAME}.dll
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})

    # Find SDL2main
    find_library(SDL2main_LIBRARY
        NAME SDL2main
        PATH_SUFFIXES ${_SDL2_LIBRARY_PATH_SUFFIX})

    # Mark library as required for the linker
    set(SDL2main_LIBRARY_NEEDED SDL2main_LIBRARY)
endif()

# Include dir (declare SDL2_INCLUDE_DIR)
find_path(SDL2_INCLUDE_DIR
    NAME SDL_scancode.h
    PATH_SUFFIXES ${_SDL2_PATH_SUFFIXES})

message("[SDL2] SDL2_INCLUDE_DIR: " ${SDL2_INCLUDE_DIR})
message("[SDL2] SDL2_LIBRARY_DIR: " ${SDL2_LIBRARY_DIR})
message("[SDL2] SDL2_LIBRARY_NAME: " ${SDL2_LIBRARY_NAME})
message("[SDL2] SDL2_LIBRARY: " ${SDL2_LIBRARY})
message("[SDL2] SDL2_LIBRARY_DLLS: " ${SDL2_LIBRARY_DLLS})

# Resolve libraries
include(FindPackageHandleStandardArgs)

# Resolve SDL2_LIBRARY
find_package_handle_standard_args(SDL2 REQUIRED_VARS
    SDL2_INCLUDE_DIR
    ${SDL2_LIBRARY_NEEDED})

# Resolve SDL2main_LIBRARY
find_package_handle_standard_args(SDL2main REQUIRED_VARS
    SDL2_INCLUDE_DIR
    ${SDL2main_LIBRARY_NEEDED})

# SDL2 target
if(SDL2_FOUND AND NOT TARGET SDL2::SDL2)
    message("[SDL2] Using precompiled libraries")

    add_library(SDL2::SDL2 INTERFACE IMPORTED)
    target_include_directories(SDL2::SDL2 INTERFACE ${SDL2_INCLUDE_DIR})
    target_link_libraries(SDL2::SDL2 INTERFACE ${SDL2_LIBRARY})
endif()

# SDL2main target
if(SDL2main_FOUND AND NOT TARGET SDL2::SDL2main)
    message("[SDL2main] Using precompiled libraries")

    add_library(SDL2::SDL2main INTERFACE IMPORTED)
    target_link_libraries(SDL2::SDL2main INTERFACE ${SDL2main_LIBRARY})
endif()

mark_as_advanced(SDL2_FOUND SDL2_INCLUDE_DIR SDL2_LIBRARY_DIR SDL2_LIBRARY SDL2_LIBRARY_DLLS)
mark_as_advanced(SDL2main_FOUND SDL2main_LIBRARY)

# Enable EMSCRIPTEN compiler flags for SDL2
if (DEFINED EMSCRIPTEN)
    string(APPEND CMAKE_CXX_FLAGS " -s USE_WEBGL2=1")
    string(APPEND CMAKE_CXX_FLAGS " -s USE_SDL=2")
endif()
