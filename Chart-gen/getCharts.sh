#!/bin/bash
path="`dirname \"$0\"`"
cd $path

mkdir Charts
./UXL.sh

./getmax.sh
gnuplot charts.gnu

mv *.png Charts
rm *.max
