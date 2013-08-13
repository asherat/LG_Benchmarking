### Single plot
# change only plot command here
currentplot = 1
set tmargin at screen top(currentplot,n,h,t,b)
set bmargin at screen bot(currentplot,n,h,t,b)
unset key
set xtics jumps format "%0.0f"
set xlabel "Time (s) [".jumps."s between jumps]"
#set y2label lg_node



