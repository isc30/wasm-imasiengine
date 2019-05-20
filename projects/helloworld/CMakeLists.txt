cmake_minimum_required (VERSION 3.5)

add_executable(hello_world)

# Dependencies
add_dependencies(hello_world calculator)
target_link_libraries(hello_world PRIVATE calculator)

# Includes
target_include_directories(hello_world
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(hello_world
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/main.cpp
)
