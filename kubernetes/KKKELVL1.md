The Nautilus DevOps team is diving into Kubernetes for application management. One team member has a task to create a pod according to the details below:


Create a pod named pod-httpd using the httpd image with the latest tag. Ensure to specify the tag as httpd:latest.

Set the app label to httpd_app, and name the container as httpd-container.

Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

-------------------------------------sol'n
```bash
kubectl run pod-httpd \
  --image=httpd:latest \
  --labels="app=httpd_app" \
  --restart=Never \
  --port=80 \
  --dry-run=client -o yaml > pod-httpd.yaml


```

change the cotainer name to httpd-container
_______________________________________________________________________________________________


The Nautilus DevOps team is delving into Kubernetes for app management. One team member needs to create a deployment following these details:


Create a deployment named httpd to deploy the application httpd using the image httpd:latest (ensure to specify the tag)

Note: The kubectl utility on jump_host is set up to interact with the Kubernetes cluster.

``` bash
kubectl create deployment --image=httpd:latest httpd --dry-run=client -o yaml > httpd-deployment.yaml

```

```bash
kubectl expose deployment httpd \
  --type=NodePort \
  --port=80 \
  --name=httpd-service
```

Create namespace called dev and run nginx image pod name dev-nginx-pod


``` bash 

kubectl create namespace dev

kubectl get namespaces

kubectl run --image=nginx:latest dev-nginx-pod  --namespace=dev

kubectl get pods -n dev

-n: namespace

```

The Nautilus DevOps team has noticed performance issues in some Kubernetes-hosted applications due to resource constraints. To address this, they plan to set limits on resource utilization. Here are the details:


Create a pod named httpd-pod with a container named httpd-container. Use the httpd image with the latest tag (specify as httpd:latest). Set the following resource limits:

Requests: Memory: 15Mi, CPU: 100m

Limits: Memory: 20Mi, CPU: 100m

Note: The kubectl utility on jump_host is configured to operate with the

```bash

kubectl run httpd-pod --images=httpd:latest --restart=Never --dry-run=client -o yaml > httpd-pod.yaml

```

### remove any lines with empty values

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: httpd-pod
  labels:
    run: httpd-pod
spec:
  containers:
    - name: httpd-container
      image: httpd:latest
      resources:
        requests:
          memory: "15Mi"
          cpu: "100m"
        limits:
          memory: "20Mi"
          cpu: "100m"
  dnsPolicy: ClusterFirst
  restartPolicy: Never

  ```

  kubectl create -f httpd-pod yaml


## ROLLLING UPDATE
--------------------------------------------------------------------------------------------
An application currently running on the Kubernetes cluster employs the nginx web server. The Nautilus application development team has introduced some recent changes that need deployment. They've crafted an image nginx:1.18 with the latest updates.


Execute a rolling update for this application, integrating the nginx:1.18 image. The deployment is named nginx-deployment.

Ensure all pods are operational post-update.

Note: The kubectl utility on jump_host is set up to operate with the Kubernetes cluster


kubectl set image deployemen [deployment/(deployement name)] [cotainername]:[tag]
``` bash
kubectl get deployment

kubectl describe deployment nginx-deployment 

kubectl set image deployment deployment/nginx-deployment nginx-container=nginx:1.18

kubectl describe deployment nginx-deployment 
```
---------------------------------------------------------------------------------------------
Earlier today, the Nautilus DevOps team deployed a new release for an application. However, a customer has reported a bug related to this recent release. Consequently, the team aims to revert to the previous version.


There exists a deployment named nginx-deployment; initiate a rollback to the previous revision.

Note: The kubectl utility on jump_host is configured to interact with the Kubernetes cluster.


``` bash

#check the history first
kubectl rollout history deployement nginx-deployment


# run to undo rollout
kubectl rollout undo deployment nginx-deployment


kubectl rollout status deployment nginx-deployment 

```
------------------------------------------------------------------------------
### REPLICASET

The Nautilus DevOps team is gearing up to deploy applications on a Kubernetes cluster for migration purposes. A team member has been tasked with creating a ReplicaSet outlined below:



Create a ReplicaSet using nginx image with latest tag (ensure to specify as nginx:latest) and name it nginx-replicaset.


Apply labels: app as nginx_app, type as front-end.


Name the container nginx-container. Ensure the replica count is 4.


Note: The kubectl utility on jump_host is set up to interact with the Kubernetes cluster.


``` yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset
  labels: 
    app: nginx_app
    type: front-end
spec:
  replicas: 4
  selector:
    matchLabel:
      app: nginx_app
      type: front-end  
    template:
      metadata:
        labels:
          app: nginx_app
          type: front-end
      spec:
        containers:
          name: nginx-container
          image: nginx:latest

```

## cronJob


The Nautilus DevOps team is setting up recurring tasks on different schedules. Currently, they're developing scripts to be executed periodically. To kickstart the process, they're creating cron jobs in the Kubernetes cluster with placeholder commands. Follow the instructions below:



Create a cronjob named xfusion.


Set Its schedule to something like */12 * * * *. You can set any schedule for now.


Name the container cron-xfusion.


Utilize the httpd image with latest tag (specify as httpd:latest).


Execute the dummy command echo Welcome to xfusioncorp!.


Ensure the restart policy is OnFailure.


Note: The kubectl utility on jump_host is configured to work with the kubernetes cluster.


```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: xfusion
spec:
  schedule: "*/12 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: cron-xfusion
            image: httpd:latest
            command: ["echo", "Welcome to xfusioncorp!"]
          restartPolicy: OnFailure


```


The Nautilus DevOps team is crafting jobs in the Kubernetes cluster. While they're developing actual scripts/commands, they're currently setting up templates and testing jobs with dummy commands. Please create a job template as per details given below:


Create a job named countdown-devops.

The spec template should be named countdown-devops (under metadata), and the container should be named container-countdown-devops

Utilize image fedora with latest tag (ensure to specify as fedora:latest), and set the restart policy to Never.

Execute the command sleep 5

Note: The kubectl utility on jump_host is set up to operate with the Kubernetes cluster.











apiVersion: v1
kind: Pod
metadata:
  name: time-check
  namespace: nautilus
spec:
  containers:
    - name: time-check
      image: busybox:latest
      command: ["/bin/sh", "-c"]
      args:
        - while true; do date >> /opt/data/time/time-check.log; sleep $TIME_FREQ; done
      env:
        - name: TIME_FREQ
          valueFrom:
            configMapKeyRef:
              name: time-config
              key: TIME_FREQ
      volumeMounts:
        - name: log-volume
          mountPath: /opt/data/time
  volumes:
    - name: log-volume
      emptyDir: {}


###### We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. Investigate and rectify the issue:



The pod name is nginx-phpfpm and configmap name is nginx-config. Identify and fix the problem.


Once resolved, copy /home/thor/index.php file from the jump host to the nginx-container within the nginx document root. After this, you should be able to access the website using Website button on the top bar.


Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.

answer :
```bash
thor@jumphost ~$ kubectl logs nginx-phpfpm -c nginx-container
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2025/08/12 13:07:55 [error] 80#80: *1 directory index of "/var/www/html/" is forbidden, client: 10.244.0.1, server: _, request: "GET / HTTP/1.1", host: "30008-port-l7hscmek7dj7jrfn.labs.kodekloud.com", referrer: "https://l7hscmek7dj7jrfn.labs.kodekloud.com/"
10.244.0.1 - - [12/Aug/2025:13:07:55 +0000] "GET / HTTP/1.1" 403 555 "https://l7hscmek7dj7jrfn.labs.kodekloud.com/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0"
thor@jumphost ~$ kubectl logs nginx-phpfpm -c php-fpm-container
[12-Aug-2025 12:56:43] NOTICE: fpm is running, pid 1
[12-Aug-2025 12:56:43] NOTICE: ready to handle connections
```



