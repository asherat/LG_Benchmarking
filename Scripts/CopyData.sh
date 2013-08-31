#!/bin/bash
#Copies all the data from the Analize part into the Summary directory

THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../variables.conf

echo "$(hostname)----START COPYDATA----"

mkdir $summaryDir
mkdir $summaryDir/lg1
mkdir $summaryDir/lg2
mkdir $summaryDir/lg3

$exeLG 'echo $(hostname) > /tmp/hostname'
cat_cmd="cat /tmp/hostname"

#Gather all the data in the same dir in every node
$exeLG 'mkdir -p '$rawDir'/$(hostname)/HW'
$exeLG 'mkdir '$rawDir'/$(hostname)/NW'
$exeLG 'cp -R '$hw'/* '$rawDir'/$(hostname)/HW'
$exeLG 'cp -R '$net'/* '$rawDir'/$(hostname)/NW; rm /tmp/hostname'

#Copy the data in all nodes into lg1
$exeLG "scp -r $rawDir/lg? lg1:$summaryDir"

$exeLG 'rm /tmp/hostname'

echo "All data has been copied"
echo "$(hostname)----END COPYDATA----"
