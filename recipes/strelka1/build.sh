cd ${SRC_DIR}
./configure --prefix=${PREFIX}/bin/strelka1-src
make
echo -e "#!""/bin/bash\n\n""${PREFIX}/bin/strelka1-src/bin/configureStrelkaWorkflow.pl" >> ${PREFIX}/bin/strelka1
chmod +x ${PREFIX}/bin/strelka1
