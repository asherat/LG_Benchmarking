#CPU read from the files
plot dir.lg_node.file_city every::1 using 1:($2/4) with lines title 'city', dir.lg_node.file_town using 1:($2/4) with lines title 'town', dir.lg_node.file_desert using 1:($2/4) with lines title 'desert'
