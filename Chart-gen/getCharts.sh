#!/bin/bash
#This is the main script of the Charts generator. It will generate all charts from the Summary of the benchmarking into a new folder named Charts

path="`dirname \"$0\"`"
cd $path

mkdir Charts
./UXL.sh # For the UXL parameter

./getmax.sh # Get the max value of the CPU and the TCP data to be input as maxvalue in gnuplot
gnuplot charts.gnu # Generate graphs

mv *.png Charts
rm *.max

sudo cp Charts/* /var/www/benchmarking/img
