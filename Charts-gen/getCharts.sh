#!/bin/bash
#Gets the information from a every DIR inside Data/ to draw the charts with gnuplot
path="`dirname \"$0\"`"
cd $path

for filen in ../Data/*/;do
	#Initialization
	jump_times=( 15 30 60 90 120 150 )
	dirname=`basename $filen`

	./fixData.sh Data/$dirname

	mkdir "../Charts/$dirname" -p

	#UXL
	./UXL.sh $dirname

	#CHARTS
	for jump_time in ${jump_times[@]}; do
		tagname=$jump_time
		echo $dirname-$tagname
		echo $dirname > current_dir.txt
		./getmax.sh $dirname $tagname
		gnuplot -e "jumps=$jump_time" -e "tag='$tagname'" -e "filename1='bcn'" -e "filename2='Horsens'" -e "filename3='desierto'" charts.gnu
		mv *.png ../Charts/$dirname
	done

done

#Clean temps
rm *.max
rm current_dir.txt


