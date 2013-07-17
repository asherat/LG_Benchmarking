#!/bin/bash

if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [1=results; 2=raws]"
	exit 2
fi

if [ $1 -eq 1 ] ; then
/home/lg/bin/lg-run-slaves rm -R /home/lg/Benchmarking/Results/Resultados /home/lg/Benchmarking/Results/Resultados_net
rm /home/lg/Benchmarking/Results/Resumen
elif [ $1 -eq 2 ] ; then
/home/lg/bin/lg-run-slaves rm /home/lg/Benchmarking/Results/*.pcap /home/lg/Benchmarking/Results/*.top
rm /home/lg/Benchmarking/Results/*.pcap /home/lg/Benchmarking/Results/*.top
else
	echo "USAGE:$0 [1=Squid; 2=GE]"
fi









