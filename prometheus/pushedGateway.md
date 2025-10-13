## 1
Install Prometheus Pushgateway on prometheus-server.

Note: You can install any version but we recommend v1.11.1.

Download and install the Pushgateway binary:

```bash
wget https://github.com/prometheus/pushgateway/releases/download/v1.11.1/pushgateway-1.11.1.linux-amd64.tar.gz
tar xvfz pushgateway-1.11.1.linux-amd64.tar.gz
cp pushgateway-1.11.1.linux-amd64/pushgateway /usr/local/bin/
useradd -M -r -s /bin/false pushgateway
chown pushgateway:pushgateway /usr/local/bin/pushgateway
```


Create a systemd unit file for Pushgateway:

```bash
vi /etc/systemd/system/pushgateway.service
```


Add below code in it:

```service
[Unit]
Description=Prometheus Pushgateway
Wants=network-online.target
After=network-online.target

[Service]
User=pushgateway
Group=pushgateway
Type=simple
ExecStart=/usr/local/bin/pushgateway

[Install]
WantedBy=multi-user.target

```

Start and enable the pushgateway service:

```bash
systemctl enable --now pushgateway

```

## 2 
curl localhost:9091/metrics

## 3

Configure Prometheus to scrape the PushGateway. The job label should be pushgateway, and make sure that honor_labels is set to true so that the clients can set the job/instance labels.

Edit /etc/prometheus/prometheus.yml file:


vi /etc/prometheus/prometheus.yml



Add below lines under scrape_configs:


  - job_name: pushgateway
    honor_labels: true
    static_configs:
      - targets: ["localhost:9091"]

systemctl restart prometheus

Expected Outcomes:

Click on the Prometheus button to access the Prometheus UI.

Click on the Status menu in navigation bar.

From the dropdown, select Service Discovery.

Look for the entry labeled as the pushgateway.

There are 1 targets discovered in the demo, as indicated by the 1 / 1 label in the Service Discovery view.



### 4
4 / 10
Execute the command below on the terminal, to push the processing_time_seconds 120 metric into a job labeled as {job="video_processing"}.
```bash
echo "processing_time_seconds 120" | curl --data-binary @- http://localhost:9091/metrics/job/video_processing
```


Expected Outcome:

Click on the PushGateway button to access the Pushgateway UI.

Next, click on Metrics.

Click on the entry labeled video_processing job="video_processing".

Under the Metrics section for video_processing job="video_processing", check the value of processing_time_seconds.

Expected Result:

{job="video_processing"}    120

### 5

Using the Prometheus expressions browser, verify that the metric processing_time_seconds was successfully scraped on the Prometheus server.


Was this metric successfully scraped on the Prometheus server?

## 6 

Grouping metrics allow you to update & delete all metrics in a specific group without impacting the metrics in other groups.


Push the following metrics to the PushGateway and group the metrics as /job/video_processing/instance/mp4_node1


processing_time_seconds{quality="hd"} 120
processed_videos_total{quality="hd"} 10
processed_bytes_total{quality="hd"} 4400




Execute the below commands:


cat <<EOF | curl --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mp4_node1
# TYPE processing_time_seconds gauge
processing_time_seconds{quality="hd"} 120
# TYPE processed_videos_total gauge
processed_videos_total{quality="hd"} 10
# TYPE processed_bytes_total gauge
processed_bytes_total{quality="hd"} 4400
EOF


cat <<EOF | curl --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mov_node1
# TYPE processing_time_seconds gauge
processing_time_seconds{quality="hd"} 400
# TYPE processed_videos_total gauge
processed_videos_total{quality="hd"} 250
# TYPE processed_bytes_total gauge
processed_bytes_total{quality="hd"} 96000
EOF


Expected Outcome:
1. Metrics Are Successfully Pushed and Grouped

After running the two curl commands, the PushGateway will have two distinct metric groups:
/job/video_processing/instance/mp4_node1

/job/video_processing/instance/mov_node1
Each group contains three gauge metrics, grouped by the specific job and instance.
2. PushGateway UI Outcome

Click on the PushGateway button to access the Pushgateway UI. Then click on Metrics.
You should see:

Groups
------
Group: job="video_processing", instance="mp4_node1"
Group: job="video_processing", instance="mov_node1"
Clicking on each group will display the following metrics with type GAUGE and label quality="hd":
For mp4_node1:

# TYPE processing_time_seconds gauge
processing_time_seconds{quality="hd"} 120

# TYPE processed_videos_total gauge
processed_videos_total{quality="hd"} 10

# TYPE processed_bytes_total gauge
processed_bytes_total{quality="hd"} 4400



For mov_node1:

# TYPE processing_time_seconds gauge
processing_time_seconds{quality="hd"} 400

# TYPE processed_videos_total gauge
processed_videos_total{quality="hd"} 250

# TYPE processed_bytes_total gauge
processed_bytes_total{quality="hd"} 96000


3. Prometheus Scrapes the Metrics

Click on the Prometheus button to access the Prometheus UI.
In Expression browser execute the querying any of these metric names e.g. processing_time_seconds will return results for both instances:




## 7

Verify that all six metrics are visible on the Prometheus server by performing the following query in the expression browser:


{job="video_processing"}

Are you seeing the correct results?

yes

### 8 

Currently the metrics from the first group i.e., /job/video_processing/instance/mp4_node1 look like as below:


processing_time_seconds{quality="hd"} 120
processed_videos_total{quality="hd"} 10
processed_bytes_total{quality="hd"} 4400




Now, send a POST request to the same group with the following metric:


processing_time_seconds{quality="hd"} 999


Execute the below command:
```bash

cat <<EOF | curl --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mp4_node1
# TYPE processing_time_seconds gauge
processing_time_seconds{quality="hd"} 999
EOF
```

Expected Outcome:
1. PushGateway UI Outcome

Click on the PushGateway button to access the Pushgateway UI.

Then click on Metrics.

Under the group job="video_processing", instance="mp4_node1" you will now see:


Currently, the metrics from the first group i.e., /job/video_processing/instance/mp4_node1 look like as below:

```bash
processing_time_seconds{quality="hd"} 999
processed_videos_total{quality="hd"} 10
processed_bytes_total{quality="hd"} 4400
```



Now, send a PUT request with the following metric to this group:


processing_time_seconds{quality="hd"} 666

### 9 
Currently, the metrics from the first group i.e., /job/video_processing/instance/mp4_node1 look like as below:


processing_time_seconds{quality="hd"} 999
processed_videos_total{quality="hd"} 10
processed_bytes_total{quality="hd"} 4400




Now, send a PUT request with the following metric to this group:


processing_time_seconds{quality="hd"} 666

Run below command:


cat <<EOF | curl -X PUT --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mp4_node1
# TYPE processing_time_seconds gauge
processing_time_seconds{quality="hd"} 666
EOF



Expected Outcome:

1. PushGateway UI Outcome

Click on the PushGateway button to access the Pushgateway UI.

Then click on Metrics.

Under the group job="video_processing", instance="mp4_node1" you will now only see:

Only the processing_time_seconds metric will be visible for this group.



2. Prometheus Scrapes the Metrics

Click on the Prometheus button to access the Prometheus UI or refresh the UI if its already open.

Execute the {job="video_processing", instance="mp4_node1"} query in the expression browser.

The metric processing_time_seconds is now updated to 666.

All other metrics that were previously in this group for instance="mp4_node1" are now removed and they no longer appear in the results for this label set.


### 10

Let's send a DELETE request to remove all metrics from the /job/video_processing/instance/mp4_node1 group.


Once done, verify that all metrics in this group have been removed, but all metrics under the /job/video_processing/instance/mov_node1 group still persist.


Run below command:


curl -X DELETE http://localhost:9091/metrics/job/video_processing/instance/mp4_node1



Expected Outcomes:

1. PushGateway UI Outcome

Click on the PushGateway button to access the Pushgateway UI.

Then click on Metrics.

The entire group {job="video_processing", instance="mp4_node1"} is deleted from PushGateway.

All metrics that were previously pushed under this group are removed completely.



2. Prometheus Scrapes the Metrics

Click on the Prometheus button to access the Prometheus UI or refresh the UI if its already open.

Execute the {job="video_processing", instance="mp4_node1"} query in the expression browser.

You will notice that all metric has been removed.

Further, execute the {job="video_processing", instance="mov_node1"} query in the expression browser.

You will notice that all metric still persist there.

