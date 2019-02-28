#!/bin/sh
set -x -e

./build_boost.sh

export CFLAGS="-I$PREFIX/include"
export CPPFLAGS="-I$PREFIX/include"
export CXXFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

./autogen.sh
./configure --disable-silent-rules --disable-dependency-tracking --prefix=$PREFIX
make V=1
make V=1 check
make install
