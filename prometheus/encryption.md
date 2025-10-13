
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
basic_auth_users:
  prometheus:$2y$10$rcFqcMDjx.Pp6YZyGxR/qe8KAlvB2zhdqKvpYbPJg.9WX/ht2SbRO

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

### Edit the Prometheus configuration file
```bash
vi /etc/prometheus/prometheus.yml
```
Under - job_name: "nodes" add below lines:
```yaml
basic_auth:
  username: prometheus
  password: secret-password
```
### Restart prometheus service:

```bash
systemctl restart prometheus
```

6 / 9
Configure node exporter to use TLS on both nodes i.e node01 and node02. You can generate a certificate and key using the below command:
```bash
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout node_exporter.key -out node_exporter.crt -subj "/C=US/ST=California/L=Oakland/O=MyOrg/CN=localhost" -addext "subjectAltName = DNS:localhost"
```

Note: You should be able to SSH into node01 and node02 through user root (without any password) from prometheus-server. Once you SSH into any node (for example node01) and you are done with your changes, remember to exit from that node (i.e node01) before SSH into the another node (i.e node02).



SSH to node01

ssh root@node01
Generate the certificate and key

openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout node_exporter.key -out node_exporter.crt -subj "/C=US/ST=California/L=Oakland/O=MyOrg/CN=localhost" -addext "subjectAltName = DNS:localhost"
Move the crt and key file under /etc/node_exporter/ directory

mv node_exporter.crt node_exporter.key /etc/node_exporter/
Change ownership:

chown node_exporter.node_exporter /etc/node_exporter/node_exporter.key
chown node_exporter.node_exporter /etc/node_exporter/node_exporter.crt
Edit /etc/node_exporter/config.yml file:


Edit /etc/node_exporter/config.yml file:

vi /etc/node_exporter/config.yml
Add below lines in this file:

tls_server_config:
  cert_file: node_exporter.crt
  key_file: node_exporter.key
Restart node exporter service:

systemctl restart node_exporter
exit
You can verify your changes using curl command:

curl -u prometheus:secret-password -k https://node01:9100/metrics
Follow same steps for node02


### ERROR: 400
Let's configure Prometheus server to use HTTPS for scraping the node_exporter. Find below more details:


  (a) Copy the certificate from node_exporter to the prometheus server.
  (b) Update prometheus config to use https for node_exporter
  (c) Make sure to add insecure_skip_verify: true since we are using a self signed certificate
  (d) Finally restart the prometheus service.

## #--------------------------------------------------
Copy the certificate from node01 to Prometheus server

scp /etc/node_exporter/node_exporter.crt root@prometheus-server:/etc/prometheus/node_exportercrt
Change certificate file ownership:

chown prometheus.prometheus /etc/prometheus/node_exporter.crt
Edit /etc/prometheus/prometheus.yml file

vi /etc/prometheus/prometheus.yml 
Add below given lines under - job_name: "nodes"

    scheme: https
    tls_config:
      ca_file: /etc/prometheus/node_exporter.crt
      insecure_skip_verify: true
Restart prometheus service

systemctl restart prometheus
