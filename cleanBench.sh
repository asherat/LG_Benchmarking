#!/bin/bash
#This script cleans all Data of the benchmark from all nodes.

MY_PATH="`dirname \"$0\"`"
. $MY_PATH/Config/variables.conf
usage="USAGE:$0 [1=raws 2=charts 3=data 4=wwwCharts]"

if [ $# -ne 1 ]  ; then
	echo $usage
	exit 2
fi

#Deletes the raw files obtained when monitoring
if [ $1 -eq 1 ] ; then
	$exeLG "rm -R $rawDir"
#Deletes the charts generated in lg1
elif [ $1 -eq 2 ] ; then
	rm -R $chartsDir
#Deletes the analyzed Data in lg1
elif [ $1 -eq 3 ] ; then
        rm -R $dataDir
#Deletes the charts uploaded to the web-server
elif [ $1 -eq 4 ] ; then
        rm -R /var/www/benchmarking/charts/*
else
	echo $usage
fi
