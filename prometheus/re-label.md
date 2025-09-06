For the demo job, configure re-label configs to scrape only targets with env="prod" label and drop all other targets.


Note: After making all required changes, restart the prometheus service using below command.

```bash
systemctl restart prometheus
```

Edit /etc/prometheus/prometheus.yml file

```bash
vi /etc/prometheus/prometheus.yml
```



Update - job_name: "demo" so that it looks like as below:

```yaml
  - job_name: "demo"
    file_sd_configs:
      - files:
          - /etc/prometheus/file-sd.json
    relabel_configs:
      - source_labels: [env]
        regex: prod
        action: keep
```



Restart prometheus service:

```bash
systemctl restart prometheus

```


-----------------------------------------------------

We have decided to scrape the metrics from targets that have the following labels only:


  team=api

  env=prod


Make the required changes for demo job.


Note: After making all required changes, restart the prometheus service using below command.

systemctl restart prometheus



Edit /etc/prometheus/prometheus.yml file:


vi /etc/prometheus/prometheus.yml




Change below lines under - job_name: "demo":


    relabel_configs:
      - source_labels: [env]
        regex: prod
        action: keep




to


    relabel_configs:
      - source_labels: [team, env]
        regex: api;prod
        action: keep


Currently, there is a label that follows the format team=<team-name>:


  team=api

  team=database


Re-label this label so the label name changes to the organization and the value gets prepended with org- text.


Example:

   organization=org-api

   organization=org-database


Make the required changes for demo job.

Edit /etc/prometheus/prometheus.yml file


vi /etc/prometheus/prometheus.yml




Add below lines under - job_name: "demo":


    relabel_configs:
      - source_labels: [team]
        regex: (.*)
        action: replace
        target_label: organization
        replacement: org-$1




Restart prometheus service:


systemctl restart prometheus



The relabel configuration you added:

Takes the value of the team label for each discovered target.

Creates a new label called `organization.

Sets the value of organization to be org- followed by the team label was.

This is visible in the Service Discovery.

Click on the Prometheus button to access the Prometheus UI.



----------------


The type label is no longer needed, set up a relabel policy for the demo job to drop this label.


Note:

We have reset the prometheus.yml to the original config.
After making all required changes, restart the prometheus service using below command.
systemctl restart prometheus


Edit /etc/prometheus/prometheus.yml file


vi /etc/prometheus/prometheus.yml




Add below lines under - job_name: "demo":


    relabel_configs:
      - regex: type
        action: labeldrop




Restart prometheus service:


systemctl restart prometheus

--------------------------------------------

By default, the labels that start with__ will get dropped after the re-labeling process. Now, we want to keep all of those labels as well and change the name so it removes the__meta_ text from the name.


For example change:

 __meta_os__=centos ⇒ os=centos

 __meta_mem__=8000mb ⇒ mem=8000mb


Use the labelmap action to assign these discovered labels as target labels. Make the required changes under demo job.


Note:

We have reset the prometheus.yml to the original config.
After making all required changes, restart the prometheus service using below command.
systemctl restart prometheus

Edit /etc/prometheus/prometheus.yml file


vi /etc/prometheus/prometheus.yml




Add below lines under - job_name: "demo":


    relabel_configs:
      - regex: __meta_(.*)__
        action: labelmap
        replacement: $1




Restart prometheus service:


systemctl restart prometheus

--------------------------------------------
The Prometheus metric node_network_transmit_drop_total is no longer needed for monitoring.

Your task:

Configure Prometheus so that under the job with job_name: "nodes", add a metric relabeling policy to drop the node_network_transmit_drop_total metric.

Note:

We have reset the prometheus.yml to the original config. Also, the Prometheus service might be down right now.
After making all required changes, restart the prometheus service using below command.
systemctl restart prometheus

It may take up to 5 minutes for configuration changes to be fully reflected in the Prometheus UI.

Edit /etc/prometheus/prometheus.yml file


vi /etc/prometheus/prometheus.yml




Add below lines under - job_name: "nodes":


    metric_relabel_configs:
      - source_labels: [__name__]
        regex: node_network_transmit_drop_total
        action: drop




That it looks like as below:

  - job_name: "nodes"
    metric_relabel_configs:
      - source_labels: [__name__]
        regex: node_network_transmit_drop_total
        action: drop
    scheme: https
    tls_config:
      ca_file: /etc/prometheus/node_exporter.crt
      insecure_skip_verify: true
    basic_auth:
      username: prometheus
      password: secret-password
    static_configs:
      - targets: ["node01:9100", "node02:9100"]



Restart prometheus service:


systemctl restart prometheus

----------------

