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
kubectl rollout history deployement nginx-deployment

kubectl rollout undo deployment nginx-deployment


kubectl rollout status deployment nginx-deployment 



```




