#!/bin/bash
#This script cleans all results from the nodes.
#It can clean the Raw files obtained at monitoring and the Result files obtained at analizing
if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [1=summary; 2=raws]"
	exit 2
fi

#Summary
if [ $1 -eq 1 ] ; then
lg-run-slaves rm -R $summaryDir
#Raws
elif [ $1 -eq 2 ] ; then
lg-run-slaves rm -R $rawDir
else
	echo "USAGE:$0 [1=summary; 2=raws]"
fi









