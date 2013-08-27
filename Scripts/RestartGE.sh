#!/bin/bash

if [ -r ${HOME}/etc/shell.conf ]  ; then
	source ${HOME}/etc/shell.conf

else
	echo "Couldn't find shell.conf"
	exit 1
fi

[ -z "${LG_FRAMES}" ] && echo "LG_FRAMES is empty" && exit 1
[ -z "${LG_FRAMES_MAX}" ] && echo "LG_FRAMES_MAX is empty" && exit 1

lg-ctl-master

THIS_PATH="`dirname \"$0\"`"
source $THIS_PATH/../variables.conf

echo "Restarting Google Earth"
$exeLG rm $userPath/.googleearth/Cache -R
startup-script.sh > /dev/null 2>&1
sleep 2 #killing a process takes a second and catches the old GE's PID

echo "Waiting for Google Earth start in all nodes"
for (( i=1; i<=$LG_FRAMES_MAX; i++ )); do
	lg=lg$i
	ready="no"
	while [ "$ready" = "no" ]; do
	        if [ -z `ssh lg@$lg pgrep googleearth-bin` ]; then
			sleep 1
			continue
        	fi
	        ready=yes
		echo "$lg: found Google Earth PID: `ssh lg@$lg pgrep googleearth-bin`"
	done
	ready="no"
done
echo "Done Restarting Google Earth"

echo "Sleeping "$time_sleep"s until Google Earth stops moving"
time_sleep=7
sleep $time_sleep
echo "Awake"


