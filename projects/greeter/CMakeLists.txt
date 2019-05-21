project(greeter)
add_library(greeter)

# Tests
add_subdirectory(tests)

# Includes
target_include_directories(greeter
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(greeter
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/Greeter.cpp
)
