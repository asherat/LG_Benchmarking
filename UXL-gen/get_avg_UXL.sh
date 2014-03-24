#!/bin/bash
#Get the average UXL of every dir in Data/. The output is avg_UXL

export LC_NUMERIC="en_US.UTF-8"
path="`dirname \"$0\"`"
cd $path/..

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

function reset_avg_uxl {
	unset avg_uxl
	for ((i=0 ;i<$num_env; i++))
	do 
		avg_uxl[$i]=0
	done

}

function add_avg_uxl {
for (( i=0; i<$num_env; i++ ))
	do
	avg_uxl[$i]=$(echo "${avg_uxl[$i]} + ${uxl_array[$i]}" | bc)
done
}


function get_avg_uxl {
for ((i=0;i<${#avg_uxl[@]};i++))
do
	avg_uxl[$i]=$(echo "scale=2;${avg_uxl[$i]}/$num_nodes" | bc)
done
}


function print_avg_uxl {
values=($(cat $UXL_file | grep lg1 | awk -F ".csv - " '{print $1}' | awk -F "/HW_" '{print $NF}'))
count=0

for ((i=0;i<${#avg_uxl[@]};i++))
do
echo $(printf "$filen | ${values[$i]}: %.2f%%" ${avg_uxl[$i]}) >> avg_UXL
count=$(($count+1))

done
}

for filename in Charts/*; do
	filen=$(echo $filename | awk -F'/' '{print $2}')
	UXL_file="$filename/Summary_UXL"
	num_nodes=$(cat clusters.conf | grep $filen | awk '{print $2}')
	num_env=$(echo $(cat $UXL_file | grep lg1 | wc -l) )
	reset_avg_uxl
	for (( c=0; c<$num_nodes; c++ ))
	do
		getUXL $filename $(($c+1))
		add_avg_uxl
	done
	get_avg_uxl
	print_avg_uxl
done


