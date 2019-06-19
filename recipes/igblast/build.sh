#!/bin/bash
set -euo pipefail

SHARE_DIR=$PREFIX/share/igblast

mkdir -p $PREFIX/bin

export CFLAGS="$CFLAGS -O2"
export CXXFLAGS="$CXXFLAGS -O2"
export CPPFLAGS="$CPPFLAGS -I$PREFIX/include"
export LDFLAGS="$LDFLAGS -L$PREFIX/lib"
export CC_FOR_BUILD=$CC

# if [ $(uname) == Linux ]; then
#   # The binaries want libbz2.so.1, but the correct soname is libbz2.so.1.0
#   for name in makeblastdb igblastn igblastp; do
#     patchelf --replace-needed libbz2.so.1 libbz2.so.1.0 bin/$name
#   done
# fi

# $SHARE_DIR contains the actual igblastn and igblastp binaries and also the
# required data files. Wrappers will be installed into $PREFIX/bin that set
# $IGDATA to point to those data files.
mkdir -p $SHARE_DIR/bin

if [ $(uname) == Linux ]; then
    cd c++
    ./configure.orig \
        --with-dll \
        --with-mt \
        --with-openmp \
        --without-autodep \
        --without-makefile-auto-update \
        --with-flat-makefile \
        --without-caution \
        --without-lzo \
        --without-debug \
        --with-strip \
        --without-vdb \
        --with-z=$PREFIX \
        --with-bz2=$PREFIX \
        --without-krb5 \
        --without-openssl \
        --without-gnutls \
        --without-gcrypt
#         --prefix=$PREFIX \
#         --with-sqlite3=$PREFIX \
#         --with-build-root=ReleaseMT
#         --with-hard-runpath \
#         --with-runpath=$LIB_INSTALL_DIR \
    make -j2
    mv ReleaseMT/bin/{igblastn,igblastp} $SHARE_DIR/bin/
    mv ReleaseMT/bin/makeblastdb $PREFIX/bin/
else
    # On macOS, use the prebuilt binaries
    mv bin/makeblastdb $PREFIX/bin/
    mv bin/igblastn bin/igblastp $SHARE_DIR/bin/
fi

# Install wrappers
for name in igblastn igblastp; do
  sed "s/igblastn/$name/g" $RECIPE_DIR/igblastn.sh > $PREFIX/bin/$name
done

# Replace the shebang
sed '1 s_^.*$_#!/usr/bin/env perl_' igblast-data/bin/edit_imgt_file.pl > $PREFIX/bin/edit_imgt_file.pl

chmod +x $PREFIX/bin/{edit_imgt_file.pl,igblastn,igblastp}

mv igblast-data/internal_data igblast-data/optional_file ${SHARE_DIR}
