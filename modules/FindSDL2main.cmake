include_guard(GLOBAL)

# Require base SDL2 package
find_package(SDL2 REQUIRED)

if(NOT DEFINED EMSCRIPTEN)
    # Find SDL2main library
    find_library(SDL2main_LIBRARY
        NAMES SDL2main
        PATHS ${SDL2_LIBRARY_DIR})

    # Populate useful variables
    get_filename_component(SDL2main_LIBRARY_DIR ${SDL2main_LIBRARY} DIRECTORY)
    get_filename_component(SDL2main_LIBRARY_NAME ${SDL2main_LIBRARY} NAME_WE)

    # Mark library as required for the linker
    set(SDL2main_LIBRARY_NEEDED SDL2main_LIBRARY)
endif()

# Resolve package (declare SDL2main_FOUND)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2main
    REQUIRED_VARS ${SDL2main_LIBRARY_NEEDED}
    HANDLE_COMPONENTS)

if(SDL2main_FOUND AND NOT TARGET SDL2::SDL2main)
    message("[SDL2main] Using precompiled libraries")

    add_library(SDL2::SDL2main INTERFACE IMPORTED)

    if(SDL2main_LIBRARY_NEEDED)
        target_link_libraries(SDL2::SDL2main INTERFACE ${SDL2main_LIBRARY})
    endif()
endif()

mark_as_advanced(SDL2main_FOUND SDL2main_LIBRARY)

foreach(ComponentName ${SDL2_FIND_COMPONENTS})
    if(TARGET SDL2::${ComponentName})
        find_package(${ComponentName})
    endif()
endforeach()
