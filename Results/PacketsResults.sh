#!/bin/bash
echo "$(hostname)----START PacketResults----"
if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results file]"
	exit 2
fi
cd ~/Benchmarking/Results
PacketsFile="$1.pcap"
temp="TShark_$1"
finaldir="Resultados_net"

echo "Creating '$temp' dir"
mkdir $temp

echo "Chopping '$PacketsFile' file"
tshark -r $PacketsFile -R tcp.port==80 -w $temp/external.pcap
tshark -r $PacketsFile -R "ip.addr==10.42.42.1 && (ip.addr==10.42.42.2 || ip.addr==10.42.42.3)" -w $temp/squid.pcap 
tshark -r $PacketsFile -R ip.dst==10.42.42.255 -w $temp/viewsync.pcap 
echo "Done Chopping '$PacketsFile' file"

echo "Generating tshark reports"
tshark -q -nr $temp/external.pcap -z io,stat,1 | tail -n +8 | head -n -1 | awk 'BEGIN { print "\n,TCP,\ninterval,frames,Bytes" } { print NR","$2","$3}' > $finaldir/NW_ext-$1.csv
echo "Generated '$finaldir/NW_$1.csv'"
tshark -q -nr $temp/squid.pcap -z io,stat,1 | tail -n +8 | head -n -1 | awk 'BEGIN { print "\n,TCP,\ninterval,frames,Bytes" } { print NR","$2","$3}' > $finaldir/NW_squid-$1.csv
echo "Generated '$finaldir/NW_squid-$1.csv'"
tshark -q -nr $temp/viewsync.pcap -z io,stat,1 | tail -n +8 | head -n -1 | awk 'BEGIN { print "\n,TCP,\ninterval,frames,Bytes" } { print NR","$2","$3}' > $finaldir/NW_viewsync-$1.csv
echo "Generated '$finaldir/NW_int-$1.csv'"
echo "tshark reports generated"

echo "Generating Capinfos"
capinfos=$finaldir/NW-Summary_$1.txt
echo TCP > $capinfos
capinfos -xyzm $temp/external.pcap | tail -n +2 >> $capinfos
echo "Generated capinfos report 'NW-Summary_$1.txt'"

rm $temp -R
echo "Temp dir '$temp' deleted"

echo "$(hostname)----END PacketResults----"
