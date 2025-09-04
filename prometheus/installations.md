
## Installation
```bash
 sudo wget https://github.com/prometheus/prometheus/releases/download/v3.5.0/prometheus-3.5.0.linux-amd64.tar.gz
 ```

Navigate to the prometheus-3.5.0.linux-amd64 directory by executing the following command:
```bash
cd prometheus-3.5.0.linux-amd64
```bash
Add Prometheus user as below:

useradd --no-create-home --shell /bin/false prometheus
Create Directories for storing prometheus config file and data:
```bash
mkdir /etc/prometheus
mkdir /var/lib/prometheus
```
Change the permissions:
```bash
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus
```
Copy the binaries:

cp prometheus promtool /usr/local/bin/
Change the ownership of binaries:
```bash
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
```
Move prometheus.yml file to /etc/prometheus directory:
```bash
cp prometheus.yml /etc/prometheus/
```
Change the ownership of file /etc/prometheus/prometheus.yml:
```bash
chown prometheus:prometheus /etc/prometheus/prometheus.yml
```
Create a service for prometheus:
```bash
vi /etc/systemd/system/prometheus.service
```
Add below lines in it:
```bash
[Unit]
Description=Prometheus Server
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.listen-address=0.0.0.0:9090

[Install]
WantedBy=multi-user.target
```


Key Points:

Do not include the --web.console.templates or --web.console.libraries flags these are not needed unless you use custom templates. Prometheus will serve the built-in consoles by default in version 3.5.0.
Run below commands:
```bash
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus
systemctl status prometheus

```

### Download the node exporter binary version 1.9.1 from https://prometheus.io/download/#node_exporter and start the node_exporter process on node01 and node02.


You should be able to SSH into node01 and node02 using user root without any password.

ssh node01
```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
```
```bash
tar -xvf node_exporter-1.9.1.linux-amd64.tar.gz
```
```bash
cd node_exporter-1.9.1.linux-amd64/
./node_exporter > /dev/null 2>&1 &
```

ssh node02

## EXtract metrics from nodes 

Update the /etc/prometheus/prometheus.yml file to add a job called nodes to start scraping the two node_exporters. Make sure to restart the Prometheus service.


Modify the /etc/prometheus/prometheus.yml file:
```bash
vi /etc/prometheus/prometheus.yml
```
Add below code under scrape_configs::
```yaml
  - job_name: "nodes"
    static_configs:
      - targets: ["node01:9100"]
        labels:
          node: "node01"
      - targets: ["node02:9100"]
        labels:
          node: "node02"
```
Restart the process with below command:
```bash
systemctl restart prometheus
```

it should look like this: 

```yaml
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    static_configs:
      - targets: ["localhost:9090"]
       # The label name is added as a label `label_name=<label_value>` to any timeseries scraped from this config.
        labels:
          app: "prometheus"
  - job_name: "nodes"
    static_configs:
      - targets: ["node01:9100"]
        labels:
          node: "node01"
      - targets: ["node02:9100"]
        labels:
          node: "node02"
```
