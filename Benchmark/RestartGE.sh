#!/bin/bash
#Restarts the Google Earth and clears its cache. It waits for the Google Earth in all nodes to be running after the restart
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
source $THIS_PATH/../Config/variables.conf

time_sleep=7

echo "Clearing Google Earth cache"
$exeLG rm $userPath/.googleearth/Cache -R
echo "Restarting Google Earth"
$LGScriptsDir/startup-script.sh > /dev/null 2>&1

echo "Waiting for Google Earth start in all nodes"
sleep 2 # Killing a process takes a second and gets the old GE's PID. Just wait a bit to get the new PID
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

sleep $time_sleep
echo "Awake"


