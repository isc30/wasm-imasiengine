cmake_minimum_required(VERSION 3.5)
project(cpp_starter)

# Global CMake Modules
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/modules/")

# Enable IDE Folders
include(AddSubdirectoryWithFolder)

# Global C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable Testing
enable_testing()

# Add ThirdParty Dependecies
add_subdirectory_with_folder("ThirdParty" thirdparty)

# Add Projects
add_subdirectory_with_folder("Projects" projects)
