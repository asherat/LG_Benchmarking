#!/bin/bash

THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../variables.conf
cd $MY_PATH

if [ $# -lt 1 ]  ; then
	echo "USAGE:$0 [output]"
	exit 2
fi

output=$1

earth=`cat /tmp/Earth.tmp`
while [ true ]; do
	cat /proc/$earth/status | grep VmRSS >> $output
	sleep 1;
done
