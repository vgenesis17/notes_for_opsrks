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


### Function, subqueiries
There are three jobs configured in Prometheus: multimedia, auth, and api. Construct a Prometheus query to fetch the node_cpu_seconds_total metric for all jobs and sort the results in ascending order. Save this query to the file /root/ascending.txt.

```bash
sort(node_cpu_seconds_total)
```

### 2
Construct a Prometheus query that returns the metric node_memory_Active_bytes for all jobs, and sorts the results in descending order. Save this query to the /root/descending.txt file

```yaml
 sort_desc( node_memory_Active_bytes)
```


### 3

Calculate the percentage of free space for all filesystems on all instances under all jobs using the following query:

node_filesystem_avail_bytes * 100 / node_filesystem_size_bytes

Note: The resulting percentages may have several decimal places.


Now, modify the query to use the round function to round the result to the nearest integer. Save the final rounded query in the /root/percentage.txt file.

```bash
round(node_filesystem_avail_bytes * 100 / node_filesystem_size_bytes)
```

### 5

Management wants to monitor the rate of bytes received by each instance. Since each instance has two network interfaces, the rate of incoming traffic must be combined (summed) for all interfaces per instance.

Calculate the rate of received bytes using the node_network_receive_bytes_total metric and a 2-minute window.

Sum the rates for all interfaces and group the result by instance.

Save the final query in /root/traffic.txt.

```bash
sum by(instance)(rate(node_network_receive_bytes_total[2m]))
```
### 09
findind request with greater than 0.08 s latency but less than 0.1 s

count(http_request_total_bucket{instance="node01:3000",le="0.1"}) - ignoring (le) count(http_request_total_bucket{instance="node02:3000",le="0.08"})

### 10

Construct a PromQL query that calculates the per-second rate of HTTP requests (using a 1-minute window) whose latency was less than 0.08 seconds, across all nodes.


Use the bucket for le="0.08" in your selector to include all requests that completed in less than or equal to 0.08 seconds.

Apply the rate() function to the selected time series over a 1-minute window.

Save your query in the file /root/rate.txt.


### 11
Construct a PromQL query to calculate the average latency of a request over the past 4 minutes.

Use the metric http_request_total_sum, which contains the sum of all request latencies, and http_request_total_count, which contains the total number of requests.
rate of sum-of-all-requests / rate of count-of-all-requests

Save your query in /root/request_sum.txt.



rate(http_request_total_sum[4m]) / rate(http_request_total_count[4m])


### 12

Management would like to know the 95th percentile latency for HTTP requests received by node node01:3000.
The application exposes latencies as a Prometheus histogram metric named http_request_total_bucket.

Construct a PromQL query using the histogram_quantile function to calculate the 95th percentile latency on node01:3000.
Save your query in /root/quantile.txt.


histogram_quantile(0.95, http_request_total_bucket{instance="node01:3000"})

### 13


The company is now offering customers an SLO stating that, 95% of all requests will be under 0.15s. What bucket size will need to be added to guarantee that the histogram_quantile function can accurately report whether or not that SLO has been met?

Bucket size which needs to be added to guarantee that the histogram_quantile function can accurately report whether or not that SLO is met is 0.15.


A summary metric http_upload_bytes has been added to track the amount of bytes uploaded per request. What are percentiles being reported by this metric?





(B) 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99
### 15

The application exposes uploaded bytes as a Prometheus summary metric named http_upload_bytes, which reports quantiles via a quantile label.

Construct a PromQL query to retrieve the 90th percentile quantile="0.9" of uploaded bytes for node node01:3000.

Save your query in /root/percentile.txt.

http_upload_bytes{instance="node01:3000", quantile="0.9"}



## RECORDING RULES


Create a recording rule to track the rate at which a node is receiving traffic. Find below more details:



  (a) Create a file called node-rules.yaml under /etc/prometheus directory.


  (b) Update this file to:


        (i) Create a group called node, this group should have all the rules for node_exporters.


        (ii) Set the interval for the rules to run every 15s.


        (iii) Add a record called node_network_receive_bytes_rate.


        (iv) The expression should be rate(node_network_receive_bytes_total{job="nodes"}[2m])


  (c) Finally, update the prometheus.yml file to import rules from node-rules.yaml file and restart the prometheus service.





  ###ans
vi /etc/prometheus/node-rules.yaml
  ```yaml
groups:
  - name: node
    interval: 15s
    rules:
      - record: node_network_receive_bytes_rate
        expr: rate(node_network_receive_bytes_total{job="nodes"}[2m])

  ```

  vi /etc/prometheus/prometheus.yml

Edit /etc/prometheus/prometheus.yml file:


Add below line under rule_files: section:

```yaml
  - "node-rules.yaml"
```
most important:
```bash
systemctl restart prometheus
```

access the rule health



We can avoid updating the prometheus.yml file every time for adding a new rule file we create by making use of globs. Update the prometheus.yml file so that it look like below:



rule_files:
  - "*rules.yaml"




This will import all files that have prefix rules.yaml. Finally, restart theprometheus service.


vi /etc/prometheus/prometheus.yml



Change rule_files: section so that it looks like below:

ans: 
```yaml
rule_files:
  - "*rules.yaml"
```

