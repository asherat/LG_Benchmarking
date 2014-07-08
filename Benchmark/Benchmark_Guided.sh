#!/bin/bash
#Does a benchmark using a tour from the queries.txt file. The user must press a key to jump from a point to another of the tour
#You can put an additional tag for the output file to differenciate between tours with the same name, for example, to make the same tour with 2 different timings

THIS_PATH="`dirname \"$0\"`"
cd $THIS_PATH
. $THIS_PATH/../Config/variables.conf

function startTest {
	
	#Get Google Earth PID
	$exeLG "pgrep googleearth-bin > /tmp/Earth.tmp"

	#Empty previous records
	$exeLG "cat /dev/null > $TsharkOut"
	$exeLG "cat /dev/null > $TopOut"
	$exeLG "cat /dev/null > $MemOut"
	
	echo Start monitoring $tourName tour
	exec $exeLGbg tshark -i eth0 -q -w $TsharkOut &
	exec $exeLGbg $cmd_cpu &
	exec $exeLGbg $benchmarkDir/getRam.sh $MemOut &	
}

function stopTest {
	echo Done monitoring $tourName tour
	./stopAll.sh
}
function initTime {

	$exeLG "mkdir $rawDir"

	TsharkOut=$rawDir/$tourName-$name-guided.pcap
	TopOut=$rawDir/$tourName-$name-guided.top
	MemOut=$rawDir/$tourName-$name-guided.mem

	cmd_cpu='top -b -d 1 -p $(cat /tmp/Earth.tmp) > '$TopOut' &'
	cmd_mem_tmp='cat /proc/$(cat /tmp/Earth.tmp)/status | grep VmRSS'


	TimeOut=$rawDir/$tourName-$name-guided.time
	cat /dev/null > $TimeOut
	date1=$(date +'%s')
	lastPoi="Start"
}

function getTime {
	date2=$(date +'%s')
	diff=$(($date2-$date1))
	echo "$(($diff)) seconds from $lastPoi to $poi." >> $TimeOut

	date1=$date2
	lastPoi=$poi
}

point=1
echo "Type tourname from [NewYork, Madrid, bcn, Yosemite, Alps, desierto, Venice, Horsens]"
read tourName
echo "Type name"
read name
initTime
startTest $tourName $name
numPoints=$(cat queries.txt | grep $tourName | wc -l)
for i in `seq 1 $numPoints`
do
	query=$(cat queries.txt | grep $tourName | awk -F "@" -v point=$i 'NR==point{print $3}')
	echo $query > /tmp/query.txt
	poi=$(cat queries.txt | grep $tourName | awk -F "@" -v point=$i 'NR==point{print $2}')
	read -p "$i: You are in $poi"
	getTime

done
stopTest
