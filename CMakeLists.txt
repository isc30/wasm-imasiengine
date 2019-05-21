cmake_minimum_required(VERSION 3.5)
project(cpp_starter VERSION 1.0.0)

# Global C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Testing
enable_testing()

# Add External Dependecies
add_subdirectory(external)

# Add Projects
add_subdirectory(projects/helloworld)
add_subdirectory(projects/calculator)
add_subdirectory(projects/greeter)
