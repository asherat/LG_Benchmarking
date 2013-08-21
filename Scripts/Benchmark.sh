#!/bin/bash
#Does a benchmark using a tour from the queries.txt file with X time between jumps. You can put an additional tag for the output file to differenciate between tours with the same name, for example, to make the same tour with 2 different timings

THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../variables.conf

cd $MY_PATH

if [ $# -lt 2 ]  ; then
	echo "USAGE:$0 [Tag/TourName] [time] [Additional Tag]"
	exit 2
fi

tourName=$1
time=$2
tag=$3

filepath=~/Benchmarking/Scripts/Tour.sh
OutputPath=~/Benchmarking/Results

TsharkOut=$rawDir/$tourName$tag.pcap
TopOut=$rawDir/$tourName$tag.top
MemOut=$rawDir/$tourName$tag.mem

cmd_cpu='top -b -d 1 -p $(cat /tmp/Earth.tmp) > '$TopOut' &'
cmd_mem_tmp='cat /proc/$(cat /tmp/Earth.tmp)/status | grep VmRSS'
cat /dev/null > $MemOut
cmd_mem='watch -n 1 "'$cmd_mem_tmp' >> '$MemOut' &" > /dev/null 2>&1'

if [ -r $tourScript ] ; then

	$exeLG "mkdir $rawDir"

	$exeLG "pgrep googleearth-bin > /tmp/Earth.tmp"
	$exeLG 'echo Google Earth running, PID: $(cat /tmp/Earth.tmp)'

	echo Start monitoring $tourName tour
	exec $exeLGbg tshark -i eth0 -q -w $TsharkOut &
	exec $exeLGbg $cmd_cpu &
	exec $exeLGbgtt $cmd_mem &

	echo Starting $tourName tour
	$tourScript $tourName $time

	echo Done monitoring $tourName tour
	exec $exeLGsudo killall top tshark watch
	
	$exeLG rm /tmp/Earth.tmp
	$exeLG echo Deleted temp
else
	echo "$tourScript doesn't exist"
fi
