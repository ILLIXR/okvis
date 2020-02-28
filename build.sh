#!/bin/bash

rm -rf build
rm -rf install
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=../install ..
make -j8
make install
