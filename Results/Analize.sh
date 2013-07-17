#!/bin/bash

echo "$(hostname)----START ANALIZE----"

benchDir=~/Benchmarking/Results
hw=$benchDir/Resultados
net=$benchDir/Resultados_net
resumen=$benchDir/Resumen

cd ~/Benchmarking/Results

shopt -s globstar
for file in *.top; do
  ~/bin/lg-run-bg AutoResults.sh $file
done

mkdir $resumen

echo "$(hostname)----END ANALIZE----"

