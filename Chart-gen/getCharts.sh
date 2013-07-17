#!/bin/bash
./getmax.sh
./cpu.sh
./cpu-s.sh
./ram.sh
./ram-s.sh
./tcp_ext.sh
./tcp_ext-s.sh
./tcp_squid.sh
./tcp_squid-s.sh
./tcp_viewsync.sh
./tcp_viewsync-s.sh
mkdir Charts
mv *.png Charts
rm *.max
