# Debian's ncbi-vdb package: https://salsa.debian.org/med-team/ncbi-vdb

# Paths to toolchain binaries (gcc, g++, ar) are all hard-coded and need some
# patching.

sed -i.backup \
    -e "s|gcc|$CC|g" \
    -e "s|g++|$CXX|g" \
    build/Makefile.gcc
./configure \
    --debug \
    --prefix=$PREFIX \
    --build-prefix=ncbi-outdir \
    --with-ngs-sdk-prefix=$PREFIX \
    CXX=$CXX
sed -i.backup \
    -e "s|= gcc|= $CC|" \
    -e "s|= gcc|= $CXX|" \
    -e "s|= ar rc|= ar|" \
    -e "s|= ar|= $AR|" \
    build/Makefile.config.linux.x86_64

make
make install
make -C test/vdb
mv interfaces/* $PREFIX/include/ncbi-vdb
