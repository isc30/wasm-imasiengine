mkdir build
cd build
mkdir clang
cd clang

cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ ../..
cmake --build .
ctest -V
