project(ecs)
add_library(ecs INTERFACE)

# Includes
target_include_directories(ecs
    INTERFACE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)
