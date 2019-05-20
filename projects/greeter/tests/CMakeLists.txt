add_executable(greeter_tests)

# Use GoogleTest
add_gtest(greeter_tests)

# Dependencies
add_dependencies(greeter_tests greeter)
target_link_libraries(greeter_tests PUBLIC greeter)

# Includes
target_include_directories(greeter_tests
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(greeter_tests
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/GreeterTests.cpp
)
