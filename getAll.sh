#!/bin/bash
path="`dirname \"$0\"`"
cd $path

if [[ $2 != "3d" ]]
then
	echo "------Generating Charts------"
	./Charts-gen/getCharts.sh
	echo "------Calculating Average UXL------"
	./UXL-gen/get_avg_UXL.sh
fi
if [ $# -ne 0 ]  ; then
	dir=`basename $1`
	echo "------Creating 3D charts | $dir -----"
	./3dCharts-gen/get3DCharts.sh $dir
	mkdir 3DCharts -p
	mv UXL.png Charts3D/UXL-$dir.png
	mv UXL_colored.png Charts3D/UXL_colored-$dir.png
	gnome-open Charts3D/UXL-$dir.png
fi

