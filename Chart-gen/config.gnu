# t: top margin in pixels
t = 35.0
# b: key height in pixels (bottom margin)
b = 170.0
# h: height of output in pixels
h = 150.0*n + t + b

### define functions to help set top/bottom margins
top(i,n,h,t,b) = 1.0 - (t+(h-t-b)*(i-1)/n)/h 
bot(i,n,h,t,b) = 1.0 - (t+(h-t-b)*i/n)/h

### first set up some basic plot parameters
set term pngcairo enhanced size 800,h font 'Helvetica,14'

set datafile separator ','
set multiplot layout (n+1),1
