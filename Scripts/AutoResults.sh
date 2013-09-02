#!/bin/bash
#Get readable csv from the raw data file ($rawFile) of the benchmark tour

path="`dirname \"$0\"`"
. $path/../variables.conf

rawFile=$1

echo "$(hostname) |$rawFile|----START AutoResults----"

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results file]"
	exit 1
fi

if [ ! -f "$rawDir/$rawFile.top" ]; then
	echo "'$rawDir/$rawFile.top' doesn't exist"
	exit 1
elif [ ! -f "$rawDir/$rawFile.mem" ]; then
	echo "'$rawDir/$rawFile.mem' doesn't exist"
	exit 1
elif [ ! -f "$rawDir/$rawFile.pcap" ]; then
	echo "'$rawDir/$rawFile.pcap' doesn't exist"
	exit 1
fi

tmpDir="$rawDir/Result_$rawFile"
mkdir $tmpDir
. $scriptsDir/GetResults.sh $rawFile
. $scriptsDir/ParseResults.sh $rawFile
. $scriptsDir/PacketsResults.sh $rawFile
rm $tmpDir -R

echo "$(hostname) |$rawFile|----END AutoResults----"
