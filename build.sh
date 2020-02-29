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

if [ ! -e "/opt/glog" ]
then
	cd /opt
	git clone https://github.com/google/glog.git
	cd glog
	./autogen.sh && ./configure && make && make install
	cd "${path}"
fi

rm -rf build
rm -rf install
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=../install ..
make -j8
make install
