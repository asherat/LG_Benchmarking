LG_Benchmarking
===============

Monitoring and Benchmarking tools for Liquid Galaxy.
It allows to monitorize Liquid Galaxy while doing a tour, which reads from a txt file in order.
It shows CPU, Memory, Networking (external, internal [Squid] and synchronization [Viewsyncs]).

To start a benchmark, use this command ./Scripts/Benchmark [tourname] [seconds] [additional tag] where tourname should be one of the tags from the queries.txt in Scripts (lleida, bcn, Horsens, desierto...), seconds is the time between each jump and "additional tag" is for differenciate between tours with the same name.
