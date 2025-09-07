Part 1: Understanding the Prometheus Setup 
Perform the following checks to understand the current state of the Prometheus server. 
1. Check if Prometheus is running 
o Identify the appropriate command to verify the Prometheus process. 

![alt text](image.png)


2. Find the configuration file 
o Locate the full path to the Prometheus configuration file being used. 

/etc/prometheus/prometheus.yml

3. Locate the data directory 
o Identify the absolute path to where Prometheus stores its time series database. 

/var/lib/prometheus/ 

4. Check the default scrape interval 
o Look into the configuration file and determine how frequently Prometheus scrapes its 
targets by default. 

current scrape_interval:5s
![alt text](image-1.png)

5. Review the current scrape targets 
o Identify the targets Prometheus is currently scraping. 
![alt text](image-2.png)

6. Check for unhealthy targets 
o Open the Prometheus UI and inspect how many targets are in an unhealthy state.

![alt text](image-3.png)


7. cpu usage 

cpu_usage{instance="localhost:9091" ,  job = "Pushgateway"}


8. 

memory_usage{instance="localhost:9091" ,  job = "Pushgateway"}

9. 
!["rules"](image-4.png)

10. 

![alt text](image-5.png)

11

12

13.
![alt text](image-7.png)
![alt text](image-6.png)



