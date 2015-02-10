#!/bin/bash
#Calculate VR (Visualization Rate)
path="`dirname \"$0\"`"
. $path/../../Config/variables.conf
. $chartsCFG
cd $path/..

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [dirname]"
	exit 2
fi

name_dir=$1
num_nodes=`cat $clustersCFG | grep $name_dir | awk '{print $2}'`
mydir="Data/$name_dir/Summary"
VR_file="Charts/$name_dir/Summary_VR"
cat /dev/null > $VR_file


if [ ! -d $dir ]  ; then
	echo $usage
	echo "ERROR: $dir does not exist or is not a folder"
	exit 2
fi


function getVR {
usage="$0 [dir] [min_CPU_value]"
total=0
below=0
dir=$1
for filename in `ls $dir/*.csv -v`; do
	threshold=$($min_picker_path ../$filename)
	below=$(tail -n +4 "$filename" | awk -v minvalue=$threshold -F "," ' BEGIN {max=0} {if($2<=minvalue) {max=max+1};} END {print max}')
	total=$(cat $filename | tail -n 1 | awk -F "," '{print $1+1}')
	if [ $below -eq 0 ]
	then
		VR=0
	else
		VR=$(bc <<< "scale=2; $below*100 / $total")
	fi
	echo "$filename - Below: $below, total:$total, VR:$VR%"
done
}


#Get VR from each lg node
for (( c=0; c<$num_nodes; c++ ))
do
	getVR $mydir/lg$(($c+1))/HW  >> $VR_file
done

