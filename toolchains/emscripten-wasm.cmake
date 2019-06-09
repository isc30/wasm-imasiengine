cmake_minimum_required(VERSION 3.7)

string(COMPARE EQUAL "$ENV{EMSCRIPTEN}" "" _is_empty)
if(_is_empty)
  message(FATAL_ERROR
    "EMSCRIPTEN environment variable not set. Set EMSCRIPTEN environment variable to point to the emscripten root directory")
endif()

# Set compiler id
set(CMAKE_CXX_COMPILER_ID "Emscripten")

# Include native emscripten toolchain
include("$ENV{EMSCRIPTEN}/cmake/Modules/Platform/Emscripten.cmake")

# Prefixes/suffixes for building
set(CMAKE_STATIC_LIBRARY_PREFIX "")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".bc")
set(CMAKE_EXECUTABLE_SUFFIX ".js")

# Prefixes/suffixes for finding libraries
set(CMAKE_FIND_LIBRARY_PREFIXES "")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".bc")

# Important initial flags
string(APPEND CMAKE_CXX_FLAGS_INIT " -s DISABLE_DEPRECATED_FIND_EVENT_TARGET_BEHAVIOR=1")
string(APPEND CMAKE_CXX_FLAGS_INIT " -s ERROR_ON_UNDEFINED_SYMBOLS=1")
string(APPEND CMAKE_CXX_FLAGS_INIT " -s WASM=1")
string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " -s ERROR_ON_UNDEFINED_SYMBOLS=1")
string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " -s WASM=1")
string(APPEND CMAKE_CXX_FLAGS_RELEASE_INIT " -DNDEBUG -O3")
string(APPEND CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT " -O3 --llvm-lto 1")
