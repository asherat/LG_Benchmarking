
if(n==1){
	lg_node='lg1'
	load "single.gnu"
	load gragh_type.".gnu"
}else{
	#Top plot
	lg_node='lg1'
	load "top.gnu"
	load gragh_type.".gnu"
	
	#Mid plot
	do for[N=2:n-1]{
		lg_node='lg'.N
		load "mid.gnu"
		load gragh_type.".gnu"
	}
	
	#Bot plot
	lg_node='lg'.n
	load "bot.gnu"
	load gragh_type.".gnu"
}
#Key plot
load "key.gnu"
reset
