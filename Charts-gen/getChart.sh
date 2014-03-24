#!/bin/bash
#Gets the information from a single DIR $1 to draw its chart with gnuplot
path="`dirname \"$0\"`"
cd $path

usage="USAGE:$0 [dirname] [Timing Jump]"
if [ $# -ne 2 ]  ; then
	echo $usage
	exit 2
fi
if [ ! -d $1 ]  ; then
	echo $usage
	echo "$1 does not exist or is not a folder"
	exit 2
fi
exit
#Initialization
dirname=`basename $1`
jump_time=$2
tagname=$2
mkdir "../Charts/$dirname" -p

#UXL
./UXL.sh $dirname

#CHARTS
./getmax.sh $dirname $tagname
echo $dirname
echo $dirname > current_dir.txt
gnuplot -e "jumps=$jump_time" -e "tag='$tagname'" -e "filename1='bcn'" -e "filename2='Horsens'" -e "filename3='desierto'" charts.gnu
mv *.png ../Charts/$dirname

#Clean temps
rm *.max
rm current_dir.txt

