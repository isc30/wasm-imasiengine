project(hello_world)
add_executable(hello_world)

# Dependencies
target_link_libraries(hello_world PUBLIC calculator)
target_link_libraries(hello_world PUBLIC SDL2 SDL2main)

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
