set title "Usability Tests"
#set auto x
set yrange [0:300]
set size 1, 1
set terminal png size 1920,1080 font 'Verdana,20'
set output 'canvas.png'
set style data histogram
set style histogram cluster gap 3
set style fill solid border -1
set boxwidth 0.9
set xtic scale 0
set ylabel "Time spent in POI (s)"
set xlabel "POI (Place of Interest)"
set arrow from -0.5,158 to 0.5,158 nohead lw 5 lc rgb "grey" front
set arrow from 0.5,39 to 1.5,39 nohead lw 5 lc rgb "grey" front
set arrow from 1.5,88 to 2.5,88 nohead lw 5 lc rgb "grey" front
set arrow from 2.5,70 to 3.5,70 nohead lw 5 lc rgb "grey" front
set arrow from 3.5,144 to 4.5,144 nohead lw 5 lc rgb "grey" front
set arrow from 4.5,118 to 5.5,118 nohead lw 5 lc rgb "grey" front
plot for [col=2:14] 'file_final' using col:xtic(1) title columnhead, \
for [col=2:14] 'file_final' u (column(0)-1.5+0.063*(col+1/2)):col:col notitle w labels, \
1e20 lc rgb 'gray' lw 5 t 'Loading Time'
#plot "file_final" using 2: xtic(1), '' u 3, '' u 4, '' u 5
#plot 'file_final' using 2:xtic(1) ti col fc rgb C, '' u 3 ti col fc rgb Cpp, '' u 4 ti col fc rgb Java, '' u 5 ti col fc rgb Python
