#!/bin/bash

cd htslib
autoreconf -fi
./configure --prefix=`pwd`
make install

cd ../ivar/

./autogen.sh
./configure --prefix=$PREFIX --with-hts=$(pwd ../)/htslib
#./configure --prefix=$PREFIX --with-hts=$(dirname $(pwd))/htslib
make
make install
