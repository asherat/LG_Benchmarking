#!/usr/bin/env gnuplot

dir='./../Results/Summary/'
file_city='/HW/HW_bcn.top.csv'
file_town='/HW/HW_Horsens.top.csv'
file_desert='/HW/HW_desierto.top.csv'
n = 3 ### n: change this parameter to equal the number of LG-nodes
#-----------------------------------------------------------------------------------
#-----------------------Short Timing Jump--------------------------
#-----------------------------------------------------------------------------------
jumps=30
#-----------------------------------------
#CPU
set yrange [0:100]
set output 'cpu.png'
load "config.gnu"
set ylabel 'CPU Usage %'
gragh_type="cpu"
load "plotting.gnu"


#-----------------------------------------
#RAM
set yrange [0:3000]
set output 'ram.png'
load "config.gnu"
set ylabel 'RAM Usage MB'
gragh_type="ram_tcp"
load "plotting.gnu"


#-----------------------------------------
#External
file_city='/NW/NW_ext-bcn.top.csv'
file_town='/NW/NW_ext-Horsens.top.csv'
file_desert='/NW/NW_ext-desierto.top.csv'

set yrange [0:3000]
set output 'tcp_ext.png'
load "config.gnu"
set ylabel 'External KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#Internal
file_city='/NW/NW_squid-bcn.top.csv'
file_town='/NW/NW_squid-Horsens.top.csv'
file_desert='/NW/NW_squid-desierto.top.csv'

set yrange [0:3000]
set output 'tcp_squid.png'
load "config.gnu"
set ylabel 'Internal KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#ViewSync
file_city='/NW/NW_viewsync-bcn.top.csv'
file_town='/NW/NW_viewsync-Horsens.top.csv'
file_desert='/NW/NW_viewsync-desierto.top.csv'

set yrange [0:20]
set output 'viewsync.png'
load "config.gnu"
set ylabel 'ViewSync/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------------------------------------------------
#-----------------------Long Timing Jump--------------------------
#-----------------------------------------------------------------------------------
jumps=60
#-----------------------------------------
#CPU
file_city='/HW/HW_bcn-s.top.csv'
file_town='/HW/HW_Horsens-s.top.csv'
file_desert='/HW/HW_desierto-s.top.csv'
set yrange [0:100]
set output 'cpu-s.png'
load "config.gnu"
set ylabel 'CPU Usage %'
gragh_type="cpu"
load "plotting.gnu"


#-----------------------------------------
#RAM
set yrange [0:3000]
set output 'ram-s.png'
load "config.gnu"
set ylabel 'RAM Usage MB'
gragh_type="ram_tcp"
load "plotting.gnu"


#-----------------------------------------
#External
file_city='/NW/NW_ext-bcn-s.top.csv'
file_town='/NW/NW_ext-Horsens-s.top.csv'
file_desert='/NW/NW_ext-desierto-s.top.csv'

set yrange [0:3000]
set output 'tcp_ext-s.png'
load "config.gnu"
set ylabel 'External KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#Internal
dir='./../Results/Summary/'
file_city='/NW/NW_squid-bcn-s.top.csv'
file_town='/NW/NW_squid-Horsens-s.top.csv'
file_desert='/NW/NW_squid-desierto-s.top.csv'

set yrange [0:3000]
set output 'tcp_squid-s.png'
load "config.gnu"
set ylabel 'Internal KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#ViewSync
dir='./../Results/Summary/'
file_city='/NW/NW_viewsync-bcn-s.top.csv'
file_town='/NW/NW_viewsync-Horsens-s.top.csv'
file_desert='/NW/NW_viewsync-desierto-s.top.csv'

set yrange [0:20]
set output 'viewsync-s.png'
load "config.gnu"
set ylabel 'ViewSync/s'
gragh_type="ram_tcp"
load "plotting.gnu"


