#!/bin/bash

echo $(awk '/<LookAt>/,/<\/LookAt>/{if (/<LookAt>/) print "\nbcn@flytoview="$0; else print}' bcn.kml) | sed -e 's/ //g;s/bcn@/\nbcn@/g' > queries.txt

