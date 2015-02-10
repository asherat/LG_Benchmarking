#!/bin/bash
#Copy the scripts from lg1 to the other nodes in order to perform the benchmarking tasks
MY_PATH="`dirname \"$0\"`"
. $MY_PATH/Config/variables.conf

chmod +x $monitorDir/*.sh
chmod +x $parseDir/*.sh
chmod +x $toolsDir/*.sh

$mainDir/cleanScripts.sh

$exeLGslaves "mkdir $configDir -p && scp lg1:$configDir/variables.conf $configDir; mkdir $monitorDir -p && scp -r lg1:$monitorDir/* $monitorDir && chmod +x $monitorDir/*.sh; mkdir $parseDir -p && scp -r lg1:$parseDir/* $parseDir && chmod +x $parseDir/*.sh"


