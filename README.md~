LG_Benchmarking
===============

Monitoring and Benchmarking tools for Liquid Galaxy.
It allows to monitorize Liquid Galaxy while doing a tour, which reads from a txt file in order.
It shows CPU, Memory, Networking (external, internal [Squid] and synchronization [Viewsyncs]).

DIRECTORIES EXPLANATION
=================
LG_Benchmarking
|-Chart-gen # contains all required scripts to obtain charts from the benchmark data.
|-Others # The files inside this folder are miscellaneous or for future purposes
|-Scripts # The main application scripts
|-Tools # Additional tools


PREVIOUS-INSTALLATION
============
You need these applications installed in order to use LG_Benchmarking

In all nodes: tshark
Installation notes: After installing tshark you must give root access to it. Execute the following commands
sudo -s
groupadd wireshark
usermod -a -G wireshark lg
newgrp wireshark
chgrp wireshark /usr/bin/dumpcap
chmod 750 /usr/bin/dumpcap
setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

Master Only: 
-libcairo libpango libwxgtk (gnuplot libraries)
-gnuplot 4.6. Download it from http://www.gnuplot.info/ (Needed for the Chart-gen)
-sox (Needed for the finishing sound)

INSTALLATION
============
Install LG_Benchmarking inside /home/lg/LG_Benchmarking. If it is installed in another folder, please, configure the variables.conf to the new path.
Then, inside LG_Benchmarking run copyScripts to copy all the necessary scripts to the other nodes of the LG.
Now you are ready to use the Benchmarking tools.
If you would like to have the web application, please, get it from php-interface-benchmark https://code.google.com/r/asherat666-g-liquidgalaxy/, but the file change.php may need additional configuration regarding the paths

CONFIGURATION
=============
-If LG_Benchmarking is installed in another folder that /home/lg/LG_Benchmarking, please, configure the variables.conf to the new path
-If ~/personavars is not available in every node's HOME directory or the file is in another path, please, check Chart-gen/config.gnu to adjust the number of nodes 'n'.
-The file Scripts/tours.txt contains a list of tours for Scripts/fullBenchmark to do. You can change this list to perform other tour-tests that are included in the Scripts/queries.txt file. 
-To input tours inside tours.txt do it as follows: "[tourname] [seconds between jumps] [additional tag]" (E.G: Horsens 30 -s), where 'tourname' is the first name before '@' of an entry in Scripts/queries.txt and Additional_tag is a tag to differenciate between tours of the same name, like those with same name and different time between jumps in seconds. WARNING!: Right now the only accepted tag is -s because of the Chart-gen input file names
-The file Scripts/queries.txt should be filled with POIs with this pattern "tourname@@<query.txt input>" or "tourname@POI_name@<query.txt input>". You can create new rows using the Tools/kml2query.sh tool and copying it into queries.txt. To create easy tours read the kml2query file.


USAGE
=====
Please read the "INSTALLATION and CONFIGURATION" section first before continuing.
-To have an automatized benchmark, run Scripts/fullBenchmark.
-If you would like to perform a single tour (or maybe repeat it after the fullBenchmark), use /Scripts/Benchmark [tourname] [seconds between jumps] [additional tag] where tourname should be one of the tags from the queries.txt in Scripts (lleida, bcn, Horsens, etc), [seconds between jumps] is the time between each jump and "additional tag" is for differenciate between tours with the same name.
-After completing the benchmarking tool, execute Scripts/Analize to get the RAW data processed into readable CSVs. Then, you should execute Scripts/CopyData to gather all this information into the LG1 Summary dir. 
-If you would like to get charts from all the data obtained, execute Chart-gen/getCharts. The images will be inside Chart-gen/Charts including an UXL (User Experience Level) report.
-To clean all the RAW and Summary data use cleanBench. No charts will be deleted using this script
