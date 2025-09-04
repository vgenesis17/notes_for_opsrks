Construct and run a query that will return all instances that are in up state and that are part of the web job. Save the query in /root/query2.txt file.

{job="web"}.


To test the same, click on the Prometheus button to open the Prometheus UI and enter up{job="web"} query in the expression browser, then click on Execute. It must return all targets that are under web job and that are in up state.


Further, save this query in /root/query2.txt file:


vi /root/query2.txt



Add up{job="web"} query in this file and save.

node_memory_MemAvailable_bytes query returns the amount of the memory available on the target(s). Construct a query to return the available memory on all target(s) under loadbalancer job. Save the query in /root/query3.txt file.


node_memory_MemAvailable_bytes{job="loadbalancer"}



Which of the following queries will return the number of arp entries for node01:9100 node?


(B) node_arp_entries{instance="node01:9100"}


recieve bytes:

node_network_recieve_bytes_total{instance="node01:9100",device="eth01"}


### -----------------------------------------------------
Each host includes a loopback interface i.e lo. Construct a query to return the number of bytes received on all interfaces except interface lo on instance node02:9100. Save the query in /root/query6.txt file.


node_network_receive_bytes_total{instance="node02:9100", device!="lo"} 
query will be used to return the number of bytes received on all interfaces except interface lo on instance node02:9100.


To test the same, click on the Prometheus button to open the Prometheus UI and enter node_network_receive_bytes_total{instance="node02:9100", device!="lo"} query in the expression browser, then click on Execute. It must return the data for all interfaces except the lo interface.


Further, save this query in /root/query6.txt file:


7. 

Using node_memory_MemAvailable_bytes metric, construct a query to return the available memory bytes for past 5 minutes on node01:9100. Save the query in /root/query7.txt file.


node_memory_MemAvailable_bytes{instance="node01:9100"}[5m]


8.

Which of the following queries will return the 1h ago available memory bytes on node01:9100 host?

(B) node_memory_MemAvailable_bytes{instance="node01:9100"} offset 1h



Which of the following queries will return the value of the metric on timestamp 1654920221 i.e Jun 11, 2022 4:03:41 AM GMT for instance node02:9100?


@1654920221



Which of the following queries will return the value of the metric 30 minutes before Jun 11, 2022 4:03:41 AM GMT for instance node01:9100? The unix timestamp value for this time is 1654920221.


node_context_switches_total{instance="node01:9100"} @offset 30m


The node_cpu_seconds_total metric has two labels. One is the cpu, which denotes for which cpu the time series is for and the other one is mode, which denotes the cpu operating mode.


Construct a query that will return a metric for all instances in the web job for cpu 0 only and the cpu mode can be either user or system. To match user or system, a regular expression like user|system will be used.


Save the query in /root/query11.txt file.


node_cpu_seconds_total{job="web", cpu="0", mode=~"user|system"}



## Opertors, Vector Matching, Aggregator


On loadbalancer:9100 instance, calculate the sum of the size of all filesystems. The metric to get filesystem size is node_filesystem_size_bytes. Save the query in /root/query6.txt file.

```yaml
sum(node_filesystem_size_bytes{instance="loadbalancer:9100"})
```
Your task is to construct a PromQL query that returns the number of CPU cores available on the instance loadbalancer:9100. Utilize the node_cpu_seconds_total metric and apply a filter for a specific mode (mode="idle") to ensure that each CPU core is counted only once. Once you have created this query, save it to the file located at /root/query7.txt file.

### 9

Construct a PromQL query that shows the number of CPUs on each instance across all jobs using the node_cpu_seconds_total metric. To count each CPU only once per instance, filter using a single mode (mode="idle"). Save this query in /root/query8.txt file.

```yaml
count(node_cpu_seconds_total{mode="idle"}) by (instance)
```
Use the node_network_receive_bytes_total metric to calculate the sum of the total received bytes across all interfaces on per instance basis. Save the query in /root/query9.txt file.
```yaml
sum by(instance)(node_network_receive_bytes_total)
```
### 10

Which of the following queries will be used to calculate the average packet size for each instance?


sum by(instance)(node_network_receive_bytes_total) / sum by(instance)(node_network_receive_packets_total)

### 11
Construct a query that will find out what percentage of time each cpu on each instance was spent in mode user. The final result should look like below, with a time series for each instance and cpu with x being the value of the timeseries

```bash
node_cpu_seconds_total{mode="user"}*100 /ignoring(mode, job) sum by(instance, cpu) (node_cpu_seconds_total)
```
### 12 

The api job collects metrics on an API used for uploading files. The API has 3 endpoints /images /videos, and /songs, which are used to upload respective file types. The API provides 2 metrics to track


http_uploaded_bytes_total - tracks the number of uploaded bytes.


http_upload_failed_bytes_total - tracks the number of bytes failed to upload.


Construct a query to calculate the percentage of bytes that failed for each endpoint. The formula for the same is http_upload_failed_bytes_total*100 / http_uploaded_bytes_total.


```bash
http_upload_failed_bytes_total*100 / ignoring(error) group_left http_uploaded_bytes_total
```