#!/bin/bash
THIS_PATH="`dirname \"$0\"`"
cd $THIS_PATH

index=0
while read line ; do
[ -z "$line" ] && continue
    LIST[$index]="$line"
    index=$(($index+1))
done < tours.txt
echo ----Starting full benchmark----
for tour in  "${LIST[@]}"; do
	bash clearCache.sh 3
	bash Benchmark.sh $tour
done
echo ----Finished full benchmark----
play ../Others/tada.wav
