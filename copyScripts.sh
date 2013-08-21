#!/bin/bash
#Allows to copy all scripts to other nodes
MY_PATH="`dirname \"$0\"`"
. $MY_PATH/variables.conf

$exeLGslaves "mkdir $benchDir && mkdir $scriptsDir; scp lg1:$benchDir/variables.conf $benchDir; scp -r lg1:$scriptsDir/* $scriptsDir/ && chmod +x $scriptsDir/*.sh"

chmod +x $scriptsDir/*.sh
chmod +x $toolsDir/*.sh



