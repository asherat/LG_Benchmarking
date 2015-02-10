#!/bin/bash
#Sometimes, when monitoring, at the end of the benchmark, the last rows are ahead of the stop time.
#This script deletes those unnecesary rows
path="`dirname \"$0\"`"
cd $path

dir=`basename $1`

for filename in `ls ../Data/$dir/Summary/lg?/HW/*.csv -v`; do
	awk -F "," '(NR<=3) {print $0}(NR>3 && NF==3) {print $0}' $filename > $filename"2"
	mv $filename"2" $filename
done

