#!/bin/bash
if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [TagName]"
	exit 2
fi
outputfile=queries.txt
echo $(awk -v tourname="$1" '/<LookAt>/,/<\/LookAt>/{if (/<LookAt>/) print tourname"@"name"@flytoview="$0""; else print} /<name>/,/<\/name>/ {gsub(/<.?name>/,"");name=$0}' doc.kml)   | sed -e 's/ //g;s/'$1'@/\n'$1'@/g' > $outputfile

echo "Output file: " $outputfile
