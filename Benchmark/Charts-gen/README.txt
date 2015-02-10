Almost all .gnu files are parts of the charts.gnu which is the main gnuplot script

The main files are:
getChart.sh - Gets the necessary information to draw the Chart from a single DIR
getCharts.sh - Gets all the necessary information to draw the Charts from a EVERY DIR
charts.gnu - Draws the Charts specified by the temp file "current_dir.txt". Uses the information given by the 2 bash scripts above
