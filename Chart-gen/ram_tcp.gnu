#RAM or TCP read from the files. They use the same columns
plot dir.lg_node.file_city every::1 using 1:($3/1024) with lines title 'city', dir.lg_node.file_town using 1:($3/1024) with lines title 'town', dir.lg_node.file_desert using 1:($3/1024) with lines title 'desert'
