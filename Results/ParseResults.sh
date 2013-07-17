#!/bin/bash
echo "$(hostname)----START ParseResults----"
if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results dir]"
	exit 2
fi
cd ~/Benchmarking/Results
directory="Result_$1"
user=$(hostname)
finaldir="Resultados"

if [ ! -d "$directory" ]; then
    echo "Dir '$directory' doesn't exist"
else

	temp=CSV_$1
	echo "Creating '$temp' temp dir"
	mkdir $temp

	cp $directory/*.csv $temp/

	echo "Mending all csv files"
	find ./$temp -type f -exec sed -i 's/,/./g;s/;/,/g' {} \;

	echo "Merging all csv files"
	paste -d',' $temp/*.csv > $finaldir/HW_$1.csv
	echo "Generated '$finaldir/HW_$1.csv'"
	
	rm $temp -R
	echo "Deleted '$temp' temp"

fi
echo "$(hostname)----END ParseResults----"
