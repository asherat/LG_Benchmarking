#!/bin/bash
#Allows to copy all scripts to other nodes
MY_PATH="`dirname \"$0\"`"
. $MY_PATH/variables.conf

exeLGslaves "mkdir $scriptsDir; scp -r lg1:scriptsDir/* scriptsDir/ && chmod +x scriptsDir/*.sh"

chmod +x $scriptsDir/*.sh
chmod +x $toolsDir/*.sh



