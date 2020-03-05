#!/bin/bash
set -x -e

path="${PWD}"
if [ ! -e "/opt/libvisensor" ]
then
	cd /opt
	git clone https://github.com/ethz-asl/libvisensor.git
	cd libvisensor
	./install_libvisensor.sh
	cd "${path}"
fi

apt-get install -y cmake libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev libboost-dev libboost-filesystem-dev libopencv-dev libboost-filesystem-dev

rm -rf build
rm -rf install
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=../install -D CMAKE_C_COMPILER="$(which clang)" -D CMAKE_CXX_COMPILER="$(which clang++)" ..
make -j$(nproc)
make install
cd ..
