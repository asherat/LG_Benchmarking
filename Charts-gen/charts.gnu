#!/usr/bin/env gnuplot
dir="../Data/`cat current_dir.txt`/Summary/"

max_ram="`cat ram.max`"
max_tcp="`cat tcp.max`"

jumps=tag

#Filenames
hw='/HW/HW_'
external='/NW/NW_ext-'
internal='/NW/NW_squid-'
viewsync='/NW/NW_viewsync-'

filename1=filename1.'-'.tag
filename2=filename2.'-'.tag
filename3=filename3.'-'.tag


#------------------------------------------------------
#-----------------------Start--------------------------
#------------------------------------------------------

#CPU
file_city=hw.filename1.'.csv'
file_town=hw.filename2.'.csv'
file_desert=hw.filename3.'.csv'

set yrange [0:100]
set output 'cpu-'.tag.'.png'
load "config.gnu"
set ylabel 'CPU Usage %'
graph_type="cpu"
load "plotting.gnu"


#-----------------------------------------
#RAM
set yrange [0:max_ram]
set output 'ram-'.tag.'.png'
load "config.gnu"
set ylabel 'RAM Usage MB'
graph_type="ram_tcp"
load "plotting.gnu"


#-----------------------------------------
#External
file_city=external.filename1.'.csv'
file_town=external.filename2.'.csv'
file_desert=external.filename3.'.csv'

set yrange [0:max_tcp]
#set yrange [0:3000]
set output 'tcp_ext-'.tag.'.png'
load "config.gnu"
set ylabel 'External KB/s'
graph_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#Internal
file_city=internal.filename1.'.csv'
file_town=internal.filename2.'.csv'
file_desert=internal.filename3.'.csv'

set yrange [0:max_tcp]
#set yrange [0:3000]
set output 'tcp_squid-'.tag.'.png'
load "config.gnu"
set ylabel 'Internal KB/s'
graph_type="ram_tcp"
load "plotting.gnu"

#-----------------------------------------
#ViewSync
file_city=viewsync.filename1.'.csv'
file_town=viewsync.filename2.'.csv'
file_desert=viewsync.filename3.'.csv'

set yrange [0:20]
set output 'tcp_viewsync-'.tag.'.png'
load "config.gnu"
set ylabel 'ViewSync/s'
graph_type="ram_tcp"
load "plotting.gnu"

