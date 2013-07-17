#!/bin/bash
echo ~
echo "$(hostname)----START AutoResults----"
if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results file]"
	exit 2
fi
cd ~/Benchmarking/Results
if [ ! -f "$1" ]; then
    echo "'$1' doesn't exist"
else

ResultDir="Result_$1"

mkdir $ResultDir

mkdir Resultados
mkdir Resultados_net

. GetResults.sh $1
. ParseResults.sh $1
. PacketsResults.sh $1

rm $ResultDir -R
fi
echo "$(hostname)----END AutoResults----"
