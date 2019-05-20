cmake_minimum_required(VERSION 3.5)
project(cpp_starter VERSION 1.0.0)

enable_testing()
include(external/googletest/AddGoogleTest.cmake)

add_subdirectory(projects/helloworld)
add_subdirectory(projects/calculator)
add_subdirectory(projects/greeter)
