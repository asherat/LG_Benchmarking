#!/bin/bash

lg-run-slaves "mkdir /home/lg/Benchmarking/Results; scp -r lg1:/home/lg/Benchmarking/Results/*.sh /home/lg/Benchmarking/Results/ && chmod +x /home/lg/Benchmarking/Results/*.sh"

chmod +x /home/lg/Benchmarking/Results/*.sh
chmod +x /home/lg/Benchmarking/Scripts/*.sh
chmod +x /home/lg/Benchmarking/Tools/*.sh


