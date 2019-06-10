mkdir build
cd build
mkdir wasm
cd wasm

cmake ../.. -DCMAKE_GENERATOR="MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE="../../toolchains/generic/Emscripten.cmake"
cmake --build .
ctest -V
