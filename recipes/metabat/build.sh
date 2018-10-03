if [[ "$OSTYPE" == "linux-gnu" ]]; then
	cd metabat_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
	cd metabat_macos
fi

mkdir -p $PREFIX/bin/

cp aggregateBinDepths.pl $PREFIX/bin/
cp aggregateContigOverlapsByBin.pl $PREFIX/bin/
cp contigOverlaps $PREFIX/bin/
cp jgi_summarize_bam_contig_depths $PREFIX/bin/
cp metabat $PREFIX/bin/
cp metabat1 $PREFIX/bin/
cp metabat2 $PREFIX/bin/
cp runMetaBat.sh $PREFIX/bin/
