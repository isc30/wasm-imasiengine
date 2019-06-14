#!/bin/bash

HOMEBREW_NO_AUTO_UPDATE=1 brew install emscripten && export LLVM=/usr/local/opt/emscripten/libexec/llvm/bin && emcc

# Corrade
git clone --depth 1 git://github.com/mosra/corrade.git
cd corrade

# Build native corrade-rc
mkdir corrade-rc && cd corrade-rc
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$HOME/deps-native \
    -DWITH_INTERCONNECT=OFF \
    -DWITH_PLUGINMANAGER=OFF \
    -DWITH_TESTSUITE=OFF \
    -DWITH_UTILITY=OFF

cmake --build . --target install

cd ../..

wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz


# Build using Emscripten toolchain
cmake . \
    -DCMAKE_CXX_FLAGS="-Wall -pedantic -Werror -Wno-variadic-macros -Wno-long-long -Wno-shadow" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCORRADE_RC_EXECUTABLE=$HOME/deps-native/bin/corrade-rc \
    -DCMAKE_TOOLCHAIN_FILE=./toolchains/generic/Emscripten-wasm.cmake

cmake --build .

ctest -V
