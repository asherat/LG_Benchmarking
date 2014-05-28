#!/bin/bash
#Get the average VR of every dir in Data/. The output is avg_VR

export LC_NUMERIC="en_US.UTF-8"
path="`dirname \"$0\"`"
cd $path/..
. Config/variables.conf

cat /dev/null > avg_VR
function getVR {

	dir=$1
	numlg=$2
	unset aux_string
	for (( env_pointer=1; env_pointer<=$num_env; env_pointer++ ))
	do
		aux_string+="$(cat $Summary_file | awk -v lg=$numlg -v env_pointer=$env_pointer -v total_env=$num_env -F':' 'NR==env_pointer+total_env*(lg-1){print $4}' | cut -d '%' -f 1  )-"
	done
	IFS='-' read -a aux_array <<< "$aux_string"
}

function reset_avg {
	unset avg
	for ((i=0 ;i<$num_env; i++))
	do 
		avg[$i]=0
	done

}

function add_avg {
for (( i=0; i<$num_env; i++ ))
	do
	avg[$i]=$(echo "${avg[$i]} + ${aux_array[$i]}" | bc)
done
}


function get_avg {
for ((i=0;i<${#avg[@]};i++))
do
	avg[$i]=$(echo "scale=2;${avg[$i]}/$num_nodes" | bc)
done
}


function print_avg {
values=($(cat $Summary_file | grep lg1 | awk -F ".csv - " '{print $1}' | awk -F "/HW_" '{print $NF}'))
count=0

for ((i=0;i<${#avg[@]};i++))
do
echo $(printf "$filen | ${values[$i]}: %.2f%%" ${avg[$i]}) >> avg_VR
count=$(($count+1))

done
}

for filename in Charts/*; do
	filen=$(echo $filename | awk -F'/' '{print $2}')
	Summary_file="$filename/Summary_VR"
	num_nodes=$(cat $clustersCFG | grep $filen | awk '{print $2}')
	num_env=$(echo $(cat $Summary_file | grep lg1 | wc -l) )
	reset_avg

	for (( c=0; c<$num_nodes; c++ ))
	do
		getVR $filename $(($c+1))
		add_avg
	done
	get_avg
	print_avg
done


