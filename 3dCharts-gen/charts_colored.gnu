#!/usr/bin/env gnuplot
file_out="UXL_final"

set term pngcairo enhanced size 800,600 font 'Helvetica,14'
set output '../UXL_colored.png'
set size square

set xlabel 'Timing Jumps (s)'
set ylabel 'Density (k Triangles)'
set zlabel 'UXL %'
set zrange[0:100]
set cblabel 'UXL %'
set cbrange[0:100]
set cbtics 5
unset key

set dgrid3d 45,45
set hidden3d
set pm3d map
#set palette rgbformulae 22,13,-31
splot file_out u 2:3:1

