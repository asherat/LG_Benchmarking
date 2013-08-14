#!/bin/bash
total=0
below=0
dir='./../Results/Summary'
cat /dev/null > Charts/Summary_UXL
for filename in $dir/lg?/HW/*.top.csv; do
    below=$(tail -n +4 "$filename" | awk -F "," ' BEGIN {max=0} {if($2<20) {max=max+1};} END {print max}')
	total=$(cat $filename | tail -n 1 | awk -F "," '{print $1}')


	if [ $below -eq 0 ]
	then
		UXL=0
	else
		UXL=$(bc <<< "scale=2; $below*100 / $total")
	fi
	echo "$filename - Below: $below, total:$total, UXL:$UXL%" >> Charts/Summary_UXL
done
