#!/bin/bash
#Does a free benchmark. You can put an additional tag for the output file to differenciate between tours with the same name, for example, to make the same tour with 2 different timings

THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../Config/variables.conf
cd $MY_PATH

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Name]"
	exit 2
fi


name=$1
myDir=$rawDir

TsharkOut=$myDir/$name.pcap
TopOut=$myDir/$name.top
MemOut=$myDir/$name.mem

cmd_cpu='top -b -d 1 -p $(cat /tmp/Earth.tmp) > '$TopOut' &'
cat /dev/null > $MemOut
$exeLG "mkdir $myDir -p"

#Get Google Earth PID
$exeLG "pgrep googleearth-bin > /tmp/Earth.tmp"
$exeLG 'echo Google Earth running, PID: $(cat /tmp/Earth.tmp)'

#Empty previous records
$exeLG "cat /dev/null > $TsharkOut"
$exeLG "cat /dev/null > $TopOut"
$exeLG "cat /dev/null > $MemOut"

echo "Starting Free Mode Benchmark"
exec $exeLGbg tshark -i eth0 -q -w $TsharkOut & #Net
exec $exeLGbg $cmd_cpu &			#CPU
exec $exeLGbg $benchmarkDir/getRam.sh $MemOut &	#RAM

echo "Press any key to Stop..."
read -p "$*"

echo "Free Mode Benchmark Stopped"
exec $benchmarkDir/stopAll.sh

