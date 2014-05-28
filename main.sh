#!/bin/bash
path="`dirname \"$0\"`"
cd $path
. Config/variables.conf

if [[ $2 != "3d" ]]
then
	
	for filen in Data/*/;do
		dirname=`basename $filen`
		echo "-----------Fixing Data if necessary------------"
		$chartsDir/fixData.sh $dirname
		echo "-----------Done Fixing Data------------"
		echo "------Generating VR for $dirname-------"
		mkdir "Charts/$dirname" -p
		$chartsDir/getSummary.sh $dirname
		echo "------Done Generating VR for $dirname-------"
	done
	echo "--------Generating Charts------"
	$chartsDir/getCharts.sh
	echo "------Calculating Average VR------"
	$charts3DDir/getAvg.sh
	echo "------Done Calculating Average VR------"
fi
if [ $# -ne 0 ]  ; then
	dir=`basename $1`
	echo "------Creating 3D charts | $dir -----"
	$charts3DDir/getCharts3D.sh $dir
	mkdir Charts3D -p
	mv VR.png Charts3D/VR-$dir.png
	mv VR_colored.png Charts3D/VR_colored-$dir.png
	#gnome-open $charts3DDir/VR-$dir.png
fi

