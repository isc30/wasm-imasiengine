#!/bin/bash

cmake . \
    -DCMAKE_CXX_FLAGS="-Wall -pedantic -Werror -Wno-variadic-macros -Wno-long-long -Wno-shadow" \
    -DCMAKE_BUILD_TYPE=Release

cmake --build .

ctest -V
