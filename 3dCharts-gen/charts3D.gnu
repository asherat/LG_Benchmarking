#!/usr/bin/env gnuplot
file_in="UXL_final"
set term pngcairo enhanced size 800,600 font 'Helvetica,14'
set output '../UXL.png'
set dgrid3d 20,20
set hidden3d

set title "UXL according to Density and Timing Jumps"
set xlabel 'Timing Jumps (s)'
set ylabel 'Density (k Triangles)'
set zlabel 'UXL %' offset 5,5
set zrange[0:100]
set ztics 10

set cntrparam levels 10
set contour both
#set pm3d at s hidden3d

set cblabel 'UXL %'
set cbrange[0:100]
set cbtics 10
set palette defined ( 0 "#bd2c29", 2 "#ffd35a", 6 "white")
set pm3d implicit at s hidden3d 100
set style line 100 lc rgb '#000000' lt 1 lw 0.6
unset key

splot file_in using 2:3:1 with lines


