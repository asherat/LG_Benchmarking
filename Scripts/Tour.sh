#!/bin/bash

list=~/Benchmarking/Scripts/queries.txt
echo ----Starting tour $1----
awk -v time="$2" -F'@' '/'$1'/ {
print $2;
print $NF > "/tmp/query.txt";
close("/tmp/query.txt");
system("sleep "time"");
}' $list

echo ----Tour finished----
