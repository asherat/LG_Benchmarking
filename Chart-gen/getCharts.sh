#!/bin/bash
mkdir Charts
./UXL.sh

./getmax.sh
gnuplot charts.gnu

mv *.png Charts
rm *.max
