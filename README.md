**CACHE COMPRESSION: BASE-DELTA-IMMEDIATE ALGO**
<br/>
<br/>
![img](https://askleo.askleomedia.com/wp-content/uploads/2013/11/cache.jpg)
<br/>
<br/>
*Implementation of BDI cache line compression algorithm. Code was used to gather performance metrics on the algorithm*
<br/>
<br/>
ABSTRACT
Cache compression is a promising technique to increase on-chip cache capacity and to decrease on-chip and off-chip bandwidth usage. Unfortunately, directly applying well-known compression algorithms (usually implemented in software) leads to high hardware complexity and unacceptable decompression/compression latencies, which in turn can negatively affect performance. Hence, there is a need for a simple yet efficient compression technique that can effectively compress common in-cache data patterns, and has minimal effect on cache access latency.
<br/>
<br/>
This project is based on **Cache compression** using implementation of BDI (Baser Delta the Immediate) Algorthim. This project has been completely coded in verilog. I have choosen this project, since cache compression has previously been proved to improve performance, as compressing data stored in on-chip caches increases their effective capacity, potentially reducing the misses.
<br/>
**Cache:** Cache Memory is the CPU fastest accessible memory in CPU. Also, cache is a STATIC RAM. 
<br/>
<br/>
**Algo**
<br/>
The key observation behind BDI compression is that for many cache lines, data values stored in the line have low dynamic ranges. ie.relative differences are small.
In such cases, the line can be represented in a compact form as a common base value plus an array of relative differences called de Deltas. 
