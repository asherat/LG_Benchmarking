#!/bin/bash
#Get the MAX number for gnuplot range on RAM and TCP

path="`dirname \"$0\"`"
cd $path

if [ $# -ne 2 ]  ; then
	echo "USAGE:$0 [dirname] [Timing Jump]"
	exit 2
fi

aux=0
name_dir=$1
dir="../Data/$name_dir/Summary"
if [ ! -d $dir ]  ; then
	echo "ERROR: $dir does not exist or is not a folder"
	exit 2
fi

tagname=$2

for filename in $dir/lg?/HW/HW_*-$tagname.csv; do
	echo $filename
    b=$(tail -n +4 "$filename" | awk -F "," '{if(max==""){max=$3}; if($3>max) {max=$3};} END {print max}')
	if [ $aux -lt $b ]; then
		aux=$b
	fi
done

aux=$(($aux/1024))
aux=$((($aux/1000+1)*1000)) #ROUNDED
echo RAM $aux MB
echo $aux > ram.max

aux=0
for filename in $dir/lg?/NW/NW_*-$tagname.csv; do
    b=$(tail -n +4 "$filename" | awk -F "," '{if(max==""){max=$3}; if($3>max) {max=$3};} END {print max}')
	if [ $aux -lt $b ]; then
		aux=$b
	fi
done

aux=$(($aux/1024))
aux=$((($aux/1000+1)*1000))  #ROUNDED
echo TCP $aux kB/s
echo $aux > tcp.max
