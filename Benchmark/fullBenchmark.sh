#!/bin/bash
#Automatizes the process of running all the tours in the file "tours.txt" and clearing cache between tours. When this script finishes, a sound is played
#Tours.txt should be as follows "tourname seconds_between_jumps additional_tag"
#Where 'tourname' is the first name before '@' of an entry in Benchmark/queries.txt
#Additional_tag is a tag to differenciate between tours of the same name, like those with same name and different time between jumps in seconds

THIS_PATH="`dirname \"$0\"`"
cd $THIS_PATH

# Read the tours from the "tours.txt" and puts them into an array
echo "Reading tours.txt"
index=0
while read line ; do
[ -z "$line" ] && continue
    LIST[$index]="$line"
    index=$(($index+1))
done < tours.txt

echo "----Starting full benchmark----"
for tour in  "${LIST[@]}"; do
	bash clearCache.sh 3	# Clears the cache
	bash Benchmark.sh $tour	# Runs the Tour
done
echo "----Finished full benchmark----"
play ../Others/tada.wav > /dev/null 2>&1
