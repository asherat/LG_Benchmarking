#!/bin/bash
#Emergency stop
lg-run "killall -q top tshark getRam.sh"
lg-run "rm /tmp/Earth.tmp"
killall -q fullBenchmark.sh fullBenchmark_shutdown.sh Benchmark_nonStop.sh
