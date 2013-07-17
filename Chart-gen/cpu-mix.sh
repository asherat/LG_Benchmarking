#!/usr/bin/env gnuplot

dir='./../Results/Resumen/'
file_city='/HW/HW_bcn.top.csv'
file_town='/HW/HW_lleida.top.csv'
file_desert='/HW/HW_desierto.top.csv'
file_city_s='/HW/HW_bcn-s.top.csv'
file_town_s='/HW/HW_lleida-s.top.csv'
file_desert_s='/HW/HW_desierto-s.top.csv'

jumps=15
jumps_s=30
set yrange [0:100]
### n: change this parameter to equal the number of data sets to be plotted
n = 2.5
# t: top margin in pixels
t = 35.0
# b: key height in pixels (bottom margin)
b = 170.0
# h: height of output in pixels
h = 150.0*n + t + b

### define functions to help set top/bottom margins
top(i,n,h,t,b) = 1.0 - (t+(h-t-b)*(i-1)/n)/h 
bot(i,n,h,t,b) = 1.0 - (t+(h-t-b)*i/n)/h

### first set up some basic plot parameters
set term pngcairo enhanced size 800,h font 'Helvetica,14'
set output 'cpu-mix.png'

#set title 'Difference between Long and Short Timing Jumps'
set ylabel 'CPU Usage %'

set datafile separator ','
set multiplot layout (n+1),1
### First plot
# change only plot command here
currentplot = 1
set tmargin at screen top(currentplot,n,h,t,b)
set bmargin at screen bot(currentplot,n,h,t,b)
unset key
set xtics jumps
# format ""
set xlabel "Time (s) [".jumps."s between jumps]"
set y2label 'MASTER'
plot dir.'lg1'.file_city every::1 using 1:($2/4) with lines title "city", \
dir.'lg1'.file_town using 1:($2/4) with lines title "town", \
dir.'lg1'.file_desert using 1:($2/4) with lines title "desert"
### Middle plot
# copy and paste this code to make more middle plots
currentplot = currentplot + 1.8
set tmargin at screen top(currentplot,n,h,t,b)
set bmargin at screen bot(currentplot,n,h,t,b)

unset title

### Last plot
# change only plot command here

set xtics jumps
# format "%0.0f"
set xlabel "Time (s) [".jumps_s."s between jumps]"
set y2label 'MASTER'
plot dir.'lg1'.file_city_s every::1 using 1:($2/4) with lines title "city", \
dir.'lg1'.file_town_s using 1:($2/4) with lines title "town", \
dir.'lg1'.file_desert_s using 1:($2/4) with lines title "desert"

### Last (key) plot
set tmargin at screen bot(n,n,h,t,30)
set bmargin at screen 0
set key horizontal center center
set border 0
unset tics
unset xlabel
unset ylabel
unset y2label
set yrange [0:1]
plot 2 t 'City', \
     2 t 'Town', \
     2 t 'Desert'

unset multiplot
