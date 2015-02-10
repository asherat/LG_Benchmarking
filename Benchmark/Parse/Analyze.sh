#!/bin/bash
#Analyzes all the data obtanied from the benchmark. It executes the script that gets the data in all the nodes
path="`dirname \"$0\"`"
. $path/../../Config/variables.conf

usage="$0 [cluster name]" 

if [ $# -ne 1 ]  ; then
	echo $usage
	exit 2
fi

clusterName=$1

echo "$(hostname)----START ANALIZE----"

$exeLG "mkdir $hw; mkdir $net"

files=$rawDir/*.top

shopt -s nullglob
for file in $rawDir/*.top; do # For all .top file (for every tour)
  _file=$(basename ${file##*/} .top)
 $exeLGbgw $parseDir/AutoResults.sh $_file  # Get the data results from the Raw data
done
$parseDir/CopyData.sh $clusterName

echo "$(hostname)----END ANALIZE----"

