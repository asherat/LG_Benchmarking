#!/bin/bash
#Gets the max from the CPU and the TCP for the gnuplot y_maxvalue
a=0
dir='./../Summary'
for filename in $dir/lg?/HW/HW_*; do
    b=$(tail -n +4 "$filename" | awk -F "," '{if(max==""){max=$3}; if($3>max) {max=$3};} END {print max}')
	if [ $a -lt $b ]; then
		a=$b
	fi
done

a=$(($a/1024))
a=$((($a/1000+1)*1000)) #ROUNDED
#echo RAM $a MB #Debug
#a=1000 # You may input a manual value here
echo $a > ram.max

a=0
for filename in $dir/lg?/NW/NW_*; do
    b=$(tail -n +4 "$filename" | awk -F "," '{if(max==""){max=$3}; if($3>max) {max=$3};} END {print max}')
	if [ $a -lt $b ]; then
		a=$b
	fi
done

a=$(($a/1024))
a=$((($a/1000+1)*1000))  #ROUNDED
#echo TCP $a kB/s #Debug
#a=1000 # You may input a manual value here
echo $a > tcp.max
