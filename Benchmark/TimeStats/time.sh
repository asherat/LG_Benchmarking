#!/bin/bash
path="`dirname \"$0\"`"
cd $path

file_out=test
rm file_final
cat /dev/null > $file_out

pos=$(ls *.time | wc -l)
counter=0
for filen in `ls *.time`
do
	counter=$counter+1;
	aux_string+="$(echo $filen | awk -v fi=$filen -F- '{print $2}')\\\t"
	#cat $file_out | awk -v nom=$nombre '{print $0" "nom}'  > $file_out
done
IFS='-' read -a aux_array <<< "$aux_string"

for ((i=0;i<${#aux_array[@]};i++))
do
	list+=$(echo -e ${aux_array[$i]})
done

echo -e $list > $file_out

for filen in `ls *.time`
do
#echo ''
	cat $filen | awk '{print $1}'  > $filen.aux
done

paste *.aux  | column -s $'\t' -t >> $file_out.aux

cat $file_out $file_out.aux > file_final.aux

paste pois.conf file_final.aux > file_final

cat file_final

rm *.aux
