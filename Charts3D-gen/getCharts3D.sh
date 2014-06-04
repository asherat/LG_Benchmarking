#!/bin/bash
#Runs the .gnu files that make the chart for $1 dirname

path="`dirname \"$0\"`"
. $path/../Config/charts.conf
cd $path

avg_file="../avg_VR"
file_aux=VR_aux
file_out=VR_final
dirname=`basename $1`

#Tagnames of the tours should be named as above. Like tourname-tagname
for j_time in ${jump_times[@]}
do
	cat $avg_file | grep $dirname | grep "\-$j_time:" | awk -v myt=$j_time '{print $4"\t"myt}' >> $file_aux
done

awk -v bcn=$bcn -v Venice=$Venice -v Alps=$Alps -v Yosemite=$Yosemite -v Horsens=$Horsens -v desierto=$desierto 'BEGIN{print "#UXL\tTiming\tTriangles"} NR%6==1 {$(NF+1)=Alps;} NR%6==2 {$(NF+1)=Horsens;} NR%6==3 {$(NF+1)=Venice;} NR%6==4 {$(NF+1)=Yosemite;} NR%6==5 {$(NF+1)=bcn;} NR%6==0 {$(NF+1)=desierto;}1' OFS='\t' $file_aux >> $file_out
gnuplot charts3D.gnu
gnuplot charts_colored.gnu

rm $file_aux
cp $file_out $dirname'-'$file_out #Optional
rm $file_out
