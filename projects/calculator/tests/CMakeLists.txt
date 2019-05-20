add_executable(calculator_tests)

# Use GoogleTest
add_gtest(calculator_tests)

# Dependencies
add_dependencies(calculator_tests calculator)
target_link_libraries(calculator_tests PUBLIC calculator)

# Includes
target_include_directories(calculator_tests
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(calculator_tests
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/CalculatorTests.cpp
)
