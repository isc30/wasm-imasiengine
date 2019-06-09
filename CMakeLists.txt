cmake_minimum_required(VERSION 3.5)
project(cpp_starter)

# Output Directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/archive)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# Global CMake Modules
list(INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/modules")

# Global C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable Testing
enable_testing()

# Add ThirdParty Dependecies
add_subdirectory(thirdparty)

# Add Projects
add_subdirectory(projects)
