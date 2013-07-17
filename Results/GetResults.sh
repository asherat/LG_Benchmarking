#!/bin/bash

echo "$(hostname)----START GetResults----"

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results file]"
	exit 2
fi
cd ~/Benchmarking/Results
directory="Result_$1"

echo "Getting top reports"

echo echo 1 | awk '{print "\n;CPU;Memory\nTime;%CPU;Mem Used"}' > $directory/top.csv
cat $1 | grep googleearth-bin | awk '{ print NR-1";"$9";"$6 }' | tr -dc '[:digit:];,.\n' >> $directory/top.csv

echo "$(hostname)----END GetResults----"
