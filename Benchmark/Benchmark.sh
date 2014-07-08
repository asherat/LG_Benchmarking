#!/bin/bash
#Does a benchmark using a tour from the queries.txt file with X time between jumps. You can put an additional tag for the output file to differenciate between tours with the same name, for example, to make the same tour with 2 different timings

THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../Config/variables.conf
cd $MY_PATH

if [ $# -lt 2 ]  ; then
	echo "USAGE:$0 [Tag/TourName] [time] [Additional Tag]"
	exit 2
fi


tourName=$1
time=$2
tag=$3

TsharkOut=$rawDir/$tourName$tag.pcap
TopOut=$rawDir/$tourName$tag.top
MemOut=$rawDir/$tourName$tag.mem

cmd_cpu='top -b -d 1 -p $(cat /tmp/Earth.tmp) > '$TopOut' &'
cmd_mem_tmp='cat /proc/$(cat /tmp/Earth.tmp)/status | grep VmRSS'
cat /dev/null > $MemOut

if [ -r $tourScript ] ; then

	$exeLG "mkdir $rawDir"

	#Get Google Earth PID
	$exeLG "pgrep googleearth-bin > /tmp/Earth.tmp"
	$exeLG 'echo Google Earth running, PID: $(cat /tmp/Earth.tmp)'

	#Empty previous records
	$exeLG "cat /dev/null > $TsharkOut"
	$exeLG "cat /dev/null > $TopOut"
	$exeLG "cat /dev/null > $MemOut"
	
	echo Start monitoring $tourName tour
	exec $exeLGbg tshark -i eth0 -q -w $TsharkOut &
	exec $exeLGbg $cmd_cpu &

	exec $exeLGbg $benchmarkDir/getRam.sh $MemOut &	

	echo Starting $tourName tour
	$tourScript $tourName $time

	echo Done monitoring $tourName tour
	$exeLG killall top tshark getRam.sh
	$exeLG rm /tmp/Earth.tmp
else
	echo "$tourScript doesn't exist"
fi