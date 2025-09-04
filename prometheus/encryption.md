
The Node exporter is already installed on both nodes, i.e., node01 and node02. Now, let's configure the node exporter on both nodes as below:

Create a directory called node_exporter under /etc.
Create a blank file called config.yml under this newly created directory.
Set appropriate permissions for node_exporter directory and config.yml file. The node exporter username on both nodes is node_exporter.
Finally, edit the node exporter service, i.e., /etc/systemd/system/node_exporter.service to use config.yml config file.
Make sure to restart the node_exporter service once done.

Note: You should be able to SSH into node01 and node02 through user root (without any password) from prometheus-server. Once you SSH into any node (for example node01) and you are done with your changes, remember to exit from that node (i.e node01) before SSH into the another node (i.e node02



SSH to node01
```bash
ssh root@node01
```
Create the config:
```bash
mkdir /etc/node_exporter/
touch /etc/node_exporter/config.yml
chmod 700 /etc/node_exporter
chmod 600 /etc/node_exporter/config.yml
chown -R node_exporter:node_exporter /etc/node_exporter
```
Edit node_exporter service

```bash
vi /etc/systemd/system/node_exporter.service
```
Change below line:

ExecStart=/usr/local/bin/node_exporter
to
```bash
ExecStart=/usr/local/bin/node_exporter --web.config.file=/etc/node_exporter/config.yml 
```
Reload the daemon and Restart node_exporter service
```bash
systemctl daemon-reload
systemctl restart node_exporter
```
exit


# -------------------------------------------------------------------------------------------
Configure Prometheus and Node servers to use authentication to communicate. Find more details below:
  (a) Username should be prometheus.
  (b) Password should be secret-password, use the apache2-utils package to create a hash of the password.
  (c) Configure node exporter's config file, i.e., config.yml to use the authentication
  (d) Finally, restart node exporter service once done.


Note: You should be able to SSH into node01 and node02 through user root (without any password) from prometheus-server. Once you SSH into any node (for example node01) and you are done with your changes, remember to exit from that node (i.e node01) before SSH into the another node (i.e node02).



SSH to node01:
```bash 
ssh root@node01
```
Install apache2-utils package:
```bash
apt update
apt install apache2-utils -y
```
Generate password hash:
```bash
htpasswd -nBC 10 "" | tr -d ':\n'; echo
```
It will ask for the password twice as below (enter password secret-password twice):
```bash
New password: 
Re-type new password: 
```
Finally, you will get a hashed value of your password.
Edit /etc/node_exporter/config.yml file:
```bash
vi /etc/node_exporter/config.yml
```
Add below lines in it:


```yaml

```
Restart node_exporter service
```bash
systemctl restart node_exporter
```
exit
You can verify the changes using curl command:
```bash
curl http://node01:9100/metrics
```
return output should be Unauthorized
Note: Follow same steps for node02 except generating the password hash, you should be able to use the same password hash for node02.

Are you able to access the metrics using correct credentials now?

Try using below given commands:
curl -u prometheus:secret-password http://node01:9100/metrics
curl -u prometheus:secret-password http://node02:9100/metrics



Now, let's configure the Prometheus server to use authentication when scraping metrics from node servers.

Edit the Prometheus configuration file

vi /etc/prometheus/prometheus.yml
Under - job_name: "nodes" add below lines:
```yaml
basic_auth:
  username: prometheus
  password: secret-password
Restart prometheus service:
```
```bash
systemctl restart prometheus

```