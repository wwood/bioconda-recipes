#!/bin/sh
set -x -e

echo "Hello from build.sh"
echo "Flags:"
echo "CFLAGS=$CFLAGS"
echo "CPPFLAGS=$CPPFLAGS"
echo "CXXFLAGS=$CXXFLAGS"
echo "LDFLAGS=$LDFLAGS"

echo "Prefix is: -->$PREFIX<--"
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
