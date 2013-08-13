### Last plot
# change only plot command here
currentplot = currentplot + 1.2
set tmargin at screen top(currentplot,n,h,t,b)
set bmargin at screen bot(currentplot,n,h,t,b)

set xtics jumps format "%0.0f"
set xlabel "Time (s) [".jumps."s between jumps]"
set y2label lg_node


