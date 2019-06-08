cmake_minimum_required(VERSION 3.5)
project(cpp_starter)

# Output Directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin")
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# Global CMake Modules
list(INSERT CMAKE_MODULE_PATH 0 "${PROJECT_SOURCE_DIR}/modules")

# Global C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Activate Compilers
if (CORRADE_TARGET_EMSCRIPTEN)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s DISABLE_DEPRECATED_FIND_EVENT_TARGET_BEHAVIOR=1")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s POLYFILL_OLD_MATH_FUNCTIONS=1")
endif()

# Enable Testing
enable_testing()

# Add ThirdParty Dependecies
add_subdirectory(thirdparty)

# Add Projects
add_subdirectory(projects)
