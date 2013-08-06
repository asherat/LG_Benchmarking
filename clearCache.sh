#!/bin/bash
#Clears the cache of Squid or Google Earth depending on the input
if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [1=Squid; 2=Google Earth]"
	exit 2
fi

if [ $1 -eq 1 ] ; then
	echo "Clearing squid cache"
	lg-squid-purge
	#/home/lg/bin/lg-squid-purge
elif [ $1 -eq 2 ] ; then
	echo "Clearing Google Earth Cache and restarting it, please wait"
	#/home/lg/bin/lg-run rm /home/lg/.googleearth/Cache -R
	lg-run rm $userPath/.googleearth/Cache -R
	killall googleearth-bin
else
	echo "USAGE:$0 [1=Squid; 2=Google Earth]"
fi
