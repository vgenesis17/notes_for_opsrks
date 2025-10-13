To setup monitoring with prometheus in Jenkins, please install the plugins mentioned below.


You need to install Prometheus metrics plugin, you can refer to the plugin documentation by clicking on the Prometheus Docs button located above the terminal.


Once the plugins have been downloaded, restart Jenkins.

Login into the Jenkins server and follow the below given steps:

1. Go to Manage Jenkins.
2. Click on Plugins.
3. Under Available, search for Prometheus metrics plugin.
4. Select it and install.
5. Once installed click on Restart Jenkins when installation is complete and no jobs are running.

---


access prometheus at https://8085-port-tal3hxafcqq4tgt3.labs.kodekloud.com/prometheus

---
Let us now add a scrape config for Jenkins. Update the prometheus configuration file located at /etc/prometheus/prometheus.yml and add the following config under the scrape_configs section:


- job_name: 'Jenkins'
  metrics_path: /prometheus/
  static_configs:
    - targets: ['localhost:8085']



Once the file is updated, restart prometheus using the below command:
```bash
service prometheus restart 
```


Wait for few seconds for the Jenkins job to be UP in Prometheus UI before submitting your question.


Note: Here localhost:8085 refers to our Jenkins Controller and the /prometheus/ metrics path is exposed by the prometheus-metrics plugin that we installed previously`


---
8 / 12
Now lets test out some queries in Prometheus. Go back to the Prometheus home page (by clicking on the Prometheus button within the UI) and execute the following query:

jenkins_job_count_value

What value you got in the output?



---
Let us see now, how we can use Grafana to visualise Jenkins metrics. Grafana is already installed and can be accessed using Grafana button on the top of the terminal.

Grafana credentials are:

UserName: admin

Password: admin


Note:Set a new password admin123 for the admin user.



First of all, let us add Prometheus datasource in Grafana. Follow below given steps for that:

-> Login into Grafana and click on Add your first datasource.

-> Then select Prometheus and enter http://localhost:9090 in the URL box.

-> Finally click on Save and test button at the bottom.

-> Click on Grafana logo to move back to the dashboard.


---

Let us create a dashboard in Grafana now to visualise the total number of Jenkins jobs.


Use same Grafana credentials to login:

UserName: admin

Password: admin123


Follow below given steps to create a dashboard in Grafana:


-> Login into Grafana and click on Create your first dashboard.

-> Then click on Add visualization and at the bottom enter jenkins_job_count_value in the Metrics browser box.

-> Make sure Prometheus is selected as the Data source.

-> On the right side under Panel options, enter Jenkins Jobs Count in Title.

-> Click on Apply button on the top right corner.

-> Finally click on the Save dashboard button (second button on the top right).

-> Enter dashboard name as Jenkins and save it.
