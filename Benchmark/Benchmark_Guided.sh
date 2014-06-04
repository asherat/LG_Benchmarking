#!/bin/bash
#Does a benchmark using a tour from the queries.txt file. The user must press a key to jump from a point to another of the tour
#You can put an additional tag for the output file to differenciate between tours with the same name, for example, to make the same tour with 2 different timings

THIS_PATH="`dirname \"$0\"`"
cd $THIS_PATH
. $THIS_PATH/../variables.conf

function startTest {
	tourName=$1
	
	$exeLG "mkdir $rawDir"

	TsharkOut=$rawDir/$tourName-free.pcap
	TopOut=$rawDir/$tourName-free.top
	MemOut=$rawDir/$tourName-free.mem

	cmd_cpu='top -b -d 1 -p $(cat /tmp/Earth.tmp) > '$TopOut' &'
	cmd_mem_tmp='cat /proc/$(cat /tmp/Earth.tmp)/status | grep VmRSS'

	#Get Google Earth PID
	$exeLG "pgrep googleearth-bin > /tmp/Earth.tmp"
	#$exeLG 'echo Google Earth running, PID: $(cat /tmp/Earth.tmp)'

	#Empty previous records
	$exeLG "cat /dev/null > $TsharkOut"
	$exeLG "cat /dev/null > $TopOut"
	$exeLG "cat /dev/null > $MemOut"
	
	echo Start monitoring $tourName tour
	exec $exeLGbg tshark -i eth0 -q -w $TsharkOut &
	exec $exeLGbg $cmd_cpu &
	exec $exeLGbg $scriptsDir/getRam.sh $MemOut &	
}

function stopTest {
	echo Done monitoring $tourName tour
	./stopAll.sh
}


point=1
echo "Type tourname from [bcn, Yosemite, Alps, desierto, Venice, Horsens]"
read tourname

startTest $tourname
for i in `seq 1 8`
do
	query=$(cat queries.txt | grep $tourname | awk -F "@" -v point=$i 'NR==point{print $3}')
	echo $query > /tmp/query.txt
	poi=$(cat queries.txt | grep $tourname | awk -F "@" -v point=$i 'NR==point{print $2}')
	read -p "$i: You are in $poi"
done
stopTest

