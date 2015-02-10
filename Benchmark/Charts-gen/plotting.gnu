
if(n==1){
	lg_node='lg1'
	cores = `cat ../../Config/clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -F',' '{print $1}'`
	
	### Single plot
	# change only plot command here
	currentplot = 1
	set tmargin at screen top(currentplot,n,h,t,b)
	set bmargin at screen bot(currentplot,n,h,t,b)
	unset key
	set xtics jumps format "%0.0f"
	set xlabel "Time (s) [".jumps."s between jumps]"
	#set y2label lg_node
	### Single plot

	load "graphType.gnu"
	#load graph_type.".gnu"
}else{
	#Top plot
	lg_node='lg1'
	cores = `cat ../../Config/clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -F',' '{print $1}'`

	### First plot
	# change only plot command here
	currentplot = 1
	set tmargin at screen top(currentplot,n,h,t,b)
	set bmargin at screen bot(currentplot,n,h,t,b)
	unset key
	set xtics jumps format ""
	set y2label lg_node
	### First plot

	load "graphType.gnu"
	#load graph_type.".gnu"
	
	#Mid plot
	do for[N=2:n-1]{
		lg_node='lg'.N
		cores = real(system(sprintf("cat ../../Config/clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -v p_cores=%f -F',' '{print $p_cores}'", N)))
		### Middle plot
		# copy and paste this code to make more middle plots
		currentplot = currentplot + 1
		set tmargin at screen top(currentplot,n,h,t,b)
		set bmargin at screen bot(currentplot,n,h,t,b)

		unset title
		set y2label lg_node
		### Middle plot

		load "graphType.gnu"
		#load graph_type.".gnu"
	}
	
	#Bot plot
	lg_node='lg'.n
	cores = real(system(sprintf("cat ../../Config/clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -v p_cores=%f -F',' '{print $p_cores}'", n)))

	### Last plot
	# change only plot command here
	currentplot = currentplot + 1
	set tmargin at screen top(currentplot,n,h,t,b)
	set bmargin at screen bot(currentplot,n,h,t,b)

	set xtics jumps format "%0.0f"
	set xlabel "Time (s) [".jumps."s between jumps]"
	set y2label lg_node
	### Last plot

	load "graphType.gnu"
	#load graph_type.".gnu"
}
#Key plot

### Last (key) plot
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
### Last (key) plot

reset
