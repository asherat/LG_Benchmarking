#!/usr/bin/env gnuplot

dir='./../Summary/'
file_city='/HW/HW_bcn.csv'
file_town='/HW/HW_Horsens.csv'
file_desert='/HW/HW_desierto.csv'

max_ram="`cat ram.max`"
max_tcp="`cat tcp.max`"
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

set yrange [0:max_ram]
set output 'ram.png'
load "config.gnu"
set ylabel 'RAM Usage MB'
gragh_type="ram_tcp"
load "plotting.gnu"


#-----------------------------------------
#External
file_city='/NW/NW_ext-bcn.csv'
file_town='/NW/NW_ext-Horsens.csv'
file_desert='/NW/NW_ext-desierto.csv'

set yrange [0:max_tcp]
#set yrange [0:3000]
set output 'tcp_ext.png'
load "config.gnu"
set ylabel 'External KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#Internal
file_city='/NW/NW_squid-bcn.csv'
file_town='/NW/NW_squid-Horsens.csv'
file_desert='/NW/NW_squid-desierto.csv'

set yrange [0:max_tcp]
#set yrange [0:3000]
set output 'tcp_squid.png'
load "config.gnu"
set ylabel 'Internal KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#ViewSync
file_city='/NW/NW_viewsync-bcn.csv'
file_town='/NW/NW_viewsync-Horsens.csv'
file_desert='/NW/NW_viewsync-desierto.csv'

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
file_city='/HW/HW_bcn-s.csv'
file_town='/HW/HW_Horsens-s.csv'
file_desert='/HW/HW_desierto-s.csv'
set yrange [0:100]
set output 'cpu-s.png'
load "config.gnu"
set ylabel 'CPU Usage %'
gragh_type="cpu"
load "plotting.gnu"


#-----------------------------------------
#RAM
set yrange [0:max_ram]
set output 'ram-s.png'
load "config.gnu"
set ylabel 'RAM Usage MB'
gragh_type="ram_tcp"
load "plotting.gnu"


#-----------------------------------------
#External
file_city='/NW/NW_ext-bcn-s.csv'
file_town='/NW/NW_ext-Horsens-s.csv'
file_desert='/NW/NW_ext-desierto-s.csv'

set yrange [0:max_tcp]
#set yrange [0:3000]
set output 'tcp_ext-s.png'
load "config.gnu"
set ylabel 'External KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#Internal
dir='./../Summary/'
file_city='/NW/NW_squid-bcn-s.csv'
file_town='/NW/NW_squid-Horsens-s.csv'
file_desert='/NW/NW_squid-desierto-s.csv'

set yrange [0:max_tcp]
#set yrange [0:3000]
set output 'tcp_squid-s.png'
load "config.gnu"
set ylabel 'Internal KB/s'
gragh_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#ViewSync
dir='./../Summary/'
file_city='/NW/NW_viewsync-bcn-s.csv'
file_town='/NW/NW_viewsync-Horsens-s.csv'
file_desert='/NW/NW_viewsync-desierto-s.csv'

set yrange [0:20]
set output 'viewsync-s.png'
load "config.gnu"
set ylabel 'ViewSync/s'
gragh_type="ram_tcp"
load "plotting.gnu"


