#!/bin/bash
#Gets the information from every DIR inside Data/ to draw the charts with gnuplot
path="`dirname \"$0\"`"
. $path/../../Config/variables.conf
. $path/../../Config/charts.conf
cd $path

for filen in ../Data/*/;do
	dirname=`basename $filen`

	for jump_time in ${jump_times[@]}; do
		echo $dirname-$jump_time
		echo $dirname > current_dir.txt
		./getmax.sh $dirname $jump_time
		#gnuplot -e "tag='$jump_time'" -e "filename1='bcn'" -e "filename2='Horsens'" -e "filename3='desierto'" charts.gnu
		gnuplot -e "tag='2'" -e "filename1='Lleida'" -e "filename2='Lleida'" -e "filename3='Lleida'" charts.gnu
		mkdir -p $chartsDir/$dirname &&mv *.png $chartsDir/$dirname
	done

done

#Clean temps
rm *.max
rm current_dir.txt


