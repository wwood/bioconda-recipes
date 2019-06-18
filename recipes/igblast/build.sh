#!/bin/bash
set -euo pipefail

SHARE_DIR=$PREFIX/share/igblast

mkdir -p $PREFIX/bin

if [ $(uname) == Linux ]; then
  # The binaries want libbz2.so.1, but the correct soname is libbz2.so.1.0
  for name in makeblastdb igblastn igblastp; do
    patchelf --replace-needed libbz2.so.1 libbz2.so.1.0 bin/$name
  done
fi

# $SHARE_DIR contains the actual igblastn and igblastp binaries and also the
# required data files. Wrappers will be installed into $PREFIX/bin that set
# $IGDATA to point to those data files.
mkdir -p $SHARE_DIR/bin

# Copy binaries and wrappers
for name in igblastn igblastp; do
  mv bin/$name $SHARE_DIR/bin/
  sed "s/igblastn/$name/g" $RECIPE_DIR/igblastn.sh > $PREFIX/bin/$name
done

# No wrapper needed
mv bin/makeblastdb $PREFIX/bin/

# Replace the shebang with `#!/usr/bin/env perl`
sed '1 s_^.*$_#!/usr/bin/env perl_' bin/edit_imgt_file.pl > $PREFIX/bin/edit_imgt_file.pl

chmod +x $PREFIX/bin/{edit_imgt_file.pl,igblastn,igblastp}

mv internal_data optional_file ${SHARE_DIR}
