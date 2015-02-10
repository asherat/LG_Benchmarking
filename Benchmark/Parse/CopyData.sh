#!/bin/bash
#Copies all the data from the Analize part into the Summary directory

THIS_PATH="`dirname \"$0\"`"
. $THIS_PATH/../../Config/variables.conf

usage="$0 [cluster name]" 

if [ $# -ne 1 ]  ; then
	echo $usage
	exit 2
fi


echo "$(hostname)----START COPYDATA----"

clusterName=$1

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
if [[ $1 == "time" ]]
then
	mkdir -p "$rawDir/Time"
	cp $rawDir/*.time $rawDir/Time
	cp -r $rawDir/Time $summaryDir
fi

#Copy the data of all nodes into lg1
$exeLG "scp -r $rawDir/lg? lg1:$summaryDir"
mkdir -p $dataDir/$clusterName
rsync -a $summaryDir $dataDir/$clusterName

echo "All data has been copied"
echo "$(hostname)----END COPYDATA----"
