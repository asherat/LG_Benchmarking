#!/bin/bash
#This script gets all the POIs with its name into queries.txt using a tourname from the user input
#While using Google Earth, you should make a directory with some POIs (using the yellow pin) inside of them. Then right-click and save the directory as a KMZ. Then extract it with winrar or another similar program. There should be a file named doc.kml which is the input file of this script.

inputfile=doc.kml
outputfile=queries.txt

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [tourname]"
	exit 2
fi

echo $(awk -v tourname="$1" '/<LookAt>/,/<\/LookAt>/{if (/<LookAt>/) print tourname"@"name"@flytoview="$0""; else print} /<name>/,/<\/name>/ {gsub(/<.?name>/,"");name=$0}' $inputfile)   | sed -e 's/ //g;s/'$1'@/\n'$1'@/g' > $outputfile

echo "Output file: " $outputfile
