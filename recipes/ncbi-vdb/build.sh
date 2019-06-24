
sed -i.backup -e "s|gcc|$CC|g" -e "s|g++|$CXX|g" build/Makefile.gcc

./configure \
    --prefix=$PREFIX \
    --build-prefix=ncbi-outdir \
    --with-ngs-sdk-prefix=$PREFIX
make
make install
make -C test/vdb
mv interfaces/* $PREFIX/include/ncbi-vdb
