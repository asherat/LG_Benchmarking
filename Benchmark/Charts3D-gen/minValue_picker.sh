#!/bin/bash
#Pass a dir, lg# tourname-tagname to get an orientative threshold number.
#Must pick it manually and set it in the clusters.conf file
#The output are 2 columns, the first is a value, the second is how many times it is repeated
#The recommendation is to pick a value which doesn't have many repetitions after the most repeated values (global minimum)

path="`dirname \"$0\"`"
cd $path/..
usage="$0 [dir] lg[X] [tourname-timing] OPTIONAL:[rowsToDisplay]" 

if [ $# -ne 3 ]  ; then
	echo $usage
	exit 2
fi

dir=$1
lg=$2
env=$3
h=$4
aux_file=aux_picker

if [[ $3 -lt 1 ]];then
	h=15
fi

#cat $dir/Summary/lg$lg/HW/HW_$env.csv | tail -n +4 | awk -F ',' '{print $2}' | awk '{a[$0]++}END{for(x in a)print x,a[x]}' | sort -g | head -$h > aux_picker

for file in `ls $dir/Summary/lg?/HW/*.csv`; do
cat $file | tail -n +4 | awk -F ',' '{print $2}' | awk '{a[$0]++}END{for(x in a)print x,a[x]}' | sort -g | head -$h > aux_picker

#AutoPick
echo "$file"
cat aux_picker
echo "----------"
cat aux_picker | awk 'NR==1 || $2 > 10{line=$1} END{print line+1}'
done
