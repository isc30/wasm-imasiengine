#!/bin/bash

# Build native corrade-rc
git clone --depth 1 git://github.com/mosra/corrade.git

cd corrade
    mkdir corrade-rc
    cd corrade-rc
        cmake .. \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=$HOME/deps-native \
            -DWITH_INTERCONNECT=OFF \
            -DWITH_PLUGINMANAGER=OFF \
            -DWITH_TESTSUITE=OFF \
            -DWITH_UTILITY=OFF

        cmake --build . --target install
    cd ..
cd ..

wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
tar -xzf emsdk-portable.tar.gz
cd emsdk-portable
    ./emsdk update
    ./emsdk update-tags
    ./emsdk install latest
    ./emsdk activate latest
    source emsdk_env.sh
cd ..

# Build using Emscripten toolchain
cmake . \
    -DCMAKE_CXX_FLAGS="-Wall -pedantic -Werror -Wno-variadic-macros -Wno-long-long -Wno-shadow" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCORRADE_RC_EXECUTABLE=$HOME/deps-native/bin/corrade-rc \
    -DCMAKE_TOOLCHAIN_FILE=./toolchains/generic/Emscripten-wasm.cmake

cmake --build .

ctest -V
