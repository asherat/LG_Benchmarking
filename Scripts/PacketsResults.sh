#!/bin/bash
#Gets Networking Results
rawFile=$1

echo "$(hostname) |$rawFile|----START PacketResults----"
if [ $# -ne 1 ]  ; then
	echo "USAGE:$0 [Results file]"
	exit 2
fi

inFile="$rawDir/$rawFile.pcap"
outDir=$rawDir/"Result_$rawFile"

tempDir="$rawDir/TShark_$rawFile"
echo "Creating '$tempDir' directory"
mkdir $tempDir

echo "Chopping '$inFile' file"
tshark -r $inFile -R "!udp && !(ip.addr==10.42.42.1 && (ip.addr==10.42.42.2 || ip.addr==10.42.42.3) || ip.addr==10.42.42.2 && (ip.addr==10.42.42.1 || ip.addr==10.42.42.3) || ip.addr==10.42.42.3 && (ip.addr==10.42.42.2 || ip.addr==10.42.42.1))" -w $tempDir/external.pcap 
tshark -r $inFile -R "ip.addr==10.42.42.1 && (ip.addr==10.42.42.2 || ip.addr==10.42.42.3) || ip.addr==10.42.42.2 && (ip.addr==10.42.42.1 || ip.addr==10.42.42.3) || ip.addr==10.42.42.3 && (ip.addr==10.42.42.2 || ip.addr==10.42.42.1)" -w $tempDir/squid.pcap 
tshark -r $inFile -R "ip.dst==10.42.42.255" -w $tempDir/viewsync.pcap 
echo "Done Chopping '$inFile' file"

echo "Generating tshark reports"
tshark -q -nr $tempDir/external.pcap -z io,stat,1 | tail -n +8 | head -n -1 | awk 'BEGIN { print "\n,TCP,\ninterval,frames,Bytes" } { print NR","$2","$3}' > $net/NW_ext-$rawFile.csv
echo "Generated '$net/NW_$rawFile.csv'"
tshark -q -nr $tempDir/squid.pcap -z io,stat,1 | tail -n +8 | head -n -1 | awk 'BEGIN { print "\n,TCP,\ninterval,frames,Bytes" } { print NR","$2","$3}' > $net/NW_squid-$rawFile.csv
echo "Generated '$net/NW_squid-$rawFile.csv'"
tshark -q -nr $tempDir/viewsync.pcap -z io,stat,1 | tail -n +8 | head -n -1 | awk 'BEGIN { print "\n,TCP,\ninterval,frames,Bytes" } { print NR","$2","$3}' > $net/NW_viewsync-$rawFile.csv
echo "Generated '$net/NW_int-$rawFile.csv'"
echo "tshark reports generated"

echo "Generating Capinfos summary"
echo EXTERNAL > $net/NW-Summary_ext-$rawFile.txt
capinfos -xyzm $tempDir/external.pcap | tail -n +2 >> $net/NW-Summary_ext-$rawFile.txt
echo SQUID > $net/NW-Summary_squid-$rawFile.txt
capinfos -xyzm $tempDir/squid.pcap | tail -n +2 >> $net/NW-Summary_squid-$rawFile.txt
echo VIEWSYNC > $net/NW-Summary_viewsync-$rawFile.txt
capinfos -xyzm $tempDir/viewsync.pcap | tail -n +2 >> $net/NW-Summary_viewsync-$rawFile.txt
echo "Generated capinfos reports"

rm $tempDir -R
echo "Temp directory '$tempDir' deleted"

echo "$(hostname) |$rawFile|----END PacketResults----"
