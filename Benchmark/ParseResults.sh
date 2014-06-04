#!/bin/bash
# Formats the files from the Hardware data and merges it into a readable csv file
rawFile=$1

echo "$(hostname) |$rawFile|----START ParseResults----"

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 Result_[dir]"
	exit 2
fi

inDir=$rawDir/"Result_$rawFile"
outFile=$hw/HW_$rawFile.csv

if [ ! -d "$inDir" ]; then
    echo "Dir '$inDir' doesn't exist"
else
	tempDir="$rawDir/CSV_$rawFile"
	mkdir $tempDir
	cp $inDir/*.csv $tempDir/

	echo "Mending all csv files"
	find $tempDir -type f -exec sed -i 's/,/./g;s/;/,/g' {} \;

	echo "Merging all csv files"
	paste -d',' $tempDir/*.csv > $outFile
	echo "Generated '$outFile'"
	
	rm $tempDir -R

fi
echo "$(hostname) |$rawFile|----END ParseResults----"
