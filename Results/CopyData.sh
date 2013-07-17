#!/bin/bash

echo "$(hostname)----START ANALIZE----"

benchDir=/home/lg/Benchmarking/Results
hw=$benchDir/Resultados
net=$benchDir/Resultados_net
resumen=$benchDir/Resumen

cd /home/lg/Benchmarking/Results
mkdir $resumen
mkdir $resumen/lg1
mkdir $resumen/lg2
mkdir $resumen/lg3

scp -r lg2:$hw $resumen/lg2/HW
scp -r lg3:$hw $resumen/lg3/HW
cp -R $hw $resumen/lg1/HW

scp -r lg2:$net $resumen/lg2/NW
scp -r lg3:$net $resumen/lg3/NW
cp -R $net $resumen/lg1/NW


#rm -R $resumen/lg1/HW $resumen/lg1/NW
#rm -R $resumen/lg2/HW $resumen/lg2/NW
#rm -R $resumen/lg3/HW $resumen/lg3/NW
echo "$(hostname)----END ANALIZE----"
