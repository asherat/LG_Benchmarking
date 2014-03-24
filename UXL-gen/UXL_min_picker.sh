#!/bin/bash
#Pass a dir, lg# tourname-tagname to get an orientative threshold number.
#Must pick it manually and set it in the clusters.conf file
#The output are 2 columns, the first is a value, the second is how many times it is repeated
#The recommendation is to pick a value which doesn't have many repetitions after the most repeated values (global minimum)

path="`dirname \"$0\"`"
cd $path/..
usage="$0 [dir] lg[X] [bcn,desierto,Horsens]-[timing] OPTIONAL:[rows]" 

if [ $# -ne 4 ]  ; then
	echo $usage
	exit 2
fi

dir=$1
lg=$2
env=$3
h=$4

if [[ $3 -lt 1 ]];then
	h=15
fi

cat $dir/Summary/lg$lg/HW/HW_$env.csv | tail -n +4 | awk -F ',' '{print $2}' | awk '{a[$0]++}END{for(x in a)print x,a[x]}' | sort -g | head -$h
