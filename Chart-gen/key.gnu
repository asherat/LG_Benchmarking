### Key plot
set tmargin at screen bot(n,n,h,t,30)
set bmargin at screen 0
set key horizontal center center
set border 0
unset tics
unset xlabel
unset ylabel
unset y2label
set yrange [0:1]
plot 2 t 'City', \
     2 t 'Town', \
     2 t 'Desert'

unset multiplot
