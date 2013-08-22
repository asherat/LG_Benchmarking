#!/bin/bash
THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../variables.conf

echo "$(hostname)----START COPYDATA----"


mkdir $summaryDir
mkdir $summaryDir/lg1
mkdir $summaryDir/lg2
mkdir $summaryDir/lg3

$exeLG 'echo $(hostname) > /tmp/hostname'
cat_cmd="cat /tmp/hostname"

$exeLG 'mkdir -p '$rawDir'/$(hostname)/HW'
$exeLG 'mkdir '$rawDir'/$(hostname)/NW'
$exeLG 'cp -R '$hw'/* '$rawDir'/$(hostname)/HW'
$exeLG 'cp -R '$net'/* '$rawDir'/$(hostname)/NW; rm /tmp/hostname'

$exeLG "scp -r $rawDir/lg? lg1:$summaryDir"

echo "All data has been copied"
echo "$(hostname)----END COPYDATA----"
