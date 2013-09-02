#!/bin/bash
#This script cleans all results of the benchmark from all nodes.
#It can clean the Raw files obtained at monitoring and the Summary files obtained at analizing

MY_PATH="`dirname \"$0\"`"
. $MY_PATH/variables.conf
usage="USAGE:$0 [1=raws; 2=summary; 3=charts]"

if [ $# -ne 1 ]  ; then
	echo $usage
	exit 2
fi

#Raws
if [ $1 -eq 1 ] ; then
	$exeLG "rm -R $rawDir"
#Summary
elif [ $1 -eq 2 ] ; then
	rm -R $summaryDir
#Charts
elif [ $1 -eq 3 ] ; then
	rm -R $chartsDir/Charts
else
	echo $usage
fi
