if ( graph_type eq 'cpu' ){
	plot dir.lg_node.file_city every::1 using 1:($2/cores) with lines title 'city', dir.lg_node.file_town using 1:($2/cores) with lines title 'town', dir.lg_node.file_desert using 1:($2/cores) with lines title 'desert'
} 

if ( graph_type eq 'ram' || graph_type eq 'tcp' ) {
	plot dir.lg_node.file_city every::1 using 1:($3/1024) with lines title 'city', dir.lg_node.file_town using 1:($3/1024) with lines title 'town', dir.lg_node.file_desert using 1:($3/1024) with lines title 'desert'
}
