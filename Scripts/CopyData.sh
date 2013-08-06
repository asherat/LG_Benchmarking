#!/bin/bash

echo "$(hostname)----START COPYDATA----"

mkdir $summaryDir
mkdir $summaryDir/$(hostname)

$exeLG scp -r $hw lg1:$summaryDir/$(hostname)/HW
$exeLG scp -r $net lg1:$summaryDir/$(hostname)/NW

echo "All data has been copied"
echo "$(hostname)----END COPYDATA----"
