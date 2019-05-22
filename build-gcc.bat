mkdir build
cd build
mkdir gcc
cd gcc

cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ../..
cmake --build .
ctest -V
