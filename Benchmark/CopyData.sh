#!/bin/bash
#Copies all the data from the Analize part into the Summary directory

THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../Config/variables.conf

echo "$(hostname)----START COPYDATA----"

#Create dirs
for ((aux_var=1; aux_var<=$numLGs; aux_var++ ))
do
	mkdir $summaryDir/lg$aux_var -p
done

#Gather all the data in the same dir in every node
$exeLG 'mkdir -p '$rawDir'/$(hostname)/HW'
$exeLG 'mkdir -p '$rawDir'/$(hostname)/NW'
$exeLG 'cp -R '$hw'/* '$rawDir'/$(hostname)/HW'
$exeLG 'cp -R '$net'/* '$rawDir'/$(hostname)/NW'

#Copy the data of all nodes into lg1
$exeLG "scp -r $rawDir/lg? lg1:$summaryDir"

echo "All data has been copied"
echo "$(hostname)----END COPYDATA----"
