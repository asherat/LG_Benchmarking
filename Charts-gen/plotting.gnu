
if(n==1){
	lg_node='lg1'
	cores = `cat ../clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -F',' '{print $1}'`
	load "single.gnu"
	load graph_type.".gnu"
}else{
	#Top plot
	lg_node='lg1'
	cores = `cat ../clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -F',' '{print $1}'`
	load "top.gnu"
	load graph_type.".gnu"
	
	#Mid plot
	do for[N=2:n-1]{
		lg_node='lg'.N
		cores = real(system(sprintf("cat ../clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -v p_cores=%f -F',' '{print $p_cores}'", N)))
		load "mid.gnu"
		load graph_type.".gnu"
	}
	
	#Bot plot
	lg_node='lg'.n
	cores = real(system(sprintf("cat ../clusters.conf | grep $(cat current_dir.txt) | awk '{print $4}' | awk -v p_cores=%f -F',' '{print $p_cores}'", n)))
	load "bot.gnu"
	load graph_type.".gnu"
}
#Key plot
load "key.gnu"
reset
