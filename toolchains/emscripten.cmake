string(COMPARE EQUAL "$ENV{EMSCRIPTEN}" "" _is_empty)
if(_is_empty)
  message(FATAL_ERROR
    "EMSCRIPTEN environment variable not set. Set EMSCRIPTEN environment variable to point to the emscripten root directory")
endif()

# Include native emscripten toolchain
include("$ENV{EMSCRIPTEN}/cmake/Modules/Platform/Emscripten.cmake")

# Important initial flags
string(APPEND CMAKE_CXX_FLAGS_INIT " -s WASM=1")
string(APPEND CMAKE_CXX_FLAGS_INIT " -s ERROR_ON_UNDEFINED_SYMBOLS=1")
