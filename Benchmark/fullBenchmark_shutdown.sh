#!/bin/bash
THIS_PATH="`dirname \"$0\"`"
cd $THIS_PATH

./fullBenchmark.sh
lg-sudo "shutdown -h 0"
