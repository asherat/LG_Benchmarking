#!/bin/bash
path="`dirname \"$0\"`"
. $path/../variables.conf

rawFile=$1

echo "$(hostname) |$rawFile|----START AutoResults----"

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results file]"
	exit 2
fi

if [ ! -f "$rawDir/$rawFile.top" ]; then
	echo "'$rawDir/$rawFile.top' doesn't exist"
	exit 2
elif [ ! -f "$rawDir/$rawFile.top" ]; then
	echo "'$rawDir/$rawFile.top' doesn't exist"
	exit 2
fi

ResultDir="$rawDir/Result_$rawFile"
mkdir $ResultDir
#echo "Created dir $ResultDir"
. $scriptsDir/GetResults.sh $rawFile
. $scriptsDir/ParseResults.sh $rawFile
. $scriptsDir/PacketsResults.sh $rawFile
#rm $ResultDir -R

echo "$(hostname) |$rawFile|----END AutoResults----"
