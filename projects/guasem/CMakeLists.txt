project(guasem)
add_library(guasem)

# Dependencies
find_package(SDL2 REQUIRED)
target_link_libraries(guasem PUBLIC SDL2::Core)

# Add SDL2 dlls to the global dll list
if (SDL2_DLLS)
    # append to DLL_OUTPUT
endif()

# Includes
target_include_directories(guasem
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(guasem
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/main.cpp
)
