#!/bin/bash
#Get the UXL of a specified single node from a specified dir

export LC_NUMERIC="en_US.UTF-8"
path="`dirname \"$0\"`"
cd $path/..

usage="$0 [dirname in Charts folder] lg[X]" 

if [ $# -ne 2 ]  ; then
	echo $usage
	exit 2
fi

filename=$1
numlg=$2

echo $1
if [ ! -d $filename ]  ; then
	echo $usage
	echo "ERROR: $dir does not exist or is not a folder"
	exit 2
fi
cat /dev/null > avg_UXL

function getUXL {
	dir=$1
	numlg=$2
	unset uxl_string
	for (( env_pointer=1; env_pointer<=$num_env; env_pointer++ ))
	do
		uxl_string+="$(cat $UXL_file | awk -v lg=$numlg -v env_pointer=$env_pointer -v total_env=$num_env -F':' 'NR==env_pointer+total_env*(lg-1){print $4}' | cut -d '%' -f 1  )-"
	done
	IFS='-' read -a uxl_array <<< "$uxl_string"
}



function print_uxl {
values=($(cat $UXL_file | grep lg1 | awk -F ".csv - " '{print $1}' | awk -F "/HW_" '{print $NF}'))
count=0

for ((i=0;i<$num_env;i++))
do
	echo "$filen | ${values[$i]}: ${uxl_array[$i]}%"
	count=$(($count+1))
done
}

filen=$(echo $filename | awk -F'/' '{print $2}')
UXL_file=$filename"Summary_UXL"
num_env=$(echo $(cat $UXL_file | grep lg1 | wc -l) )
getUXL $filename $numlg

print_uxl

