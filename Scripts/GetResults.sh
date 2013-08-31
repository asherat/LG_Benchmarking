#!/bin/bash
# Gets the Hardware data from the raw files

rawFile=$1

echo "$(hostname) |$rawFile|----START GetResults----"

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results file]"
	exit 2
fi

inFile=$rawDir/$rawFile
outDir=$rawDir/"Result_$rawFile"

echo "Getting CPU reports"
echo echo 1 | awk '{print "\n;CPU;Memory\nTime;%CPU"}' > $outDir/1_top.csv
cat $inFile.top | grep googleearth-bin | awk '{ print NR-1";"$9}' | tr -dc '[:digit:];,.\n' >> $outDir/1_top.csv

echo "Getting RAM reports"
echo echo 1 | awk '{print "\n\nRAM used"}' > $outDir/2_mem.csv
awk '{print $2}' $inFile.mem >> $outDir/2_mem.csv

echo "$(hostname) |$rawFile|----END GetResults----"
