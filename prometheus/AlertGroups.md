Create an alert group for all job=nodes targets and trigger an alert when the free memory is less than 10%. Review the details below:


   (a) The group name should be node (it should be configured already).

   (b) The alert name should be HostOutOfMemory.

   (c) The expression should calculate when the host has less than 10% free memory:

node_memory_MemAvailable_bytes{job="nodes"} / node_memory_MemTotal_bytes{job="nodes"} * 100 < 10




   (d) It should have two labels:

         severity: warning

         team: internal-infra

         Also add a message annotation that will print out a message in the following format:


node {{.Labels.instance}} is seeing high memory usage, currently available memory: {{.Value}}%


Note:
Update the alerting rules file /etc/prometheus/rules.yaml .
-------------------
Edit /etc/prometheus/rules.yaml file:


vi /etc/prometheus/rules.yaml




Add below alert rule in it:

```yaml



      - alert: HostOutOfMemory
        expr: node_memory_MemAvailable_bytes{job="nodes"} / node_memory_MemTotal_bytes{job="nodes"} * 100 < 10
        labels:
          severity: warning
          team: internal-infra
        annotations:
          message: "node {{.Labels.instance}} is seeing high memory usage, currently available memory: {{.Value}}%"


```

Restart the prometheus service:

```bash
systemctl restart prometheus

```

The alert manager is running on the prometheus-server itself. Update the alert manager configuration i.e /etc/alertmanager/alertmanager.yml to make the following changes:


   (a) Add the following smtp configs in the global section (add new if doesn't exist), so that all notifiers can use these settings:


         smtp_smarthost: 'localhost:25'

         smtp_from: 'alertmanager@prometheus-server.com'


   (b) Under the default route, update the receiver value to general-email.


   (c) Configure a route that matches a label team: global-infra


         (i) Receiver should be set to global-infra-email


   (d) Configure another route that matches a label team: internal-infra


          (i) Receiver should be internal-infra-email


   (e) Configure global-infra-email receiver:


         (i) Set email_configs with below given two properties:


             to: root@prometheus-server.com

             require_tls: false


   (f) Configure internal-infra-email receiver:


         (i) Set email_configs with below given two properties:


             to: admin@prometheus-server.com

             require_tls: false


   (g) Configure a general-email receiver:


         (i) Set email_configs with below given two properties:


             to: admin@prometheus-server.com

             require_tls: false



Edit /etc/alertmanager/alertmanager.yml file:


vi /etc/alertmanager/alertmanager.yml



```yaml
Update the file so that it looks like as below:


global:
  smtp_smarthost: 'localhost:25'
  smtp_from: 'alertmanager@prometheus-server.com'

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 2m
  repeat_interval: 1h
  receiver: 'general-email'
  routes:
    - match:
        team: global-infra
      receiver: global-infra-email
    - match:
        team: internal-infra
      receiver: internal-infra-email

receivers:
  - name: 'web.hook'
    webhook_configs:
      - url: 'http://127.0.0.1:5001/'
  - name: global-infra-email
    email_configs:
      - to: "root@prometheus-server.com"
        require_tls: false
  - name: internal-infra-email
    email_configs:
      - to: "admin@prometheus-server.com"
        require_tls: false
  - name: general-email
    email_configs:
      - to: "admin@prometheus-server.com"
        require_tls: false

```


Restart the alertmanager service:

```bash
systemctl restart alertmanager
```





 - name: global-infra-email
    email_configs:
      - to: "root@prometheus-server.com"
        require_tls: false
  - name: internal-infra-email
    email_configs:
      - to: "admin@prometheus-server.com"
        require_tls: false
  - name: general-email
    email_configs:
      - to: "admin@prometheus-server.com"
        require_tls: false


------------------


As we know, there must be an email alert sent to the admin@prometheus-server.com email ID. admin is a local user on prometheus-server itself which we used for testing. Let's verify that it actually received an email alert.

The emails for admin user are stored in /var/spool/mail/admin file. You can try to read it using below command:

verify if email recieved:

less /var/spool/mail/admin




