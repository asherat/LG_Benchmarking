#!/bin/bash
path="`dirname \"$0\"`"
. $path/../variables.conf

echo "$(hostname)----START ANALIZE----"

$exeLG "mkdir $hw; mkdir $net"

files=$rawDir/*.top
shopt -s nullglob
for file in $rawDir/*.top; do
  _file=$(basename ${file##*/} .top)
  $exeLGbg $scriptsDir/AutoResults.sh $_file 
done

echo "$(hostname)----END ANALIZE----"

