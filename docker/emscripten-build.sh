#!/bin/bash

mkdir build
cd build

mkdir emscripten
cd emscripten

# Build native corrade-rc
git clone --depth 1 git://github.com/mosra/corrade.git

cd corrade
    mkdir corrade-rc
    cd corrade-rc
        cmake .. \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=../../deps-native \
            -DWITH_INTERCONNECT=OFF \
            -DWITH_PLUGINMANAGER=OFF \
            -DWITH_TESTSUITE=OFF \
            -DWITH_UTILITY=OFF

        cmake --build . --target install
    cd ..
cd ..

# Build using Emscripten toolchain
cmake ../../. \
    -DCMAKE_CXX_FLAGS="-Wall -pedantic -Werror -Wno-variadic-macros -Wno-long-long -Wno-shadow" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCORRADE_RC_EXECUTABLE=./deps-native/bin/corrade-rc \
    -DCMAKE_TOOLCHAIN_FILE=./toolchains/generic/Emscripten-wasm.cmake

cmake --build .

ctest -V
