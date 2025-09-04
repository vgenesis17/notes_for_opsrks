By default, Docker does not export any metrics, so configure it to export metrics on port 9323. Restart Docker service after making the required changes.:

Create/edit /etc/docker/daemon.json file:

vi /etc/docker/daemon.json
Add below given lines in it:
```json
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
```
Restart docker service:

systemctl restart docker
Verify if docker is exporting the metrics now:

curl localhost:9323/metrics



#-----------------------------------------------------------------------------------------------
Create a new job in Prometheus called docker and add the Docker host (i.e. localhost) as a target. Make sure to restart the Prometheus service after making the required changes.

Edit /etc/prometheus/prometheus.yml file:

vi /etc/prometheus/prometheus.yml
Add below given lines under scrape_configs:

  - job_name: "docker"
    static_configs:
      - targets: ["localhost:9323"]
Restart prometheus service:

systemctl restart prometheus

#--------------------------------------------------------------------------------------------
In the expression search box, run the following query to report the number of containers and their state.

engine_daemon_container_states_containers

How many containers are in the running state?



### implementing promoteus on docker 

To get the container-level metrics, a cAdvisor container needs to run on the docker host. The cAdvisor can collect and expose metrics.


On prometheus-server, there is a docker compose file /root/docker-compose.yml available. Create a cAdvisor container using the same. Once you are done, you can access the metric using the curl localhost:8070/metrics command.
```yaml
version: '3.4'
services:
  cadvisor:
    image: gcr.io/cadvisor/cadvisor
    container_name: cadvisor
    privileged: true
    devices:
      - "/dev/kmsg:/dev/kmsg"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro
    ports:
      - 8070:8080
```

Create a new job in Prometheus called cadvisor and add localhost:8070 as a target. Restart the Prometheus service after making the required changes.


```bash
#Edit /etc/prometheus/prometheus.yml file:

vi /etc/prometheus/prometheus.yml
#Add below given lines under scrape_configs:

  - job_name: "cadvisor"
    static_configs:
      - targets: ["localhost:8070"]
Restart prometheus service:

systemctl restart prometheus



```

In the Expression search box, run the following query to find the total number of system seconds for opt-redis3-1 container.

container_cpu_system_seconds_total{job="cadvisor", name="opt-redis3-1"}