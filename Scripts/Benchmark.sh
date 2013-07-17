#!/bin/bash

if [ $# -lt 2 ]  ; then
	echo "USAGE:$0 [Tag/TourName] [time] [Additional Tag]"
	exit 2
fi

tourname=$(basename $1 .sh)
filepath=~/Benchmarking/Scripts/Tour.sh
OutputPath=~/Benchmarking/Results
TsharkOut=$OutputPath/$1$3.top.pcap
TopOut=$OutputPath/$1$3.top
exeLG=/home/lg/bin/lg-run
exeLGbg=/home/lg/bin/lg-run-bg


tempt='top -b -d 1 -p $(cat /tmp/Earth.tmp) > '$TopOut' &'

echo $tempt
if [ -r $filepath ] ; then

	$exeLG "pgrep googleearth-bin > /tmp/Earth.tmp"
	$exeLG 'echo Google Earth running, PID: $(cat /tmp/Earth.tmp)'

	echo Start monitoring $tourname tour
	exec $exeLGbg tshark -i eth0 -q -w $TsharkOut &
	exec $exeLGbg $tempt &



	echo Starting $tourname tour
	$filepath $1 $2

	echo Done monitoring $tourname tour
	exec /home/lg/bin/lg-sudo killall top tshark
	$exeLG rm /tmp/Earth.tmp
	$exeLG echo Deleted temp
else
	echo "$filepath doesn't exist"
fi
