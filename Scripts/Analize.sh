#!/bin/bash
path="`dirname \"$0\"`"
. $path/../variables.conf

echo "$(hostname)----START ANALIZE----"

mkdir $hw
mkdir $net

files=$rawDir/*.top
shopt -s nullglob
for file in $rawDir/*.top; do
  _file=$(basename ${file##*/} .top)
  $exeLGbg $scriptsDir/AutoResults.sh $_file 
done
#rm $rawDir -R

$scriptsDir/CopyData.sh


echo "$(hostname)----END ANALIZE----"

