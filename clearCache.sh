#!/bin/bash

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [1=Squid; 2=GE]"
	exit 2
fi

if [ $1 -eq 1 ] ; then
	echo "Clearing squid cache"
	/home/lg/bin/lg-squid-purge
elif [ $1 -eq 2 ] ; then
	/home/lg/bin/lg-run rm /home/lg/.googleearth/Cache -R
	killall googleearth-bin
else
	echo "USAGE:$0 [1=Squid; 2=GE]"
fi
