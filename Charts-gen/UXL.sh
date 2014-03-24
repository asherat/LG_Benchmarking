#!/bin/bash
path="`dirname \"$0\"`"
cd $path/..

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [dirname]"
	exit 2
fi

name_dir=$1
num_nodes=`cat clusters.conf | grep $name_dir | awk '{print $2}'`
mydir="Data/$name_dir/Summary"
UXL_file="Charts/$name_dir/Summary_UXL"
cat /dev/null > $UXL_file


if [ ! -d $dir ]  ; then
	echo $usage
	echo "ERROR: $dir does not exist or is not a folder"
	exit 2
fi


function getUXL {
usage="$0 [dir] [min_CPU_value]"
total=0
below=0
dir=$1
threshold=$2
for filename in `ls $dir/*.csv -v`; do
    below=$(tail -n +4 "$filename" | awk -v minvalue=$threshold -F "," ' BEGIN {max=0} {if($2<=minvalue) {max=max+1};} END {print max}')
	total=$(cat $filename | tail -n 1 | awk -F "," '{print $1}')

	if [ $below -eq 0 ]
	then
		UXL=0
	else
		UXL=$(bc <<< "scale=2; $below*100 / $total")
	fi
	echo "$filename - Below: $below, total:$total, UXL:$UXL%"
done
}

#Get threshold values
for (( c=1; c<=$num_nodes; c++ ))
do
	node_threshold+=( "$(cat clusters.conf | grep $name_dir | awk '{print $5}' | awk -v p_cores=$c -F',' '{print $p_cores}')" )
done

#Get UXL from each lg node
for (( c=0; c<$num_nodes; c++ ))
do
	getUXL $mydir/lg$(($c+1))/HW ${node_threshold[$c]} >> $UXL_file
done

