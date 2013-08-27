#!/bin/bash
#Clears the cache of Squid or Google Earth depending on the input
usage="USAGE:$0 [1=Squid; 2=Google Earth; 3=Squid+Google Earth]"
if [ $# -ne 1 ]  ; then
	echo $usage
	exit 2
fi

THIS_PATH="`dirname \"$0\"`"
cd $THIS_PATH

if [ $1 -eq 1 ] ; then
	echo "Clearing squid cache"
	lg-squid-purge
elif [ $1 -eq 2 ] ; then
	echo "Clearing Google Earth Cache and restarting it, please wait"
	bash RestartGE.sh
elif [ $1 -eq 3 ] ; then
	echo "Clearing squid cache"
	lg-squid-purge
	echo "Clearing Google Earth Cache and restarting it, please wait"
	bash RestartGE.sh
else
	echo $usage
fi
