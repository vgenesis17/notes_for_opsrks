## Installation

Install &  Configure Prometheus Alertmanager v0.28.1 on prometheus-server.




Click on the AlertManagerDocs button to take help from the documentation. Once done, you should be able to access the same using AlertManager button.

```bash
1. Download and Extract Alertmanager
```bash
wget https://github.com/prometheus/alertmanager/releases/download/v0.28.1/alertmanager-0.28.1.linux-amd64.tar.gz
```
```bash
tar -xvf alertmanager-0.28.1.linux-amd64.tar.gz
```
Move to the extracted directory:
```bash
cd alertmanager-0.28.1.linux-amd64
```
2. Create an Alertmanager User
```bash
sudo useradd --no-create-home --shell /bin/false alertmanager
```

3. Create Configuration and Data Directories
```bash
sudo mkdir /etc/alertmanager
sudo cp alertmanager.yml /etc/alertmanager/

sudo mkdir /var/lib/alertmanager

sudo chown -R alertmanager:alertmanager /etc/alertmanager
sudo chown -R alertmanager:alertmanager /var/lib/alertmanager
```
4.Install the Binaries
```bash
sudo cp alertmanager /usr/local/bin/
sudo cp amtool /usr/local/bin/
sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager
sudo chown alertmanager:alertmanager /usr/local/bin/amtool
```
5. Create a Systemd Service File

vi /etc/systemd/system/alertmanager.service

[Unit]
Description=AlertManager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/usr/local/bin/alertmanager \
    --config.file /etc/alertmanager/alertmanager.yml \
    --storage.path /var/lib/alertmanager
Restart=always
[Install]
WantedBy=multi-user.target

6. Reload systemd and start the service:
```bash
sudo systemctl daemon-reload
sudo systemctl start alertmanager
sudo systemctl enable alertmanager
```
Check status:
```bash
systemctl status alertmanager
```

Update the Prometheus configuration located at /etc/prometheus/prometheus.yml to point to the new AlertManager endpoint at localhost:9093 you installed and configured in the previous question.

After updating, restart the Prometheus service so changes take effect.
```bash
vi /etc/prometheus/prometheus.yml

```

Change:

```yaml
alerting:
  alertmanagers:
    - static_configs:
        - targets:
           # alertmanagers:9093
```


To

```yaml
alerting:
  alertmanagers:
    - static_configs:
        - targets:
           - localhost:9093
```


Restart prometheus service:

```bash
systemctl restart prometheus
```


Make active alerts easier to interpret by adding a human-readable message to the NodeDown alert as an annotation.

Edit alert rules file /etc/prometheus/rules.yaml.
Locate the NodeDown alert rule.
Within the rule, add an annotations section with a descriptive message:
"node {{.Labels.instance}} is down"

Restart Prometheus to apply the changes

Edit /etc/prometheus/rules.yaml file:


vi /etc/prometheus/rules.yaml



Add below lines for NodeDown alert:


        annotations:
          message: "node {{.Labels.instance}} is down"



Your modified rule should look similar to this:
```yaml
      - alert: NodeDown
        expr: up{job="nodes"} == 0
        for: 10s
        labels:
          severity: critical
        annotations:
          message: "node {{.Labels.instance}} is down"
```

Restart prometheus service:


systemctl restart prometheus


Expected Outcome:

Click on the AlertManager button in your monitoring dashboard to open the Alertmanager web interface.

Check the Alerts section to see alerts in the alert manager.

The NodeDown alert appears in the Alertmanager UI with the message.


### 10

Fix the issue and resolve NodeDown alert.


Look into the Prometheus UI to see the alert.

```bash
ssh node01
systemctl start node_exporter
```


### Making Alerts

Create an alert in Prometheus to check the low disk space on nodes (node01 and node02). Find more details below:



   (a) Create a rules.yaml file under /etc/prometheus/ directory.


   (b) Group name should be node


   (c) Alert name should be LowDiskSpace


   (d) The expression should calculate when any filesystem has less than 10% free space.

       [1] 100 * node_filesystem_free_bytes{job="nodes"} / node_filesystem_size_bytes{job="nodes"} < 10


   (e) It should have two labels

       (1) severity: warning

       (2) environment: prod


   (f) Also update the /etc/prometheus/prometheus.yml config file to use the rules file


   (g) Finally, restart the Prometheus service.



   Create rules.yaml file in under /etc/prometheus/ directory:

``` yaml
vi /etc/prometheus/rules.yaml



Add below lines in it:


groups:
  - name: node
    rules:
      - alert: LowDiskSpace
        expr: 100 * node_filesystem_free_bytes{job="nodes"} / node_filesystem_size_bytes{job="nodes"} < 10
        labels:
          severity: warning
          environment: prod



Update the /etc/prometheus/prometheus.yml config file:

```bash
vi /etc/prometheus/prometheus.yml

```

#+below line under rule_files: so that it looks like as below:

```yaml
rule_files:
  - "/etc/prometheus/rules.yaml"


```
Restart prometheus service:

``bash
systemctl restart prometheus
```