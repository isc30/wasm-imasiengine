project(calculator)
add_library(calculator)

# Tests
add_subdirectory(tests)

# Includes
target_include_directories(calculator
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(calculator
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/Calculator.cpp
)
