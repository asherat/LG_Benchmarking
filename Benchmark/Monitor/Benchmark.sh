#!/bin/bash
#Does a benchmark using a tour from the queries.txt file. The user must press a key to jump from a point to another of the tour
#You can put an additional tag for the output file to differenciate between tours with the same name, for example, to make the same tour with 2 different timings

THIS_PATH="`dirname \"$0\"`"
cd $THIS_PATH
. $THIS_PATH/../../Config/variables.conf

usage="USAGE:$0 [TourName] [Timing] (Special Timings = free, guided)"
function inputCheck {

if [ $# -ne 2 ]  ; then
	echo $usage
	exit 2
fi
	tourName=$1
	timing=$2

	case $2 in
	"free")
		echo "---Free Benchmarking---"
		echo "Type additional tag"
		read tag2
		tag="$tag2-free"
		isFree=true
		;;
	"guided")
		echo "---Guided Benchmarking---"
		echo "Type additional tag"
		read tag2
		tag="$tag2-guided"
		isGuided=true
		;;
	*)
		echo "---Automatic Benchmarking---"
		case $tourName in
		  "Alps" | "Barcelona" | "Horsens" | "Lleida" |"Madrid" | "NewYork" | "Sahara" | "Venice" | "Yosemite" )
			#Check that timing is a number
			if [[ $timing =~ ^-?[0-9]+$ ]]; then
				tag=$timing
			else
				echo "$timing is not a number valid for timing jumps"
				exit
			fi
			;;
		*)
			echo "Tourname must be one of the following"
			echo "Alps, Barcelona, Horsens, Lleida, Madrid, NewYork, Sahara, Venice, Yosemite, Horsens"
			exit
			;;
		esac
	esac

}
function initTest {

	inputCheck $1 $2

	$exeLG "mkdir -p $rawDir"

	#Set filenames
	TsharkOut=$rawDir/$tourName-$tag.pcap
	TopOut=$rawDir/$tourName-$tag.top
	MemOut=$rawDir/$tourName-$tag.mem
	echo "Filenames:"
	echo $TsharkOut
	echo $TopOut
	echo $MemOut

	#Empty previous records
	$exeLG "cat /dev/null > $TsharkOut"
	$exeLG "cat /dev/null > $TopOut"
	$exeLG "cat /dev/null > $MemOut"
	
	#Commands to be run
	cmd_cpu='top -b -d 1 -p $(cat /tmp/Earth.tmp) > '$TopOut' &'
	cmd_mem_tmp='cat /proc/$(cat /tmp/Earth.tmp)/status | grep VmRSS'

	if [ $isGuided ]; then
		TimeOut=$rawDir/$tourName-$tag.time
		cat /dev/null > $TimeOut
		date1=$(date +'%s')
		lastPoi="Start"
		point=1
	fi
}

function startTest {
	
	#Get Google Earth PID
	$exeLG "pgrep googleearth-bin > /tmp/Earth.tmp"
	
	echo Start monitoring $tourName tour
	exec $exeLGbg tshark -i eth0 -q -w $TsharkOut &
	exec $exeLGbg $cmd_cpu &
	exec $exeLGbg $ramScript $MemOut &	
}

function stopTest {
	echo "Done monitoring $tourName tour"
	./stopAll.sh
}

function getTime { #Guided
	date2=$(date +'%s')
	diff=$(($date2-$date1))
	echo "$(($diff)) seconds from $lastPoi to $poi." >> $TimeOut

	date1=$date2
	lastPoi=$poi
}

function doBenchmark {
	if [ $isGuided ]; then
		echo "Started $tourName Guided Tour"
		numPoints=$(cat queries.txt | grep $tourName | wc -l)
		for i in `seq 1 $numPoints`
		do
			query=$(cat queries.txt | grep $tourName | awk -F "@" -v point=$i 'NR==point{print $3}')
			echo $query > /tmp/query.txt
			poi=$(cat queries.txt | grep $tourName | awk -F "@" -v point=$i 'NR==point{print $2}')
			read -p "$i: You are in $poi"
			getTime

		done
	elif [ $isFree ]; then
		echo "Started $tourName Free Tour"
		echo "Press any key to Stop..."
		read -p "$*"
	else
		echo "Started $tourName Automatic tour"
		$tourScript $tourName $timing
	fi
}

initTest $1 $2
startTest
doBenchmark
stopTest
