#!/bin/bash
#Runs the .gnu files that make the chart for $1 dirname

path="`dirname \"$0\"`"
cd $path

avg_UXL_file="../avg_UXL"
file_aux=UXL_aux
file_out=UXL_final
dirname=`basename $1`
time_jumps=(15 30 60 90 120 150)
#Tagnames of the tours should be named as above. Like tourname-tagname

for j_time in ${time_jumps[@]}
do
	cat $avg_UXL_file | grep $dirname | grep "\-$j_time:" | awk -v myt=$j_time '{print $4"\t"myt}' >> $file_aux
done
awk  'BEGIN{print "#UXL\tTiming\tTriangles"} NR%4==1 {$(NF+1)=17;} NR%4==2 {$(NF+1)=80;} NR%4==3 {$(NF+1)=131;} NR%4==0 {$(NF+1)=9;}1' OFS='\t' $file_aux >> $file_out

gnuplot charts3D.gnu
gnuplot charts_colored.gnu

rm $file_aux
cp $file_out $dirname'-'$file_out #Optional
rm $file_out
