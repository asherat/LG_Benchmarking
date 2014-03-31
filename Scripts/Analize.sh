#!/bin/bash
#Analizes all the data obtanied from the benchmark. It executes the script that gets the data in all the nodes

path="`dirname \"$0\"`"
. $path/../variables.conf

echo "$(hostname)----START ANALIZE----"

$exeLG "mkdir $hw; mkdir $net"

files=$rawDir/*.top

shopt -s nullglob
for file in $rawDir/*.top; do # For all .top file (for every tour)
  _file=$(basename ${file##*/} .top)
 $exeLGbg $scriptsDir/AutoResults.sh $_file  # Get the data results from the Raw data
done

echo "$(hostname)----END ANALIZE----"

